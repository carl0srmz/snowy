# Mission in Snowdriftland: native port

A native (Rust) port of the Flash game. No Ruffle, no browser, no WebView, no script VM. The
original `.swf` files are converted once into plain native data (`assets/`), and all game
and menu logic is re-implemented in Rust from the recovered original ActionScript.

Everything in the original is included: intro, world map with the 25 doors, all 25 levels, every
enemy and the El Pix boss, hearts/crystals/heart containers, save data, help / feedback /
impressum / credits, the laboratory with its promo info texts, screenshots, FLV videos and
downloads, and the four languages (English, German, French, Dutch).

## Build and run

Requirements: Rust (stable), SDL2 (`libsdl2-dev`), FFmpeg dev libs (`libavcodec-dev` etc.),
`libclang`, and a GPU/driver with Vulkan, Metal or DX12.

This repository contains only the port. The original game files are an input: get a checkout of
https://github.com/NinjaAdam/Mission-in-Snowdriftland (the `.swf` files and its `data/` folder).

```bash
git clone https://github.com/NinjaAdam/Mission-in-Snowdriftland original
ORIGINAL=original ./build.sh            # convert all SWFs -> assets/, build release binaries
./target/release/snowdrift --assets assets --data original
```

`--data` is the folder holding the original game files (the promo downloads, videos and
screenshots are read from `data/` there; they are not duplicated into `assets/`).

| Option | Meaning |
|---|---|
| `--lang en\|de\|fr\|nl` | language (default: system language) |
| `--level N` | jump straight into level 1-25 (the world map is skipped) |
| `--fullscreen` | start fullscreen (`F11` / `Alt+Enter` toggles at any time) |
| `--mute` | no audio |
| `--unlock-all` | open every door (for testing, does not touch your save) |
| `--debug` | show the original's hidden debug "cookie" button on the world map |
| `--seconds N` | quit after N seconds (smoke tests) |

Controls: the mouse drives all menus and the world map. In a level: arrows / `WASD` / `Space`
move and jump. `Esc` goes back to the world map (and quits from the world map); in the lab it
closes the lab. Gamepad: D-pad or left stick to move, `A`/`B` to jump.

Save data (intro seen, visited doors, hearts containers, laboratory unlocks) is a small JSON file in
`$SNOWDRIFT_DATA`, else `$XDG_DATA_HOME/snowdrift`, `%APPDATA%\snowdrift` or
`~/.local/share/snowdrift`. Downloads from the lab are copied to `~/Downloads`. Feedback written in
the feedback form is stored locally as `feedback.txt` next to the save file (the original posted it
to a web server that no longer exists).

## Layout

| Path | What |
|---|---|
| `crates/fmt` | native asset format (tessellated vector meshes, timelines, text, sounds) |
| `tools/swfx` | converter + developer tools (`convert`, `dec` AVM1 decompiler, `info`, `dis`, `features`) |
| `game` | the game: wgpu renderer, display tree, text engine, audio, video, levels, UI, window |
| `docs/decompiled` | readable decompilation of the original ActionScript (reference for the port) |

## How it uses the hardware

* **GPU**: all art is converted to triangle meshes (lyon) and drawn with wgpu (Vulkan / Metal / DX12)
  with 4x MSAA, gradient/bitmap fills in shaders, stencil-buffer masks, and vector art that stays
  sharp at any resolution or fullscreen. Draw parameters are batched in one storage buffer.
  Display-list filters (the intro's blur and colour-matrix effects) run as offscreen GPU passes.
* **CPU**: converter and bitmap decoding run on all cores (rayon); video decoding runs on its own
  thread (FFmpeg, VP6/FLV); logic runs at the original fixed 34 Hz and rendering is interpolated at
  the display refresh rate (vsync), so scrolling is smooth on 60/144 Hz screens.
* **Audio**: SDL2 callback mixer, all sounds pre-decoded to PCM by the converter, video audio
  decoded natively and used as the video's clock.
* **Input**: keyboard, mouse and gamepads (SDL2 game controller API).

## What the port is made of

* a converter for all 45 SWFs: vector art, gradients, bitmaps (JPEG/lossless/alpha), morph shapes,
  fonts, static and dynamic text, buttons with their actions, timelines, filters, sounds
  (MP3/ADPCM -> PCM)
* a Flash-semantics display tree (depths, names, labels, play/stop/goto, attachMovie, clip events,
  masks) that runs the original timelines unchanged
* a port of the `gamestart.swf` engine: tile streaming, scrolling camera, character physics,
  collision, hero rules, pickups, moving platforms, every enemy type (Pinku, Speedy, Tree, Mom,
  Joggybear with iceballs, Pinku stacks, spiders, Snow Spider, eagle, runner, web) and the El Pix
  boss fight
* a port of the UI classes (Control, Worldmap, Upixo, Lab, Ticker, SoundFile) and the 31 complex
  timeline scripts (`docs/decompiled/script_behaviours_index.txt`)

## Verification

Run headlessly against the real data: all 25 levels run through the full UI path without errors
(movement scripts, enemies, goal), the boss fight (arena, ship entrance, thrown Pinkus, hearts), the
world map with played/open/closed doors, the lab (list, greeting tickers, info with artwork,
screenshots with counter, FLV video playback), help / feedback / impressum / credits, the intro
(play and skip, with its filters), all four languages, and a windowed run under Xvfb.

Developer drivers: `snowdrift ui <assets> <repo> --script "tick:60;click:x,y;shot:out.png;..."`,
`snowdrift level <assets> <repo> N --script ...`, `snowdrift shot`, `snowdrift tree`.

## Deliberate deviations from the Flash original

* The original's `Ticker` dropped the first character of each text and `fadeIn()` without a delay
  never faded in; both are fixed here.
* The lab's invisible blocker button stays disabled (it only existed to swallow clicks while
  loading).
* Online-only features (feedback upload, external links) save locally / open in the system browser.
* Vector art is rendered at the window resolution instead of the SWF's fixed 900x578 raster.
