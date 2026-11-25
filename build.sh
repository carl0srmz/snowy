#!/usr/bin/env bash
# One-shot setup + build for the native port of Mission in Snowdriftland.
#
#   ./build.sh [--run] [--no-install] [--reconvert] [--dry-run]
#
# What it does, in order (each step is skipped when already done):
#   1. installs missing system packages (SDL2, FFmpeg, libclang, compiler) with apt / dnf / pacman / zypper / brew
#   2. installs Rust through rustup when `cargo` is missing
#   3. fetches the original game files (the .swf files + data/) into ./original
#   4. converts the original SWFs into native assets (./assets)
#   5. builds the game in release mode
#
#   --run          start the game when everything is built
#   --no-install   never install system packages or Rust (only check and report)
#   --reconvert    redo the asset conversion even if ./assets already exists
#   --dry-run      print what would be done, change nothing
#
# Environment: ORIGINAL=<dir> use an existing checkout of the original game files instead of ./original
set -euo pipefail
cd "$(dirname "$0")"

ORIGINAL_REPO="https://github.com/NinjaAdam/Mission-in-Snowdriftland"
ORIGINAL="${ORIGINAL:-original}"
RUN=0 INSTALL=1 RECONVERT=0 DRY=0
for a in "$@"; do
  case "$a" in
    --run) RUN=1 ;;
    --no-install) INSTALL=0 ;;
    --reconvert) RECONVERT=1 ;;
    --dry-run) DRY=1 ;;
    -h|--help) sed -n '2,20p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown option: $a (try --help)" >&2; exit 2 ;;
  esac
done

say() { printf '\033[1m==> %s\033[0m\n' "$*"; }
run() { if [ "$DRY" = 1 ]; then echo "[dry-run] $*"; else "$@"; fi; }
have() { command -v "$1" >/dev/null 2>&1; }
SUDO=""
if [ "$(id -u)" != 0 ] && have sudo; then SUDO="sudo"; fi

OS="$(uname -s)"
PM=""
if [ "$OS" = Darwin ]; then
  PM=brew
elif [ -r /etc/os-release ]; then
  . /etc/os-release
  case " ${ID:-} ${ID_LIKE:-} " in
    *" debian "*|*" ubuntu "*) PM=apt ;;
    *" fedora "*|*" rhel "*|*" centos "*) PM=dnf ;;
    *" arch "*) PM=pacman ;;
    *" suse "*|*" opensuse "*) PM=zypper ;;
  esac
fi

# ---------------------------------------------------------------- 1. system packages
has_libclang_in() {
  # true when directory $1 holds a libclang shared library
  compgen -G "$1/libclang.so" >/dev/null || compgen -G "$1/libclang-*.so*" >/dev/null \
    || compgen -G "$1/libclang.so.*" >/dev/null || compgen -G "$1/libclang.dylib" >/dev/null
}

libclang_dir() {
  local d
  if [ -n "${LIBCLANG_PATH:-}" ] && has_libclang_in "$LIBCLANG_PATH"; then
    echo "$LIBCLANG_PATH"; return 0
  fi
  if have llvm-config; then
    d="$(llvm-config --libdir 2>/dev/null || true)"
    if [ -n "$d" ] && has_libclang_in "$d"; then echo "$d"; return 0; fi
  fi
  for d in /usr/lib/llvm-*/lib /usr/lib64/llvm*/lib /usr/lib/llvm*/lib /usr/lib64 /usr/lib /usr/lib/*-linux-gnu \
           /usr/local/lib /opt/homebrew/opt/llvm/lib /usr/local/opt/llvm/lib /Library/Developer/CommandLineTools/usr/lib; do
    if has_libclang_in "$d"; then echo "$d"; return 0; fi
  done
  return 1
}

missing_deps() {
  local m=()
  have cc || have gcc || have clang || m+=("a C compiler")
  have pkg-config || m+=("pkg-config")
  have git || m+=("git")
  have curl || m+=("curl")
  libclang_dir >/dev/null || m+=("libclang")
  if have pkg-config; then
    pkg-config --exists sdl2 || m+=("SDL2")
    pkg-config --exists libavcodec libavformat libavutil libswscale libswresample || m+=("FFmpeg")
  fi
  echo "${m[*]:-}"
}

install_packages() {
  case "$PM" in
    apt)
      run $SUDO apt-get update
      run $SUDO apt-get install -y build-essential pkg-config git curl ca-certificates clang libclang-dev libsdl2-dev \
        libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libswresample-dev libavdevice-dev libavfilter-dev \
        libasound2-dev libvulkan1 mesa-vulkan-drivers ;;
    dnf)
      run $SUDO dnf install -y gcc gcc-c++ make pkgconf-pkg-config git curl clang clang-devel SDL2-devel ffmpeg-free-devel \
        vulkan-loader mesa-vulkan-drivers alsa-lib-devel ;;
    pacman)
      run $SUDO pacman -S --needed --noconfirm base-devel git curl clang sdl2 ffmpeg pkgconf vulkan-icd-loader ;;
    zypper)
      run $SUDO zypper --non-interactive install -t pattern devel_basis
      run $SUDO zypper --non-interactive install pkg-config git curl clang-devel libSDL2-devel ffmpeg-devel \
        libvulkan1 alsa-devel ;;
    brew)
      have brew || { echo "Homebrew is required on macOS: https://brew.sh" >&2; exit 1; }
      run brew install llvm sdl2 ffmpeg pkg-config git ;;
    *)
      echo "unsupported system: install a C compiler, pkg-config, git, curl, libclang, SDL2 and FFmpeg dev packages yourself." >&2
      return 1 ;;
  esac
}

say "checking system packages"
MISSING="$(missing_deps)"
if [ -n "$MISSING" ]; then
  echo "missing: $MISSING"
  if [ "$INSTALL" = 1 ]; then
    say "installing system packages (${PM:-unknown package manager}); sudo may ask for your password"
    install_packages
    [ "$DRY" = 1 ] || { MISSING="$(missing_deps)"; }
  fi
  if [ "$DRY" != 1 ] && [ -n "$MISSING" ]; then
    echo "still missing after setup: $MISSING" >&2
    echo "install them manually (see README) and run ./build.sh again." >&2
    exit 1
  fi
else
  echo "all system packages present"
fi

# bindgen (FFmpeg bindings) must be able to find libclang
if [ "$DRY" != 1 ]; then
  if d="$(libclang_dir)"; then export LIBCLANG_PATH="$d"; echo "libclang: $LIBCLANG_PATH"; fi
fi

# ---------------------------------------------------------------- 2. Rust
say "checking Rust"
if [ -r "$HOME/.cargo/env" ]; then . "$HOME/.cargo/env"; fi
if ! have cargo; then
  if [ "$INSTALL" = 1 ]; then
    say "installing Rust with rustup"
    if [ "$DRY" = 1 ]; then
      echo "[dry-run] curl https://sh.rustup.rs | sh -s -- -y --profile minimal"
    else
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal
      . "$HOME/.cargo/env"
    fi
  else
    echo "cargo not found: install Rust from https://rustup.rs" >&2
    exit 1
  fi
else
  echo "$(cargo --version)"
fi

# ---------------------------------------------------------------- 3. original game files
say "checking original game files"
if [ ! -f "$ORIGINAL/misnowdriftland_final.swf" ]; then
  if [ "$ORIGINAL" != original ]; then
    echo "ORIGINAL='$ORIGINAL' does not contain misnowdriftland_final.swf" >&2
    exit 1
  fi
  say "fetching the original game files into ./original (read-only clone)"
  run git clone --depth 1 "$ORIGINAL_REPO" original
else
  echo "found in $ORIGINAL"
fi

# ---------------------------------------------------------------- 4+5. build and convert
say "building (release)"
run cargo build --release
BIN="${CARGO_TARGET_DIR:-target}/release"

# the assets depend on the converter: redo them whenever its source changed
STAMP="$(cat tools/swfx/src/*.rs crates/fmt/src/*.rs | cksum | cut -d' ' -f1)"
if [ "$RECONVERT" = 1 ] || [ ! -f assets/scripts_index.txt ] || [ "$(cat assets/.converter 2>/dev/null)" != "$STAMP" ]; then
  say "converting the original Flash data into native assets (about 1 minute on many cores)"
  run rm -rf assets
  run "$BIN/swfx" convert "$ORIGINAL" assets
  [ "$DRY" = 1 ] || echo "$STAMP" > assets/.converter
else
  echo "assets/ are up to date (use --reconvert to redo)"
fi

say "done"
echo "run:  $BIN/snowdrift --assets assets --data $ORIGINAL"
if [ "$RUN" = 1 ] && [ "$DRY" != 1 ]; then
  exec "$BIN/snowdrift" --assets assets --data "$ORIGINAL"
fi
