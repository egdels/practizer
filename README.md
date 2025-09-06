# Practizer (JavaFX + Dagger + SoundTouch)

<p align="center">
  <img src="packaging/practizer_256x256.png" alt="Practizer Logo" width="160" height="160">
</p>

Cross‑platform music practice app starter: load an audio file, change tempo (speed) and pitch (key) independently, and play it back.
Tech stack: **Java 21, JavaFX, Dagger 2, Gradle, SoundTouch (JNI)**.

• Deutsch: Ausführliches Benutzerhandbuch → docs/Benutzerhandbuch_DE.md

> ⚖️ **Licensing note**: Audio time‑stretch/pitch uses **SoundTouch** (LGPL‑2.1) via JNI. MP3 decoding uses **mp3spi/jlayer/tritonus‑share** (LGPL). See “Licenses” and the About dialog for details.

> 🔎 **License check/report**: The build generates a current THIRD_PARTY_NOTICES.txt from dependencies and packages it (About dialog shows it). You can also run: `./gradlew generateLicenseReport`. A static fallback exists at `src/main/resources/licenses/THIRD_PARTY_NOTICES.txt`.

## Build & run

```bash
# Generate Gradle wrapper (first run only)
gradle wrapper

# macOS/Linux
./gradlew run

# Windows
gradlew.bat run
```

## Packaging tips

- Add `org.beryx.runtime` or `org.beryx.jlink` plugin for jlink/jpackage native bundles later.
- For best audio latency tweak buffer sizes in `AudioEngine` (see constants).

## Supported formats (Support Matrix)

Detected at runtime (About dialog), typically:

- WAV: Yes (JavaSound built‑in)
- AIFF: Yes (JavaSound built‑in)
- MP3: Yes (via JavaSound SPI: mp3spi/jlayer/tritonus‑share)
- FLAC: Optional (via JavaSound SPI: flacspi/JFLAC)
- Ogg Vorbis: Optional (via JavaSound SPI: vorbisspi)

Notes:
- MP3 support is provided by LGPL libraries included on the classpath. You may remove them if you don’t need MP3, or replace them with compatible builds to satisfy LGPL relinking.
- FLAC and Ogg Vorbis can be enabled by adding the corresponding JavaSound SPI JARs (LGPL). The About dialog shows whether they’re detected at runtime.
- Decoding uses JavaSound; processing (tempo/pitch) is via SoundTouch JNI (LGPL) dynamically loaded per platform.
- JavaFX MediaPlayer is not used in the DSP path.



## New in this build
- **A/B Looping:** Set A/B at the current playhead; playback restarts at A when reaching B.
- **Hotkeys:**
  - Space = play/pause
  - `[` / `]` = tempo −/+ (−0.05/+0.05)
  - `-` / `+` = pitch −/+ (semitone)
  - `A` / `B` = set loop points
  - `L` = clear loop



## Features added
- **Waveform view:** zoomable waveform with playhead, A/B overlay, and marker lines.
- **Markers:** add/remove/jump; also shown on waveform.
- **A/B fine‑tuning:** ±0.1 s nudge for A and B.
- **Metronome:** adjustable BPM and beats‑per‑bar with accented first beat.

### Shortcuts recap
Space = play/pause • `[`/`]` tempo −/+ • `-`/`+` semitone −/+ • A/B set loop points • L clear loop


## New: Tap‑Tempo, Beat‑Detection, Marker Export/Import, N/P navigation
- **Tap‑Tempo:** hit *Tap* or press **T** → BPM updates the metronome.
- **Beat‑Detection:** one‑click BPM estimate; optional beat markers are added.
- **Markers Export/Import:** simple JSON with markers, A/B, tempo, semitones.
- **Multi‑marker Nav:** **N** = next, **P** = previous marker (wraps around).


## New: Project persistence & Snap‑to‑Grid
- **Save/Load Project** (`*.practice.json`): speichert Audio‑Pfad, Marker, A/B‑Loop, Tempo, Semitones, BPM/Beats und Grid‑Phase.
- **Snap‑to‑Grid:** Marker, Loop‑Punkte, Nudges und Seek klicken optional auf die nächstliegende Grid‑Linie (BPM + Phase). Toggle im **Project**‑Panel.
- **Autosave light:** Änderungen an Tempo/Pitch/BPM/Beats/Loop/Markers triggern ein Save (falls bereits ein Projektpfad gewählt wurde).


## New: Snap‑Intensity, Quantize/Humanize, Auto‑project file
- **Snap‑Intensity (ms):** nur snappen, wenn die Distanz zur Grid‑Linie ≤ Schwelle (0 = kein Zwangs‑Snap).
- **Quantize to Grid (Q):** verschiebt alle Marker auf die nächstliegenden Grid‑Linien (mit deiner Snap‑Intensity als „Härte“ beim Setzen, Quantize ist hart).
- **Humanize (H):** fügt zufälliges Timing‑Jitter ±X ms hinzu (X = Snap‑Intensity), damit Loops natürlicher wirken.
- **Auto‑Project neben Audio:** bei „Load…“ wird automatisch `<audioName>.practice.json` im selben Ordner verwendet/aktualisiert (abschaltbar).


## LGPL DSP Pipeline (SoundTouch via JNI)
The app uses **SoundTouch** (LGPL-2.1) through a tiny JNI bridge.

### Build the native library
Requirements: CMake ≥ 3.16, a C++ toolchain, and internet (FetchContent grabs SoundTouch).
```bash
cd native/soundtouch-jni
./build.sh
```
This copies the resulting shared library to `src/main/resources/natives/<os>/<arch>/` so the app can `System.load()` it at runtime.

### Notes
- Processing is **tempo + pitch** (independent). We adjust parameters live.
- Decoding uses JavaSound (WAV/AIFF; MP3 via SPI already in `build.gradle.kts`).
- License changes: app can now be shipped under a permissive/commercial license (respecting LGPL for SoundTouch — dynamic linking via JNI).


## CI (GitHub Actions)
The repo includes `.github/workflows/build.yml` which:
- Builds the JNI (SoundTouch) on **Linux/macOS/Windows** (Temurin JDK 21).
- Copies the native `.so/.dylib/.dll` into `src/main/resources/natives/<os>/<arch>/`.
- Runs `./gradlew clean build` and uploads artifacts (jar + natives).

## Advanced DSP Settings
Adjust **SoundTouch** parameters live:
- **Sequence (ms)** – analysis sequence length (default 82)
- **Seek Window (ms)** – seeking window size (default 28)
- **Overlap (ms)** – overlap length (default 12)
- **Anti‑Alias Filter** (on/off) and **Filter Length**
These are wired to JNI (`setSetting`) and persisted in the project file.


## Release workflow
- Tag mit SemVer (`vX.Y.Z`) pushen → CI baut JNI & Gradle auf allen Plattformen, kombiniert macOS **arm64/x64** zu einem **universal** Native-Paket, und erstellt einen **GitHub Release** mit JAR + Native‑Tarballs als Assets.
- Falls Natives lokal fehlen, zeigt die App beim Start einen Dialog mit Hinweisen (Build-Skript / CI‑Artefakte).


## Automated Release Notes & Installers
- **Release notes**: Generated from Conventional Commits and used as body of the GitHub Release.
- **Installers** (via `org.beryx.jlink`/`jpackage`):
  - Linux: `.deb/.rpm` or app image
  - macOS: `.dmg` (codesign if identity provided; CI will notarize & staple if credentials are set)
  - Windows: `.exe/.msi` (code-signed if keystore/alias provided)

### Required GitHub Secrets (optional but recommended)
- **macOS Signing/Notarization**
  - `MACOS_IDENTITY` — codesign identity name (e.g., `Developer ID Application: Your Name (TEAMID)`)
  - `MACOS_BUNDLE_PREFIX` — bundle prefix, e.g., `com.yourorg`
  - `MACOS_NOTARY_APPLE_ID` — Apple ID email
  - `MACOS_NOTARY_APP_PWD` — app-specific password (not Apple ID password)
  - `MACOS_NOTARY_TEAM_ID` — 10-char Team ID
- **Windows Code Signing**
  - `WIN_SIGN_KEYSTORE` — path to or Base64-decoded path of a PFX/P12 placed via a prior step (or use self-hosted runner)
  - `WIN_SIGN_KS_PASS`, `WIN_SIGN_KEY_ALIAS`, `WIN_SIGN_KEY_PASS`

> Hinweis: Für Windows kann alternativ nach dem `jpackage`-Build via `signtool` signiert werden; hier nutzen wir die integrierten `--win-signing-*` Optionen.



## Linux package signing & multi‑arch
- **deb/rpm** werden unter Ubuntu gebaut; wenn `LINUX_GPG_PRIVATE_KEY` (Base64) + `LINUX_GPG_PASSPHRASE` verfügbar sind, werden sie signiert.
- **arm64 Natives**: separater Job baut `libsoundtouchjni.so` mit **dockcross/linux‑arm64**; Asset `natives-linux-arm64.tar.gz`.

## macOS Keychain‑Import (Codesign)
- Secrets: `MACOS_CERT_P12` (Base64 .p12), `MACOS_CERT_PWD`, `MACOS_KEYCHAIN_PASS`. Zusammen mit `MACOS_IDENTITY` wird das jpackage‑Bundle signiert; Notarization wie zuvor.

## Windows Codesigning
- Optional: `WIN_SIGN_KEYSTORE_B64` (Base64 .pfx). Workflow decodiert und setzt `WIN_SIGN_KEYSTORE` automatisch.


## 1.0‑RC additions
- **Dagger DI**: AppComponent + AppModule; FXMLLoader nutzt ControllerFactory.
- **MP3 Frame Index**: JLayer-basierte Indizierung → präzisere, schnellere Seeks bei MP3.
- **Loop Crossfade**: sanfter B→A‑Übergang (standard 12 ms), per Code verstellbar.
- **About/Notices**: Dialog + `THIRD_PARTY_NOTICES.txt`.
- **Logging**: Rollierendes File-Log unter `~/.practizer/app.log`.
