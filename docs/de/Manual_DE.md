# Practizer – Benutzerhandbuch (Deutsch, praxisorientiert)

> **Worum geht’s?**  
> Practizer hilft dir beim Üben mit Audiodateien: **Song laden → Tempo/Tonhöhe anpassen → Stellen markieren → Loops üben → Metronom & Grid nutzen → Projekte speichern**.  
> Klingt nach DAW-Komfort, ohne DAW-Komplexität.

## Schnellstart (5 Schritte)
1) **Song laden:** `Load…` (z. B. WAV/AIFF/MP3).
2) **Abspielen:** Leertaste.
3) **Loop setzen:** An gewünschte Stelle klicken → `A` drücken, weiterlaufen lassen → `B` drücken → Loop startet.
4) **Tempo / Tonhöhe:** Regler bewegen (Tempo 0,5–2,0× / Tonhöhe ±12 HT).
5) **Speichern:** `Save Project` (legt `.practice.json` an – alles ist beim nächsten Mal wieder da).

---

## Inhalt
- [1. Installation & Start](#1-installation--start)
- [2. Unterstützte Audioformate](#2-unterstützte-audioformate)
- [3. Oberfläche im Überblick](#3-oberfläche-im-überblick)
- [4. Audio laden und abspielen](#4-audio-laden-und-abspielen)
- [5. Tempo & Tonhöhe (DSP)](#5-tempo--tonhöhe-dsp)
- [6. A/B-Looping & Feinjustage](#6-ab-looping--feinjustage)
- [7. Marker: Setzen, Navigieren, Import/Export](#7-marker-setzen-navigieren-importexport)
- [8. Grid, BPM, Metronom, Tap-Tempo, Beat-Erkennung](#8-grid-bpm-metronom-tap-tempo-beat-erkkennung)
- [9. Snap-to-Grid, Quantize, Humanize](#9-snap-to-grid-quantize-humanize)
- [10. Projekte & Auto-Project](#10-projekte--auto-project)
- [11. Wellenform: Zoom & Scroll](#11-wellenform-zoom--scroll)
- [12. Tastaturkürzel](#12-tastaturkürzel)
- [13. Audio-Einstellungen](#13-audio-einstellungen)
- [14. Barrierefreiheit](#14-barrierefreiheit)
- [15. Fehlerbehebung](#15-fehlerbehebung)
- [16. Lizenzhinweise](#16-lizenzhinweise)
- [17. Dateiformate (JSON)](#17-dateiformate-json)
- [18. Konfiguration & Speicherorte](#18-konfiguration--speicherorte)
- [19. Übungen (Einsingen)](#19-übungen-einsingen)

---

## 1. Installation & Start
**Voraussetzungen:** Java 21. JavaFX ist im Build enthalten. Läuft auf Windows, macOS, Linux.

**Code-Signing/Erststart**
- **macOS:** Rechtsklick → **Öffnen** → bestätigen. Oder: Systemeinstellungen → Datenschutz & Sicherheit → „Dennoch öffnen“.
- **Windows:** „Windows hat Ihren PC geschützt“ → **Weitere Informationen** → **Trotzdem ausführen**.
- **Linux:** Pakete sind in der Regel unsigniert; ggf. Bestätigung.

**Start aus dem Quellcode**
- macOS/Linux: `./gradlew run`
- Windows: `gradlew.bat run`

**Native DSP (SoundTouch):** bereits eingebunden. Details siehe README-Abschnitt „Build the native library“.

> 💡 **Tipp:** Lege einen Projektordner an, in dem Audio + `.practice.json` zusammenliegen. Das erleichtert Auto-Project.

---

## 2. Unterstützte Audioformate
- **WAV, AIFF:** nativ (JavaSound).
- **MP3:** über `mp3spi/jlayer/tritonus-share`.
- **Optional:** **FLAC** (flacspi/JFLAC) und **Ogg Vorbis** (vorbisspi), wenn JARs hinzugefügt werden.
> **Überprüfen:** „About & Licenses“ zeigt, welche Decoder in **deinem Build** aktiv sind.

---

## 3. Oberfläche im Überblick
- **Hauptleiste:** Load, Play/Pause, Set A/B, Clear Loop, Nudge (±), Import/Export (Marker), Project Save/Load, About.
- **Anzeigen:** Dateiname, Tempo-Label, Pitch-Label, Loop-Label.
- **Regler:** Tempo (0,5–2,0×), Tonhöhe (−12…+12 HT).
- **Wellenform:** Playhead, Loop-Bereich, Marker, optionales Grid, RMS-Linie.
- **Grid & Metronom:** BPM, Beats/Bar, **Tap**, **Detect BPM**, **Align Grid**, **Show Grid**, **Snap** + **Threshold (ms)**.
- **DSP-Einstellungen:** Sequence / Seek Window / Overlap, Anti-Alias Filter (+ Länge), **DSP Help**.
- **About & Werkzeuge:** About/Lizenzen, **Diagnose** (System & Audio), **Unterstützen/Spenden** (öffnet Browser), **Eigene Skalen…** (Skalen-Manager), **Sprache** (EN/DE).
- **Barrierefreiheit:** High-Contrast-Schalter.

> 💡 **Orientierung:** Alles, was **Timing** betrifft (Grid, Metronom, Tap, BPM), sitzt im Grid-Block; alles, was **Klang** betrifft (Tempo/Tonhöhe/DSP), im DSP-Block.

---

## 4. Audio laden und abspielen
**Song laden:** `Load…` → Datei auswählen → Wellenform baut sich auf.  
**Abspielen/Pause:** Leertaste oder Button.  
**Springen/Seek:** In die Wellenform **links klicken** → Wiedergabe springt dahin.
- **Snap-to-Grid aktiv?** Dann wird bei Klick **eingerastet**, wenn innerhalb der Schwelle.
- **Alt** gedrückt hält? **Invertiert** das aktuelle Snap-Verhalten.

**Gerätefehler?** Dialog bietet **Audio-Einstellungen** an.

> 🧭 **Workflow: Loop in 10 Sekunden**  
> Spielen → Stelle anvisieren → Linksklick → `A` → weiter hören → `B` → fertig.

---

## 5. Tempo & Tonhöhe (DSP)
- **Tempo:** 0,5×…2,0×
- **Tonhöhe:** −12…+12 Halbtöne (Schrittweite 1 HT)

**Erweitert (SoundTouch):**
- **Sequence (ms):** Länge der Analyseeinheit (Standard ~82 ms). Größer = stabiler, aber mehr Latenz.
- **Seek Window (ms):** Suchfenster fürs Überlappen (Standard ~28 ms). Größer hilft bei extremen Tempoänderungen.
- **Overlap (ms):** Crossfade-Laufweite (Standard ~12 ms).
- **Anti-Alias Filter:** Bei Pitch-Shifts empfohlen; **AA-Länge (Taps)**: größer = bessere Höhenunterdrückung, mehr CPU/Latenz.

> 💡 **Empfehlung:**
> - Moderate Änderungen? **Standardwerte** lassen.
> - Extreme Zeitdehnungen? **Seek Window** etwas erhöhen.
> - Artifacts? **Overlap** leicht erhöhen, **AA** aktivieren (bei Pitch).

---

## 6. A/B-Looping & Feinjustage
**Setzen:**
- Tastatur: `A` = Start, `B` = Ende.
- Direkt in der Wellenform: **Shift + Rechtsklick** = A, **Shift + Alt + Rechtsklick** = B.
- Alternativ: erst **klicken** (Seek), dann Buttons **Set A/B**.

**Löschen:**
- Button **Clear Loop** (oder `L`).
- Gezielt: **Strg/Cmd + Shift + Rechtsklick** nahe A oder B (Treffertoleranz ~6 px).

**Fein-Nudges:** ±-Buttons verschieben A/B in kleinen Schritten; greifen optional am Grid (abhängig von Snap).

> 💡 **Präzision:** **Snap-to-Grid** aktivieren und **Threshold** klein halten (z. B. 20–40 ms) – so rastest du zuverlässig ohne ungewollte Sprünge.

---

## 7. Marker: Setzen, Navigieren, Import/Export
**Marker hinzufügen:**
- Button **Add Marker** (an aktueller Zeit).
- **Rechtsklick** in der Wellenform (mit Snap-Logik; **Alt** invertiert).

**Löschen & Verschieben:**
- Löschen (Wellenform): **Strg/Cmd + Rechtsklick** auf Marker (~6 px Toleranz).
- Verschieben: **Linksklick halten** und horizontal ziehen (Snap greift; **Alt** invertiert).
- Liste: **Remove Marker** löscht den ausgewählten Eintrag.

**Navigation:**
- **Goto Marker** springt zur Auswahl.
- **Prev/Next** blättert (Wrap-Around) und setzt die Abspielposition.

**Austausch:**
- **Export Markers:** `{ "markers": [ … ] }` als JSON.
- **Import Markers:** JSON oder einfache Zahlenliste (CSV/Whitespace).

> 💡 **Praxis:** Lege Marker z. B. auf **Vers-/Refrain-Anfänge**. Mit **Quantize** (siehe unten) bringst du die Markierungen bei Bedarf exakt aufs Grid.

---

## 8. Grid, BPM, Metronom, Tap-Tempo, Beat-Erkennung
- **Show Grid:** blendet Takte/Beats ein.
- **BPM / Beats-pro-Takt:** über Spinner einstellen.
- **Align Grid:** richtet die **Phase** (Startversatz) am Song aus (erkannt über Peaks).
- **Metronom:** Start/Stop; nutzt die eingestellten BPM & Beats/Bar; Schlag 1 akzentuiert.
- **Tap-Tempo (`T`):** Mehrfach im Takt tippen → BPM werden berechnet.
- **Detect BPM:** Analysiert den Song und schlägt BPM vor (optional Marker auf Peaks).

> 💡 **Workflow: Grid passend machen**
> 1) **Tap-Tempo** → grobe BPM.
> 2) **Align Grid** → Phase justieren.
> 3) Bei Bedarf BPM leicht nachregeln.

---

## 9. Snap-to-Grid, Quantize, Humanize
- **Snap-to-Grid:** Marker, Loop-Punkte und Seek-Klicks rasten ein, **wenn** innerhalb **Snap-Threshold (ms)**.
    - **Alt** hält: invertiert das aktuelle Snap-Verhalten (temporär).
- **Quantize (Q):** Schiebt **alle Marker** zur nächsten Rasterlinie. **Stärke** (%-Schieber) steuert, wie strikt sie angezogen werden. Vorschau (grün gestrichelt), Übernahme mit **Apply**.
  > Hinweis: Stelle vorher sinnvolle **BPM** ein – sonst Hinweisdialog.
- **Humanize (H):** Fügt **zufällige Timing-Abweichungen** (±ms) hinzu. Verteilung: Uniform/Gauß. **Regenerate** erzeugt neue Variante; Vorschau vorhanden.

---

## 10. Projekte & Auto-Project
- **Format:** `*.practice.json` (versioniertes JSON mit `schema` + `data`).
- **Inhalt:** Audio-Pfad, Marker, Loop A/B, Tempo, Semitöne, BPM, Beats/Bar, Grid-Phase, ausgewählte DSP-Settings.
- **Speichern/Laden:** `Save Project` / `Load Project`. Audio-Pfad **relativ**, wenn möglich (sonst absolut).
- **Auto-Project:** Beim Laden einer Audiodatei wird automatisch `<audioName>.practice.json` im selben Ordner verwendet/angelegt.
- **Audio-Prüfsumme (SHA-256):** Beim Speichern abgelegt → beim Laden Warnung, wenn abweichend.

> 💡 **Best Practice:** Halte **Audio & Projekt nebeneinander**. So bleiben relative Pfade stabil – ideal für Portabilität/Backups.

---

## 11. Wellenform: Zoom & Scroll
**Darstellung:** gefüllte Min/Max-Hüllkurve, dünne **RMS-Linie** (weiß), **Playhead** (grün), **Marker** (rot), **Loop** (blau transparent), **Grid** (grau).

**MP3 gapless:** LAME/Xing-Header werden berücksichtigt; **Delay/Padding** werden **ausgeblendet**, Start/Ende wirken musikalisch korrekt.

**Bedienung:**
- **Mausrad:** Zoom um Mausposition; mit **Shift** = horizontales Panning.
- **Pan (ziehen):** Mittlere Maustaste **oder** **Shift + Linksklick** halten und ziehen.
- **Doppelklick (links):** `Zoom to Fit`.
- **Tasten:** `+`/`=` zoomt ein, `−` zoomt aus; Pfeile links/rechts verschieben.
- **Z:** `Zoom to Loop`.

**Klickverhalten (kurz):**
- **Linksklick:** Seek (mit Snap; **Alt** invertiert).
- **Rechtsklick:** Marker setzen (mit Snap; **Alt** invertiert).
- **Strg/Cmd + Rechtsklick:** Marker löschen (nahe dran, ~6 px).
- **Marker verschieben:** Linksklick halten + ziehen (Snap; **Alt** invertiert).
- **Loop direkt:** **Shift + Rechtsklick** = A, **Shift + Alt + Rechtsklick** = B.
- **Loop-Punkt löschen:** **Strg/Cmd + Shift + Rechtsklick** nahe A/B.

> ℹ️ **Begriff „horizontales Panning“** = Wellenform **scrollen** (kein Audio-Panorama).

**Hover-Snap-Indikator:** zeigt farbig, ob ein Snap-Punkt in Reichweite ist; Hinweistext erinnert an **Alt** zum Umkehren.

---

## 12. Tastaturkürzel
- **Leertaste:** Play/Pause
- **[ / ]:** Tempo −/+ (−0,05 / +0,05)
- **− / + (=):** Tonhöhe −/+ (Halbtöne)
- **A / B:** Loop-Punkt A/B setzen
- **L:** Loop löschen
- **F:** `Zoom to Fit`
- **Z:** `Zoom to Loop`
- **N / P:** Nächster / Vorheriger Marker (mit Wrap-Around)
- **Q:** Quantize-Dialog
- **H:** Humanize-Dialog
- **T:** Tap-Tempo
- **S:** Audio-Einstellungen
- **In der Wellenform:** `+`/`=` zoomt ein, `−` zoomt aus; Pfeile links/rechts verschieben
> **Hinweis:** Es gibt keine dedizierten ←/→-Seek-Tasten (nutze Marker oder Klicken).

---

## 13. Audio-Einstellungen
**Öffnen:** `S` oder Button „Audio Settings“ (erscheint auch automatisch bei Fehlern).  
**Ausgabegerät:** Mixer wählen; `<System Default>` nutzt die Systemausgabe.  
**Buffer (ms):** 20…2000 ms. Klein = geringe Latenz, aber störanfälliger.  
**Speicherung:** in den Benutzer-Prefs (gelten für Player **und** Metronom).

> 💡 **Praxis:** Starte bei **100–200 ms**. Knackser? Schrittweise erhöhen. Latenz spürbar? Senken.

---

## 14. Barrierefreiheit
**High-Contrast:** Schalter aktiviert kontrastreiches Theme inkl. deutlicher Fokus-Ringe. Einstellung wird gespeichert.

---

## 15. Fehlerbehebung
**Kein Ton / Gerät blockiert**
- Audio-Einstellungen öffnen (`S`), anderes Ausgabegerät wählen oder **Buffer erhöhen**.
- Prüfen, ob ein anderes Programm exklusive Ausgabe nutzt.

**MP3 wirkt am Anfang/Ende versetzt**
- Anzeige ist **gapless-bewusst**. Bei ungewöhnlichen Headern fällt die App vorsichtig zurück; dann entspricht die sichtbare Dauer evtl. der Rohdauer.

**Beat-Erkennung ungenau**
- **Align Grid** nutzen, BPM manuell feinjustieren oder **Tap-Tempo**.

**Artefakte bei starken Tempoänderungen**
- **Sequence/Seek Window** moderat erhöhen, **Overlap** ggf. anpassen. Bei Pitch-Shift: **Anti-Alias** aktivieren.

---

## 16. Lizenzhinweise
- **DSP:** SoundTouch (LGPL-2.1) via JNI (dynamisch gelinkt)
- **MP3:** mp3spi/jlayer/tritonus-share (LGPL)
- **Optional:** flacspi/JFLAC (LGPL), vorbisspi (LGPL)
- **Weitere:** Dagger (Apache-2.0), SLF4J, Logback, JavaFX (GPL + Classpath)
- **Vollständig:** im Dialog „About & Licenses“ und unter `src/main/resources/licenses/THIRD_PARTY_NOTICES.txt`

**Screenshots**
- Gesamtansicht: `docs/letitbe-app.png`
- Vergleich Wellenform (Audacity-ähnlich): `docs/letitbe-audacity.png`

**Tipps**
- Projekte früh speichern.
- **Auto-Project** aktivieren.
- **Snap-Threshold** klein halten (präziser), größer für striktes Timing.

---

## 17. Dateiformate (JSON)

### 17.1 Projektdatei (`*.practice.json`)
**Zweck:** kompletter Arbeitszustand.  
**Ablage:** beliebig; empfohlen neben dem Audio. **Auto-Project** erzeugt `<audio>.practice.json`.  
**Schema:** versioniert (`schema` + `data`).

**Beispiel**
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

**Details & Kompatibilität**
- `schema.name` = `"practiceplayer.project"`, `version` aktuell **1**.
- `audioPath` relativ, wenn möglich; sonst absolut.
- **Checksumme:** optional; führt beim Laden bei Abweichung zu einer **Warnung** (kein Abbruch).
- **Ältere flache JSONs** werden weiter gelesen; beim Speichern wird das neue Schema geschrieben.

### 17.2 Marker-Sets (`*.markers.json`)
Minimalformat:
```json
{ "markers": [1.25, 2.5, 5.0] }
```
**Import** akzeptiert auch reine Zahlenlisten (CSV/Whitespace).

### 17.3 Wellenform-Cache (`<audio>.peaks.json`)
**Zweck:** schnelleres Zeichnen + Metadaten. Wird automatisch erzeugt.  
**Löschen:** unkritisch, wird neu berechnet.

**Beispiel (gekürzt)**
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
**Validierung:** Name/mtime/Länge/Version/Algo & Konsistenz müssen passen, sonst Neuaufbau. **Delay/Padding** steuern die **gapless** Anzeige.

### 17.4 Übungen (exercises.json)
**Zweck:** Ad-hoc-Übungen aus dem Übungen-Panel speichern/laden.

- **Version 1:** Nur eingebaute Skalen. Beispiel (gekürzt):
  ```json
  {
    "version": 1,
    "exercises": [ { "title": "Ad-hoc", "scale": "MAJOR", "pattern": "1 2 3" } ]
  }
  ```
- **Version 2:** Zusätzlich optionaler Block `customScale` je Eintrag, wenn eine **eigene Skala** verwendet wird:
  ```text
  {
    "version": 2,
    "exercises": [
      {
        "title": "Ad-hoc",
        "scale": "MAJOR",
        "pattern": "1 2 3",
        "customScale": { "name": "Triad", "intervals": [0,3,7] }
      }
    ]
  }
  ```
- **Kompatibilität:** Ältere Dateien (v1) bleiben gültig; v2 ist abwärtskompatibel, da die eingebauten Felder unverändert bleiben.

> 🗂️ **VCS-Hinweis:** Projekt- und Marker-Dateien sind gut versionierbar; `.peaks.json` eher ausschließen (groß, reproduzierbar).

---

## 18. Konfiguration & Speicherorte
**Was ist global, was projektbezogen?**

### 18.1 UI/DSP-Prefs (global, pro Benutzer)
- Java Preferences (`app.service.ConfigService`)
- Schlüssel (Auszug):
    - `ui.theme.highContrast` (Bool)
    - `dsp.tempo` (Double), `dsp.pitchSemitones` (Int)
    - `dsp.seqMs`, `dsp.seekMs`, `dsp.overlapMs` (Int)
    - `dsp.aa.enabled` (Bool), `dsp.aa.len` (Int)
    - `ui.grid.snap.enabled`, `ui.grid.snap.ms`, `ui.grid.show` (Bool/Int)
    - `ui.autoProject` (Bool)
    - `user.scales.json` (String, JSON‑Payload der **Custom Scales**)

> **Vorrangregel (Tempo/Tonhöhe):**
> - **Mit Projekt geladen:** Werte aus **Projektdatei** gelten.
> - **Ohne Projekt:** App nutzt die **globalen** zuletzt gespeicherten Werte.
> - **Regler bewegen:** schreibt **sofort** in Preferences; in die Projektdatei nur, wenn bereits eine existiert.

### 18.2 Audio-Gerät/Buffer
- Ebenfalls Java Preferences (Controller-Paket):
    - `audio.output.mixer` (String oder `null` = System Default)
    - `audio.output.bufferMs` (Int)

### 18.3 Speicherorte (plattformabhängig)
- **Windows:** Registry `HKCU\Software\JavaSoft\Prefs\…`
- **macOS:** `~/Library/Preferences/…` (JDK-abhängig)
- **Linux/Unix:** `~/.java/.userPrefs/…/prefs.xml`

### 18.4 Projekt vs. App-Prefs (Kurz)
- **Projekt:** Marker, Loop A/B, Tempo, Pitch, BPM, Grid-Phase, Audio-Pfad, Prüfsumme.
- **App-Prefs:** globale UI/DSP-Defaults, High-Contrast, Snap-Einstellungen, Auto-Project.

### 18.5 Zurücksetzen
- Fortgeschritten: gezielt per Registry/Prefs-Datei löschen (kein „Reset“-Button in der App).

---

## 19. Übungen (Einsingen)

**Ziel:** Schnell **Pattern** definieren, **Key/Scale/BPM** wählen, **Range** transponieren – und als **reine Sinus-Übung** abspielen oder als **WAV** exportieren. Läuft auf **eigenem Audiopfad**, nicht parallel zum Song (UI verhindert Doppel-Play).

**Bedienelemente**
- **Pattern:** Textfeld (DSL, siehe unten), z. B. `1 2 3 4 5 4 3 2 1`
- **Key (MIDI):** z. B. 60 = C4
- **Scale:** MAJOR, NAT_MINOR, HARM_MINOR + (optional) **eigene Skalen**
- **BPM:** 1 Token = 1 Beat
- **Range (min/max/step):** Transposition über MIDI-Spanne (z. B. 57..76, step=1)
- **Repeat:** Anzahl kompletter Range-Durchläufe
- **Sound:** MVP `SINE` (geplant: TRIANGLE/SQUARE)
- **Presets:** gängige Muster (1-5-1, Terzen, Arpeggio, Chromatik, Sirene)
- **Metronome click:** optional, Schlag 1 akzentuiert
- **Play/Stop:** starte/stoppe die Übung (Song-Play ist dann deaktiviert)
- **Save/Load Exercises…:** `exercises.json` speichern/laden
- **Export WAV…:** 48 kHz/16-Bit/Mono (Metronom-Click **nicht** eingebettet)

**Pattern-DSL**
- **Tokens:** `1..7` = Stufen, `-` = halten (verlängert Vor-Note um 1 Beat), `|` = Taktstrich (optisch)
- **Oktav-Shift:** `^` = +12 HT, `_` = −12 HT (mehrfach möglich, z. B. `^^3`)
- **Rhythmus (MVP):** 1 Token = 1 Beat

**Live-Änderungen**  
Pattern, BPM, Key, Scale, Range, Repeat, Sound wirken **sofort** (intern kurzer Neustart, ~120 ms Debounce). Fades verhindern Klicks.

**WAV-Export**  
Exportiert die **aktuelle Übung inkl. Range/Repeat** (Mono 48 kHz/16-Bit). **Metronom** wird nicht mitgerendert.

### Eigene Skalen (Custom Scales)
- **Öffnen:** Im Bereich „About & Werkzeuge“ auf **„Eigene Skalen…“** klicken.
- **Anlegen:**
  1) Namen vergeben (z. B. „My Jazz Scale“)
  2) Intervalle als **Halbtöne ab Grundton** eingeben, **durch Komma getrennt**, z. B. `0,2,3,5,7,9,11`.
  3) Speichern – die Skala erscheint in der Liste.
- **Löschen:** Eintrag auswählen → „Ausgewählte löschen“.
- **Verwendung:**
  - Die **Scale-Auswahl** in den Übungen zeigt die eingebauten Skalen und darunter den Abschnitt „— Custom Scales —“ mit Einträgen der Form **`custom:{Name}`**.
  - Wähle einen solchen Eintrag aus, um die Übung mit deiner Skala abzuspielen bzw. zu exportieren.
  - Eigene Skalen werden **global** gespeichert (Benutzer‑Einstellungen), sind also in allen Projekten verfügbar.
- **Hinweise:** Werte sind ganze Zahlen; leere Eingaben werden abgewiesen.

### Übungen speichern/laden mit eigenen Skalen
- **Speichern (Save Exercises…):**
  - Ohne eigene Skala wird ein **`exercises.json`** im **Schema Version 1** geschrieben.
  - Ist eine eigene Skala ausgewählt, wird zusätzlich ein Block
    ```text
    "customScale": { "name": "…", "intervals": [0,3,7] }
    ```
    abgelegt; die Datei trägt dann **`"version": 2`**.
- **Laden (Load Exercises…):**
  - Dateien mit `customScale` werden erkannt. Die Skala wird in deine **Custom Scales** übernommen (sofern noch nicht vorhanden) und in der Scale-Auswahl ausgewählt.
  - Dateien ohne `customScale` verhalten sich wie bisher (eingebaute Skalen).
- **Kompatibilität:** Version‑1‑Dateien bleiben gültig; Version‑2‑Dateien enthalten zusätzlich den `customScale`‑Block für volle Rückwärtskompatibilität.

**Fehlerhilfe (Exercises)**
- Nichts hörbar? Läuft noch der Song → **stoppen**; dann Übung starten.
- Knackser? **Buffer** erhöhen oder **BPM** reduzieren.
- Patternfehler? Nur `1..7`, `-`, `|`, optional `^/_` als Präfixe verwenden.

> 💡 **Startpunkt:** Preset **„1-5-1“**, dann Key/BPM/Range an deine Stimme anpassen.

---

## Was wurde verbessert?
- **Workflows statt nur Funktionen** (Schnellstart, Loop-in-10 Sekunden, Grid-Kalibrierung).
- **Konkrete Tipps/Empfehlungen** direkt bei den Parametern.
- **Klarere Snap-/Alt-Logik** (immer gleich formuliert).
- **Fehlerhilfen** sind „Wenn-dann“ formuliert.
- **Einsteigerfreundliche Erklärungen** (Begriffsklärungen, MP3-Gapless).

**Anhänge (optional)**
- **Screenshots**
    - `docs/letitbe-app.png` (Gesamtansicht)
    - `docs/letitbe-audacity.png` (Wellenform-Vergleich)
