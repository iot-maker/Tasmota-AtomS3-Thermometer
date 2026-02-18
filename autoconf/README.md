# AtomS3 Thermometer - Autoconf

Dieser Ordner enthält alle Dateien für die automatische Konfiguration via Tasmota Autoconf.

## Inhalt

- **init.bat** - Einmalige Befehle beim ersten Boot (Template, WebButton-Namen, DimmerRange)
- **display.ini** - Display-Konfiguration für das GC9107 Display
- **autoexec.be** - Berry-Script für die Sensor-Anzeige (läuft bei jedem Boot)

## Autoconf-Datei erstellen

### Windows:

1. **Dateiendungen sichtbar machen:**
   - Windows Explorer → Ansicht → "Dateinamenerweiterungen" aktivieren

2. **Mit 7-Zip (empfohlen):**
   - Alle 3 Dateien (init.bat, display.ini, autoexec.be) markieren
   - Rechtsklick → 7-Zip → "Zu Archiv hinzufügen"
   - Bei "Archiv" eingeben: `atoms3-thermometer.autoconf` (OHNE .zip!)
   - OK klicken

3. **Mit Windows Standard-ZIP:**
   - Alle 3 Dateien markieren
   - Rechtsklick → "Senden an" → "ZIP-komprimierter Ordner"
   - Die entstandene .zip Datei umbenennen zu `.autoconf`

### Linux/Mac:

```bash
cd autoconf
zip -r atoms3-thermometer.autoconf init.bat display.ini autoexec.be
```

## Deployment-Optionen

### Option 1: Manueller Upload

1. Tasmota Web-GUI → **Consoles → Manage File System**
2. `atoms3-thermometer.autoconf` hochladen
3. Gerät neu starten
4. Autoconf wird automatisch angewendet

### Option 2: Via URL

```
; In der Tasmota-Konsole:
Autoconf https://raw.githubusercontent.com/[user]/[repo]/main/atoms3-thermometer.autoconf
```

### Option 3: Mit Firmware flashen (Windows - mklittlefs muss funktionieren)

In `platformio_tasmota_cenv.ini`:
```ini
custom_files_upload = autoconf/atoms3-thermometer.autoconf
```

## Was passiert beim ersten Boot?

1. **init.bat wird ausgeführt:**
   - GPIO Template wird gesetzt
   - WebButton2 wird zu "Display" umbenannt
   - WebButton1 wird zu "Dim" umbenannt
   - DimmerRange wird auf 40-60% gesetzt

2. **display.ini wird ins Filesystem kopiert**
   - Display-Treiber wird initialisiert

3. **autoexec.be wird ins Filesystem kopiert**
   - Berry-Script startet automatisch
   - Sensoren werden erkannt und angezeigt

4. **Versteckte .autoconf Datei wird erstellt**
   - Verhindert mehrfache Anwendung

## Reapply (erneut anwenden)

Falls du die Konfiguration erneut anwenden möchtest:
1. Web-GUI → Consoles → Manage File System
2. Versteckte Datei `.autoconf` löschen
3. Gerät neu starten

Oder in der Konsole:
```
Delete .autoconf
Restart 1
```

## Hinweise

- Die Autoconf-Datei wird nach erfolgreicher Anwendung NICHT gelöscht
- Sie bleibt im Filesystem als Backup
- Die versteckte `.autoconf` Datei verhindert mehrfache Anwendung
- Für neue Geräte: Einfach `.autoconf` löschen und Gerät neu starten
