# Anycubic Chiron Klipper Configuration

Dieses Repository enthält eine optimierte Klipper-Konfiguration sowie die passende Firmware für den **Anycubic Chiron**. Die Konfiguration ist speziell auf die Besonderheiten des Chiron (großes Bett, Dual-Z-Endstopps) abgestimmt.

---

## 🛠 Hardware & Specs
* **Drucker:** Anycubic Chiron
* **Mainboard:** Trigorilla (Atmega2560)
* **Firmware:** Klipper (v0.12.0+)
* **Bauraum:** 400 x 400 x 450 mm
* **Z-Achse:** Dual-Z Motoren mit zwei unabhängigen Endstopps (Z-Tilt support)
* **Extruder:** Titan-Klon (Bowden-Setup)

---

## 📂 Dateistruktur
| Datei | Beschreibung |
| :--- | :--- |
| `chiron_klipper.hex` | Vorkompilierte Firmware für das Trigorilla Board. |
| `printer.cfg` | Hauptkonfiguration (Stepper, Pins, Geschwindigkeiten). |
| `macros.cfg` | Sammlung nützlicher G-Code Makros (Start, Ende, PA, Z-Tilt). |

---

## 🚀 Key Features in dieser Config

### 1. Dual Z-Alignment (`Z_TILT_ADJUST`)
Da der Chiron zwei unabhängige Motoren und Endstopps für die Z-Achse besitzt, gleicht Klipper einen eventuellen Schiefstand der X-Achse automatisch aus.
* **Befehl:** `Z_TILT_ADJUST` (in `macros.cfg` enthalten).

### 2. Mesh Bed Leveling (Anycubic Puck)
Die Konfiguration ist für den originalen Anycubic Leveling-Puck (Probe) vorbereitet. 
* **Matrix:** 5x5 Messpunkte (25 Punkte).
* **Safe Z-Home:** Homing erfolgt sicher in der Mitte des Betts (200, 200).

### 3. Sicherheit & Performance
* **max_extrude_cross_section: 5.0**: Verhindert Abbrüche bei dicken Reinigungsspuren.
* **[gcode_arcs]**: Unterstützung für G2/G3 Befehle (für glattere Rundungen).
* **Beschleunigung:** Konservative Werte (`max_accel: 2000`), um bei dem schweren 400mm Glasbett Schrittverluste zu vermeiden.

---

## 📥 Installation

1. **Firmware flashen:**
   Flashe die `chiron_klipper.hex` via USB auf deinen Drucker (z.B. mit dem PrusaSlicer Firmware Flasher oder OctoPrint/Mainsail).

2. **Configs hochladen:**
   Kopiere `printer.cfg` und `macros.cfg` in dein Klipper-Konfigurationsverzeichnis (meist `~/printer_data/config`).

3. **Individuelle Anpassung:**
   Suche in der `printer.cfg` nach der Sektion `[mcu]` und trage deine eigene Serial-ID ein:
   ```gcode
   [mcu]
   serial: /dev/serial/by-id/usb-1a86_USB_Serial-if00-port0 # <-- DEINE ID HIER
   Deine ID findest du über das Terminal mit: ls /dev/serial/by-id/*

4. **Neustart: Führe RESTART in der Klipper-Konsole aus.**

## 🔧 Wichtige Befehle (Makros)
Die macros.cfg stellt folgende Befehle bereit:

* **G32:** Komplettes Homing inkl. Z-Tilt Alignment.

* **START_PRINT:** Automatisches Aufheizen und Startvorbereitung.

* **END_PRINT:** Düse wegfahren und Heizer ausschalten.

* **CANCEL_PRINT:** Sicherer Abbruch des aktuellen Jobs.

## ⚠️ Disclaimer
Die Nutzung erfolgt auf eigene Gefahr. Prüfe vor dem ersten Homing immer die Endstopp-Funktion mit dem Befehl QUERY_ENDSTOPS, um Schäden an der Mechanik zu vermeiden.

Erstellt für die Klipper-Community & Anycubic Chiron Besitzer.
