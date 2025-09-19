# Practizer – User Manual (English, hands‑on)

> What is it?  
> Practizer helps you practice with audio files: load a song → adjust tempo/pitch → set markers → practice with loops → use the metronome & grid → save projects.  
> DAW‑like comfort without DAW complexity.

## Quick Start (5 steps)
1) Load a song: "Load…" (e.g., WAV/AIFF/MP3).
2) Play: Space bar.
3) Set a loop: Click at the desired spot → press A, let it run → press B → loop starts.
4) Tempo / Pitch: Move the sliders (Tempo 0.5–2.0× / Pitch ±12 semitones).
5) Save: "Save Project" (creates .practice.json – everything is restored next time).

---

## Contents
- [1. Installation & Launch](#1-installation--launch)
- [2. Supported Audio Formats](#2-supported-audio-formats)
- [3. UI Overview](#3-ui-overview)
- [4. Loading and Playing Audio](#4-loading-and-playing-audio)
- [5. Tempo & Pitch (DSP)](#5-tempo--pitch-dsp)
- [6. A/B Looping & Fine Adjustments](#6-ab-looping--fine-adjustments)
- [7. Markers: Add, Navigate, Import/Export](#7-markers-add-navigate-importexport)
- [8. Grid, BPM, Metronome, Tap Tempo, Beat Detection](#8-grid-bpm-metronome-tap-tempo-beat-detection)
- [9. Snap‑to‑Grid, Quantize, Humanize](#9-snap-to-grid-quantize-humanize)
- [10. Projects & Auto‑Project](#10-projects--auto-project)
- [11. Waveform: Zoom & Scroll](#11-waveform-zoom--scroll)
- [12. Keyboard Shortcuts](#12-keyboard-shortcuts)
- [13. Audio Settings](#13-audio-settings)
- [14. Accessibility](#14-accessibility)
- [15. Troubleshooting](#15-troubleshooting)
- [16. License Notes](#16-license-notes)
- [17. File Formats (JSON)](#17-file-formats-json)
- [18. Configuration & Locations](#18-configuration--locations)
- [19. Exercises (Vocal Warm‑ups)](#19-exercises-vocal-warm-ups)

---

## 1. Installation & Launch
Requirements: Java 21. JavaFX is bundled in the build. Runs on Windows, macOS, Linux.

Code signing / first launch
- macOS: Right‑click → Open → confirm. Or: System Settings → Privacy & Security → "Open Anyway".
- Windows: "Windows protected your PC" → More info → Run anyway.
- Linux: Packages are usually unsigned; confirm if prompted.

Launching from source
- macOS/Linux: `./gradlew run`
- Windows: `gradlew.bat run`

Native DSP (SoundTouch): already integrated. See README section "Build the native library" for details.

Tip: Create a project folder that contains the audio file(s) + `.practice.json`. This makes Auto‑Project easier.

---

## 2. Supported Audio Formats
- WAV, AIFF: native (JavaSound).
- MP3: via mp3spi/jlayer/tritonus‑share.
- Optional: FLAC (flacspi/JFLAC) and Ogg Vorbis (vorbisspi) if you add the JARs.
Check: "About & Licenses" shows which decoders are active in your build.

---

## 3. UI Overview
- Main bar: Load, Play/Pause, Set A/B, Clear Loop, Nudge (±), Import/Export (markers), Project Save/Load, About.
- Indicators: Filename, Tempo label, Pitch label, Loop label.
- Sliders: Tempo (0.5–2.0×), Pitch (−12…+12 semitones).
- Waveform: Playhead, Loop region, Markers, optional Grid, RMS line.
- Grid & Metronome: BPM, Beats/Bar, Tap, Detect BPM, Align Grid, Show Grid, Snap + Threshold (ms).
- DSP settings: Sequence / Seek Window / Overlap, Anti‑alias filter (+ length), DSP Help.
- About & Tools: About/Licenses, Diagnostics (System & Audio), Support/Donate (opens browser), Custom Scales…, Language (EN/DE).
- Accessibility: High‑contrast toggle.

Orientation tip: Everything about timing (Grid, Metronome, Tap, BPM) is grouped in the Grid block; everything about sound (Tempo/Pitch/DSP) lives in the DSP block.

---

## 4. Loading and Playing Audio
Load song: "Load…" → select file → waveform is built.  
Play/Pause: Space bar or button.  
Seek: Left‑click into the waveform → playback jumps there.
- Snap‑to‑Grid enabled? Clicks will snap if within the threshold.
- Holding Alt? Temporarily inverts the current snap behavior.

Device error? A dialog offers to open Audio Settings.

Workflow: A loop in 10 seconds  
Play → aim the position → left‑click → A → keep listening → B → done.

---

## 5. Tempo & Pitch (DSP)
- Tempo: 0.5×…2.0×
- Pitch: −12…+12 semitones (step 1 st)

Advanced (SoundTouch):
- Sequence (ms): Analysis unit length (default ~82 ms). Larger = more stable, but more latency.
- Seek Window (ms): Search window for overlap (default ~28 ms). Larger helps for extreme tempo changes.
- Overlap (ms): Crossfade distance (default ~12 ms).
- Anti‑alias filter: Recommended for pitch shifts; AA length (taps): larger = better high‑frequency suppression, more CPU/latency.

Recommendations:
- Moderate changes? Keep defaults.
- Extreme time‑stretching? Increase Seek Window a bit.
- Artifacts? Slightly increase Overlap, enable AA (for pitch).

---

## 6. A/B Looping & Fine Adjustments
Set:
- Keyboard: A = start, B = end.
- Directly in waveform: Shift + Right‑click = A, Shift + Alt + Right‑click = B.
- Alternatively: first click (seek), then buttons Set A/B.

Delete:
- Button Clear Loop (or L).
- Targeted: Ctrl/Cmd + Shift + Right‑click near A or B (hit tolerance ~6 px).

Fine nudges: The ± buttons move A/B in small steps; they optionally snap to grid (depending on Snap setting).

Precision tip: Enable Snap‑to‑Grid and keep Threshold small (e.g., 20–40 ms) for reliable snapping without unwanted jumps.

---

## 7. Markers: Add, Navigate, Import/Export
Add marker:
- Button Add Marker (at current time).
- Right‑click in waveform (with snap logic; Alt inverts).

Delete & move:
- Delete (waveform): Ctrl/Cmd + Right‑click on marker (~6 px tolerance).
- Move: Click and drag horizontally (snap applies; Alt inverts).
- List: Remove Marker deletes the selected entry.

Navigation:
- Goto Marker jumps to selection.
- Prev/Next cycles (wrap‑around) and updates the playhead.

Exchange:
- Export Markers: `{ "markers": [ … ] }` as JSON.
- Import Markers: JSON or a plain list of numbers (CSV/whitespace).

Practice tip: Place markers at verse/chorus starts. Use Quantize (see below) to align them exactly to the grid if needed.

---

## 8. Grid, BPM, Metronome, Tap Tempo, Beat Detection
- Show Grid: displays bars/beats.
- BPM / Beats per bar: set via spinners.
- Align Grid: aligns the phase (start offset) to the song (estimated via peaks).
- Metronome: start/stop; uses the set BPM & Beats/Bar; beat 1 is accented.
- Tap‑tempo (T): Tap along several times → BPM is calculated.
- Detect BPM: Analyzes the song and suggests BPM (optionally adds markers on peaks).

Workflow: Make the grid fit  
1) Tap‑tempo → rough BPM.  
2) Align Grid → adjust phase.  
3) If needed, tweak BPM slightly.

---

## 9. Snap‑to‑Grid, Quantize, Humanize
- Snap‑to‑Grid: Markers, loop points, and seek clicks snap if they are within the Snap Threshold (ms).
  - Holding Alt: temporarily inverts the current snap behavior.
- Quantize (Q): Shifts all markers to the nearest grid line. Strength (%) controls how strictly they are pulled. Preview shown (green dashes), apply with Apply.
  Note: Set sensible BPM beforehand – otherwise a hint dialog will appear.
- Humanize (H): Adds random timing deviations (±ms). Distribution: uniform/gaussian. Regenerate creates a new variant; preview available.

---

## 10. Projects & Auto‑Project
- Format: `*.practice.json` (versioned JSON with `schema` + `data`).
- Content: Audio path, markers, loop A/B, tempo, semitones, BPM, beats/bar, grid phase, selected DSP settings.
- Save/Load: Save Project / Load Project. Audio path is relative if possible (otherwise absolute).
- Auto‑Project: When you load an audio file, a `<audioName>.practice.json` in the same folder is automatically used/created.
- Audio checksum (SHA‑256): Saved on write → on load, a warning is shown if it differs.

Best practice: Keep audio & project side by side. This stabilizes relative paths – ideal for portability/backups.

---

## 11. Waveform: Zoom & Scroll
Display: filled min/max envelope, thin white RMS line, green playhead, red markers, blue transparent loop, gray grid.

MP3 gapless: LAME/Xing headers are honored; delay/padding are hidden, so start/end feel musically correct.

Interaction:
- Mouse wheel: zoom around cursor; with Shift = horizontal panning.
- Pan (drag): middle mouse button or Shift + Left‑click hold and drag.
- Double‑click (left): Zoom to Fit.
- Keys: `+`/`=` zoom in, `−` zoom out; Left/Right arrows scroll.
- Z: Zoom to Loop.

Click behavior (short):
- Left‑click: seek (with snap; Alt inverts).
- Right‑click: set marker (with snap; Alt inverts).
- Ctrl/Cmd + Right‑click: delete marker (nearby, ~6 px).
- Move marker: left‑click hold + drag (snap; Alt inverts).
- Loop directly: Shift + Right‑click = A, Shift + Alt + Right‑click = B.
- Delete loop point: Ctrl/Cmd + Shift + Right‑click near A/B.

Info: "horizontal panning" here means scrolling the waveform (not audio panorama).

Hover snap indicator: colored hint if a snap point is in range; tooltip reminds you of Alt to invert.

---

## 12. Keyboard Shortcuts
- Space: Play/Pause
- [ / ]: Tempo −/+ (−0.05 / +0.05)
- − / + (=): Pitch −/+ (semitones)
- A / B: Set loop point A/B
- L: Clear loop
- F: Zoom to Fit
- Z: Zoom to Loop
- N / P: Next / Previous marker (with wrap‑around)
- Q: Quantize dialog
- H: Humanize dialog
- T: Tap‑tempo
- S: Audio Settings
- In the waveform: `+`/`=` zoom in, `−` zoom out; Left/Right arrows scroll
Note: There are no dedicated ←/→ seek keys (use markers or clicking).

---

## 13. Audio Settings
Open: `S` or "Audio Settings" button (also appears automatically on errors).  
Output device: choose a mixer; `<System Default>` uses the system output.  
Buffer (ms): 20…2000 ms. Smaller = lower latency, but more prone to glitches.  
Storage: saved in user preferences (applies to player and metronome).

Practice tip: Start with 100–200 ms. Clicks/pops? Increase step by step. Latency too noticeable? Decrease.

---

## 14. Accessibility
High‑contrast: Toggle enables a high‑contrast theme including prominent focus rings. Setting is persisted.

---

## 15. Troubleshooting
No sound / device busy
- Open Audio Settings (S), choose a different output device or increase buffer size.
- Check if another program is using exclusive output.

MP3 seems offset at the beginning/end
- Display is gapless‑aware. With unusual headers the app falls back cautiously; visible duration may then equal raw duration.

Beat detection inaccurate
- Use Align Grid, fine‑tune BPM manually or use Tap‑tempo.

Artifacts with strong tempo changes
- Moderately increase Sequence/Seek Window, optionally adjust Overlap. For pitch shifts: enable Anti‑alias.

---

## 16. License Notes
- DSP: SoundTouch (LGPL‑2.1) via JNI (dynamically linked)
- MP3: mp3spi/jlayer/tritonus‑share (LGPL)
- Optional: flacspi/JFLAC (LGPL), vorbisspi (LGPL)
- Others: Dagger (Apache‑2.0), SLF4J, Logback, JavaFX (GPL + Classpath)
- Full list: in the dialog "About & Licenses" and `src/main/resources/licenses/THIRD_PARTY_NOTICES.txt`

Screenshots
- Overview: `docs/letitbe-app.png`
- Waveform comparison (Audacity‑like): `docs/letitbe-audacity.png`

Tips
- Save projects early.
- Enable Auto‑Project.
- Keep Snap Threshold small (more precise); increase for stricter timing.

---

## 17. File Formats (JSON)

### 17.1 Project file (`*.practice.json`)
Purpose: complete working state.  
Location: anywhere; recommended next to the audio. Auto‑Project creates `<audio>.practice.json`.  
Schema: versioned (`schema` + `data`).

Example
```json
{
  "schema": { "name": "practiceplayer.project", "version": 1 },
  "data": {
    "audioPath": "../songs/letitbe.mp3",
    "markers": [3.5, 10.25, 18.0],
    "loopA": 12.0,
    "loopB": 20.0,
    "audioChecksumSha256": "<hex>",
    "tempo": 1.0,
    "semitones": 0,
    "bpm": 100,
    "beatsPerBar": 4,
    "gridPhase": 0.0
  }
}
```

Details & compatibility
- `schema.name` = `"practiceplayer.project"`, `version` currently 1.
- `audioPath` relative if possible; otherwise absolute.
- Checksum: optional; shows a warning on load if it differs (does not abort).
- Older flat JSONs are still read; on save the new schema is written.

### 17.2 Marker sets (`*.markers.json`)
Minimal format:
```json
{ "markers": [1.25, 2.5, 5.0] }
```
Import also accepts plain lists of numbers (CSV/whitespace).

### 17.3 Waveform cache (`<audio>.peaks.json`)
Purpose: faster drawing + metadata. Created automatically.  
Deleting: harmless, it will be rebuilt.

Example (shortened)
```text
{
  "cacheVersion": 3,
  "algo": "minmax_rms_v1",
  "file": "letitbe.mp3",
  "lastModified": 1725612345678,
  "length": 54321012,
  "durationSec": 243.512,
  "pcmSampleRate": 44100,
  "pcmChannels": 2,
  "encoderDelaySamples": 1105,
  "encoderPaddingSamples": 2205,
  "peaksMin": [ /* … */ ],
  "peaksMax": [ /* … */ ]
}
```
Validation: name/mtime/length/version/algo & consistency must match; otherwise rebuild. Delay/Padding control the gapless display.

### 17.4 Exercises (`exercises.json`)
Purpose: save/load ad‑hoc exercises from the Exercises panel.

- Version 1: only built‑in scales. Example (shortened):
  ```json
  {
    "version": 1,
    "exercises": [ { "title": "Ad‑hoc", "scale": "MAJOR", "pattern": "1 2 3" } ]
  }
  ```
- Version 2: additionally an optional `customScale` block per entry when a custom scale is used:
  ```text
  {
    "version": 2,
    "exercises": [
      {
        "title": "Ad‑hoc",
        "scale": "MAJOR",
        "pattern": "1 2 3",
        "customScale": { "name": "Triad", "intervals": [0,3,7] }
      }
    ]
  }
  ```
- Compatibility: Older files (v1) remain valid; v2 is backward‑compatible since the built‑in fields are unchanged.

VCS note: Project and marker files version well; `.peaks.json` is large and reproducible, consider excluding it.

---

## 18. Configuration & Locations
What is global, what is per project?

### 18.1 UI/DSP prefs (global, per user)
- Java Preferences (`app.service.ConfigService`)
- Keys (excerpt):
  - `ui.theme.highContrast` (bool)
  - `dsp.tempo` (double), `dsp.pitchSemitones` (int)
  - `dsp.seqMs`, `dsp.seekMs`, `dsp.overlapMs` (int)
  - `dsp.aa.enabled` (bool), `dsp.aa.len` (int)
  - `ui.grid.snap.enabled`, `ui.grid.snap.ms`, `ui.grid.show` (bool/int)
  - `ui.autoProject` (bool)
  - `user.scales.json` (string, JSON payload of custom scales)

Precedence rule (tempo/pitch):
- With a project loaded: values from the project file apply.
- Without a project: app uses the last globally saved values.
- Moving a slider: writes immediately to preferences; to the project file only if one already exists.

### 18.2 Audio device/buffer
- Also Java Preferences (controller package):
  - `audio.output.mixer` (string or `null` = System Default)
  - `audio.output.bufferMs` (int)

### 18.3 Locations (platform‑dependent)
- Windows: Registry `HKCU\Software\JavaSoft\Prefs\…`
- macOS: `~/Library/Preferences/…` (depends on JDK)
- Linux/Unix: `~/.java/.userPrefs/…/prefs.xml`

### 18.4 Project vs. app prefs (short)
- Project: markers, loop A/B, tempo, pitch, BPM, grid phase, audio path, checksum.
- App prefs: global UI/DSP defaults, high‑contrast, snap settings, Auto‑Project.

### 18.5 Reset
- Advanced: delete selectively via registry/prefs file (no "Reset" button in the app).

---

## 19. Exercises (Vocal Warm‑ups)

Goal: Quickly define a pattern, choose key/scale/BPM, transpose over a range – and play as a pure sine exercise or export as WAV. Runs on its own audio path, not in parallel to the song (UI prevents double play).

Controls
- Pattern: text field (DSL, see below), e.g. `1 2 3 4 5 4 3 2 1`
- Key (MIDI): e.g. 60 = C4
- Scale: MAJOR, NAT_MINOR, HARM_MINOR + optional custom scales
- BPM: 1 token = 1 beat
- Range (min/max/step): transpose over MIDI span (e.g., 57..76, step=1)
- Repeat: number of complete range passes
- Sound: MVP `SINE` (planned: TRIANGLE/SQUARE)
- Presets: common patterns (1‑5‑1, thirds, arpeggio, chromatic, siren)
- Metronome click: optional, beat 1 accented
- Play/Stop: start/stop the exercise (song playback is disabled then)
- Save/Load Exercises…: save/load `exercises.json`
- Export WAV…: 48 kHz/16‑bit/mono (metronome click is not embedded)

Pattern DSL
- Tokens: `1..7` = scale degrees, `-` = hold (extends previous note by 1 beat), `|` = bar line (visual)
- Octave shift: `^` = +12 st, `_` = −12 st (repeatable, e.g. `^^3`)
- Rhythm (MVP): 1 token = 1 beat

Live changes  
Pattern, BPM, key, scale, range, repeat, sound take effect immediately (internally a short restart, ~120 ms debounce). Fades prevent clicks.

WAV export  
Exports the current exercise incl. range/repeat (mono 48 kHz/16‑bit). Metronome is not rendered.

Custom Scales
- Open: In "About & Tools" click "Custom Scales…".
- Create:
  1) Give it a name (e.g., "My Jazz Scale").
  2) Enter intervals as semitones from root, comma‑separated, e.g., `0,2,3,5,7,9,11`.
  3) Save – the scale appears in the list.
- Delete: select an entry → "Delete selected".
- Use:
  - The scale selection in Exercises shows built‑in scales and below that the section "— Custom Scales —" with entries `custom:{Name}`.
  - Choose such an entry to play/export the exercise with your scale.
  - Custom scales are stored globally (user settings), so they are available in all projects.
- Notes: Values are integers; empty inputs are rejected.

Save/load exercises with custom scales
- Save (Save Exercises…):
  - Without a custom scale, an `exercises.json` is written in schema version 1.
  - If a custom scale is selected, an additional block
    ```text
    "customScale": { "name": "…", "intervals": [0,3,7] }
    ```
    is stored; the file then uses `"version": 2`.
- Load (Load Exercises…):
  - Files with `customScale` are detected. The scale is added to your Custom Scales (if not already present) and selected in the scale dropdown.
  - Files without `customScale` behave as before (built‑in scales).
- Compatibility: Version‑1 files remain valid; version‑2 files add the `customScale` block for full backward compatibility.

Exercise troubleshooting
- Hear nothing? Is the song still playing → stop it; then start the exercise.
- Clicks/pops? Increase buffer or reduce BPM.
- Pattern error? Only use `1..7`, `-`, `|`, optionally `^/_` as prefixes.

Tip: Start with preset "1‑5‑1", then adapt key/BPM/range to your voice.

---

## What has been improved?
- Workflows instead of just features (Quick Start, Loop in 10 seconds, grid calibration).
- Concrete tips/recommendations directly alongside parameters.
- Clearer snap/Alt logic (phrased consistently everywhere).
- Troubleshooting uses "if‑then" phrasing.
- Beginner‑friendly explanations (term clarifications, MP3 gapless).

Attachments (optional)
- Screenshots
  - `docs/letitbe-app.png` (overview)
  - `docs/letitbe-audacity.png` (waveform comparison)
