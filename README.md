![Tasmota logo](/tools/logo/TASMOTA_FullLogo_Vector.svg#gh-light-mode-only)![Tasmota logo](/tools/logo/TASMOTA_FullLogo_Vector_White.svg#gh-dark-mode-only)

# Tasmota AtomS3 Thermometer
Angepasste [Tasmota](https://github.com/arendst/Tasmota)-Firmware für **m5Stack AtomS3** und **m5Stack AtomS3R** mit Displayanzeige und Unterstützung folgender Sensoren:

- **MLX90614** – Infrarot-Temperatursensor
- **SHT40** – Temperatur & Luftfeuchtigkeit
- **BMP280** – Luftdruck & Temperatur

Die Messwerte werden direkt auf dem integrierten Display dargestellt.

Beide Geräte nutzen **dieselbe Firmware**. Sie unterscheiden sich nur in der Autoconf: Display-Pins, Hintergrundbeleuchtung und Farbinvertierung werden dort gesetzt.


## Installation

### 1. Firmware flashen

Die Firmware (`tasmota32s3-lvgl.factory.bin`) mit einem ESP-Webflasher, z.B. [ESP Web Tool](https://espressif.github.io/esptool-js/) (Adresse `0x0`), oder wenn Tasmota bereits drauf ist per OTA Firmware Upgrade auf den AtomS3 / AtomS3R aufspielen.

> Firmware-Binaries findest du unter [Releases](../../releases).

### 2. Autoconf hochladen

Passende Autoconf für dein Gerät wählen:

| Gerät | Autoconf-Datei |
|---|---|
| AtomS3 | [`autoconf/atoms3-thermometer.autoconf`](autoconf/atoms3-thermometer.autoconf) |
| AtomS3R | [`autoconf/atoms3r-thermometer.autoconf`](autoconf/atoms3r-thermometer.autoconf) |

1. Im Tasmota Web Interface zu **Tools → Manage File System** navigieren
2. Die passende `.autoconf`-Datei hochladen
3. Gerät neustarten – die Konfiguration wird automatisch angewendet

> **Wichtig:** Beim Wechsel oder erneuten Aufspielen vorher das Dateisystem komplett leeren (inkl. der versteckten Datei `.autoconf`). Alte `display.ini`/`autoexec.be` einer anderen Variante führen sonst zu dunklem oder weißem Display.

### 3. Template prüfen

Das GPIO-Template sollte durch den Autoconf-Prozess automatisch gesetzt werden. Falls nicht, manuell unter **Configuration → Other → Template** einfügen und aktivieren:

AtomS3:

```json
{"NAME":"ATOMS3DISPLAY","GPIO":[0,608,640,0,1056,1,1,1,6210,0,0,0,0,0,0,768,992,736,0,0,0,704,800,1024,0,0,0,0,416,0,32,0,0,0,0,0,0,0],"FLAG":0,"BASE":1}
```

AtomS3R:

```json
{"NAME":"ATOMS3RDISPLAY","GPIO":[609,608,640,0,0,1,1,1,6210,0,0,0,0,0,768,736,0,0,0,0,0,704,0,0,0,0,0,0,416,0,32,800,0,0,641,0,1056,1024],"FLAG":0,"BASE":1}
```

## Hardware

| Komponente | Beschreibung |
|---|---|
| [m5Stack AtomS3](https://docs.m5stack.com/en/core/AtomS3) | ESP32-S3 Mikrocontroller mit Display |
| [m5Stack AtomS3R](https://docs.m5stack.com/en/core/AtomS3R) | Alternative: ESP32-S3-PICO mit 8 MB PSRAM und Display |
| MLX90614 | Kontaktloser IR-Temperatursensor |
| m5Stack ENV IV Unit | Enthält SHT40 (Temperatur & Feuchtigkeit) und BMP280 (Luftdruck), Anschluss per Grove |

### Unterschiede AtomS3 / AtomS3R

| | AtomS3 | AtomS3R |
|---|---|---|
| Display-Pins (MOSI / SCK / CS / DC / RST) | G21 / G17 / G15 / G33 / G34 | G21 / G15 / G14 / G42 / G48 |
| Hintergrundbeleuchtung | GPIO 16 (`:B` in `display.ini`) | LED-Treiber LP5562 an I2C 0x30 (SDA G45 / SCL G0, I2C-Bus 2), Ansteuerung in `autoexec.be` |
| `DisplayInvert` | 0 | 1 |
| Rotation 0 (`display.ini`) | `:0,C8,02,01,00` | `:0,C8,00,00,00` |
| IR-Sender | G4 | G47 |

Sensoren (Grove G2/G1) und Taster (G41) sind bei beiden gleich angeschlossen.

## Basiert auf

Dieses Projekt ist ein Fork von [Tasmota](https://github.com/arendst/Tasmota) – siehe dort für allgemeine Dokumentation, Befehle und Support.

## Lizenz

This program is licensed under GPL-3.0-only
