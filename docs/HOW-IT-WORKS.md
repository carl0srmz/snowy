# How the port works

The original game is 45 Flash files: a main menu movie (`misnowdriftland_final.swf`), the game
engine (`gamestart.swf`), one library per world, the intro, the laboratory, the credits and the
sound banks. The port splits the work between a converter that runs once and a game that only
reads the converted files.

## The converter

`tools/swfx` reads every SWF and writes `assets/<name>/lib.bin`, PNG files for the bitmaps and WAV
files for the sounds.

- Shapes and morph shapes are tessellated into triangle meshes with lyon. Gradient and bitmap
  fills keep their matrices, so the GPU can draw them the way Flash did.
- Bitmaps are decoded from JPEG (with separate or shared tables), lossless and alpha formats.
- Sounds are decoded once. MP3 goes through Symphonia and ADPCM through a small decoder of our own.
  Both produce the same samples as FFmpeg. Like Flash, the encoder delay at the start of each MP3
  (`SeekSamples`) is dropped and the sound is cut to its declared length, so looping music has no
  gap.
- Text fields keep their embedded fonts as glyph meshes. The one field without embedded glyphs
  gets DejaVu Sans, converted the same way.
- Frame scripts are decompiled and lowered into a few simple operations (goto, play, stop,
  setting a variable, calling a method). Scripts that do more than that get an id, and the game
  has a handwritten version of each. There are 31 of them, listed in
  `assets/scripts_index.txt`.

The decompiler (`swfx dec`) also produced the files in `docs/decompiled`. They were the reference
for everything ported by hand.

## The game

`game/` is a single program built on SDL2 (window, input, audio), wgpu (graphics) and FFmpeg
(video).

The display list (`movie.rs`) follows Flash's rules: clips live at depths, have names and frame
labels, play and stop, and jump to frames. A jump to another clip moves it at once. A jump
backwards keeps the child clips that still exist at the target frame, so nested animations don't
restart. Clip events run in Flash's order (construct, initialize, load, enterFrame).

The level engine (`level.rs`) is a line-by-line port of the classes in `gamestart.swf`: tile
streaming in 480 x 360 cells, the scrolling camera, character physics, collision against obstacle
boxes, the hero, pickups, moving platforms, each enemy class and the El Pix fight. Where the
decompiled source was ambiguous, the bytecode decided. One example is `if (this.jumpcnt++ >
this.jumpstage)`, where the increment happens after the comparison. Getting that wrong made the
jump four times too low in an earlier version.

The menus, world map, laboratory, intro and credits (`ui.rs`, `lab.rs`, `intro.rs`, `scripts.rs`)
port the main movie's classes: Control, Worldmap, Upixo (the save game), Lab, Ticker and SoundFile.

## Graphics

Everything is drawn with wgpu on Vulkan, Metal or Direct3D 12, with 4x multisampling. Fills are
computed in a fragment shader, and masks use the stencil buffer. The blur and colour-matrix filters
in the intro are drawn into offscreen textures and filtered on the GPU. Vector art is drawn at the
window's resolution, so it stays sharp at any size.

The game logic runs at the original 34 frames per second. Drawing is separate and runs up to
240 frames per second by default (`--fps` changes the cap). At the start of each logic tick every
clip's matrix and colour transform are saved, and each drawn frame blends from the saved state to
the current one, by how far the clock is between the two ticks. That covers scrolling, characters,
tweens and fades. Some changes are cuts in the original and are not blended:

- a clip created during the tick, which has no earlier state to blend from;
- a sprite turning round (the sign of its scale flips), which would otherwise squash to zero
  width for a moment;
- a move of more than 150 pixels or a rotation of more than 60 degrees in one tick, such as a
  respawn or a background wrapping round;
- a colour or alpha change of more than half the range in one tick, such as a blink or a hit flash.

The swapchain uses mailbox presentation where the driver has it, so frames are never held back
by the display and don't tear. Frame pacing sleeps until shortly before each deadline and
spins for the rest, because a plain sleep can overshoot a 4 ms frame. Lab trailers pick their next
video frame on every drawn frame rather than every logic tick.

CPU cost per frame is under a millisecond (about 0.1 ms to walk the display list and 0.5 ms to
record the draws in a typical scene), so the cap and the GPU set the frame rate.

## Sound and video

Sounds are mixed in an SDL2 audio callback. At load time each sound is resampled to the device's
rate with a windowed-sinc filter, so the 11 and 22 kHz effects keep their high frequencies.

The laboratory's trailers are FLV files with VP6 video. They are decoded with FFmpeg on a separate
thread, and their MP3 audio track drives the video clock.

## Checking against the original

Three kinds of checks were used while porting:

- Headless runs. `snowdrift ui` and `snowdrift level` play scripted input without a window and
  save screenshots. Every level, the intro, the menus, the laboratory and the credits were run this
  way.
- Side-by-side screenshots with the original running in Ruffle, for the world map and menus.
- Sample-level comparison of every decoded sound with FFmpeg's output.
