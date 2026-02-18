![Tasmota logo](/tools/logo/TASMOTA_FullLogo_Vector.svg#gh-light-mode-only)![Tasmota logo](/tools/logo/TASMOTA_FullLogo_Vector_White.svg#gh-dark-mode-only)

# Tasmota AtomS3 Thermometer
Angepasste [Tasmota](https://github.com/arendst/Tasmota)-Firmware für **m5Stack AtomS3** mit Displayanzeige und Unterstützung folgender Sensoren:

- **MLX90614** – Infrarot-Temperatursensor
- **SHT40** – Temperatur & Luftfeuchtigkeit
- **BMP280** – Luftdruck & Temperatur

Die Messwerte werden direkt auf dem integrierten Display des AtomS3 dargestellt.


## Installation

### 1. Firmware flashen

Die Firmware mit dem [Tasmota WebInstaller](https://tasmota.github.io/install/) oder über die serielle Schnittstelle auf das AtomS3 flashen.

> Firmware-Binaries findest du unter [Releases](../../releases).

### 2. Autoconf hochladen

1. Im Tasmota Web Interface zu **Tools → Manage File System** navigieren
2. Die Datei `atoms3-thermometer.autoconf` aus dem Ordner [`autoconf/`](autoconf/) hochladen
3. Gerät neustarten – die Konfiguration wird automatisch angewendet

### 3. Template prüfen

Das GPIO-Template sollte durch den Autoconf-Prozess automatisch gesetzt werden. Falls nicht, manuell unter **Configuration → Other → Template** einfügen und aktivieren:

```json
{"NAME":"ATOMS3DISPLAY","GPIO":[0,608,640,0,1056,1,1,1,6210,0,0,0,0,0,0,768,992,736,0,0,0,704,800,1024,0,0,0,0,416,0,32,0,0,0,0,0,0,0],"FLAG":0,"BASE":1}
```

## Hardware

| Komponente | Beschreibung |
|---|---|
| [m5Stack AtomS3](https://docs.m5stack.com/en/core/AtomS3) | ESP32-S3 Mikrocontroller mit Display |
| MLX90614 | Kontaktloser IR-Temperatursensor |
| SHT40 | Temperatur- & Feuchtigkeitssensor |
| BMP280 | Barometrischer Drucksensor |

## Basiert auf

Dieses Projekt ist ein Fork von [Tasmota](https://github.com/arendst/Tasmota) – siehe dort für allgemeine Dokumentation, Befehle und Support.

## Lizenz

This program is licensed under GPL-3.0-only
