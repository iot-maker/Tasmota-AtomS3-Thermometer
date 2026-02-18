#!/usr/bin/env python3
"""
Erstellt eine .autoconf Datei für AtomS3 Thermometer
Einfach dieses Script ausführen: python create_autoconf.py
"""

import zipfile
import os

def create_autoconf():
    # Zu packende Dateien
    files = ['init.bat', 'display.ini', 'autoexec.be']

    # Output-Dateiname
    output = 'atoms3-thermometer.autoconf'

    # Prüfen ob alle Dateien existieren
    script_dir = os.path.dirname(os.path.abspath(__file__))
    for file in files:
        file_path = os.path.join(script_dir, file)
        if not os.path.exists(file_path):
            print(f"[FEHLER] {file} nicht gefunden!")
            return False

    # ZIP erstellen (STORE = unkomprimiert, für Tasmota erforderlich!)
    output_path = os.path.join(script_dir, output)
    try:
        with zipfile.ZipFile(output_path, 'w', zipfile.ZIP_STORED) as zipf:
            for file in files:
                file_path = os.path.join(script_dir, file)
                zipf.write(file_path, file)
                print(f"[OK] {file} hinzugefuegt")

        print(f"\n[ERFOLG] Erstellt: {output}")
        print(f"Pfad: {output_path}")
        print(f"Groesse: {os.path.getsize(output_path)} Bytes")
        return True

    except Exception as e:
        print(f"[FEHLER] Beim Erstellen: {e}")
        return False

if __name__ == "__main__":
    print("Erstelle atoms3-thermometer.autoconf...")
    print("-" * 50)
    create_autoconf()
