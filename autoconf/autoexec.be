# AtomS3 Sensor Display
import json

# Display-Konfiguration: display.ini setzt Rotation 2 + Invert 1 via :S Zeile,
# hier korrigieren wir auf die tatsaechlich gewuenschten Werte
tasmota.cmd("DisplayRotate 0")
tasmota.cmd("DisplayInvert 0")

var scr = lv.screen_active()
scr.set_style_bg_color(lv.color_hex(0x000000), 0)

# Titel
var title = lv.label(scr)
title.set_text("SENSOR DATA")
title.set_style_text_color(lv.color_hex(0xFF0000), 0)
title.align(lv.ALIGN_TOP_MID, 0, 5)

# Pool von generischen Labels (max. 5 Sensoren)
var label_pool = []
for i:0..4
    var lbl = lv.label(scr)
    lbl.set_style_text_color(lv.color_hex(0xFFFFFF), 0)
    lbl.align(lv.ALIGN_TOP_LEFT, -200, -200)  # Initial außerhalb des Bildschirms
    label_pool.push(lbl)
end

# Sensor-Definitionen
var sensor_configs = [
    {"name": "MLX90614", "key": "OBJTMP", "label": "IR", "unit": "C", "color": 0xFF5500},
    {"name": "MLX90614", "key": "AMBTMP", "label": "Amb", "unit": "C", "color": 0xFFFF00},
    {"name": "SHT4X", "key": "Temperature", "label": "Temp", "unit": "C", "color": 0x00FF00},
    {"name": "SHT4X", "key": "Humidity", "label": "Hum", "unit": "%", "color": 0x00AAFF},
    {"name": "BMP280", "key": "Pressure", "label": "Pres", "unit": "hPa", "color": 0xAA55FF}
]

# Update-Funktion mit Hot-Plug-Unterstützung
def update_sensors()
    var sensors = json.load(tasmota.read_sensors())

    if sensors != nil
        var label_index = 0
        var y_pos = 25  # Start Y-Position

        # Durch alle Sensor-Konfigurationen gehen
        for config : sensor_configs
            var sensor_name = config["name"]

            # Prüfen ob Sensor vorhanden ist
            if sensors.contains(sensor_name)
                var sensor_data = sensors[sensor_name]
                var key = config["key"]

                # Prüfen ob der spezifische Wert existiert
                if sensor_data.contains(key)
                    var value = sensor_data[key]
                    var text = config["label"] + ": " + str(value) + " " + config["unit"]

                    # Label aus Pool verwenden
                    if label_index < 5
                        var lbl = label_pool[label_index]
                        lbl.set_text(text)
                        lbl.set_style_text_color(lv.color_hex(config["color"]), 0)
                        lbl.align(lv.ALIGN_TOP_LEFT, 5, y_pos)  # Sichtbar machen

                        label_index += 1
                        y_pos += 20  # Nächste Position
                    end
                end
            end
        end

        # Ungenutzte Labels außerhalb des Bildschirms verstecken
        while label_index < 5
            label_pool[label_index].align(lv.ALIGN_TOP_LEFT, -200, -200)
            label_index += 1
        end
    end

    # Timer neu starten für nächstes Update
    tasmota.set_timer(2000, update_sensors)
end

# Ersten Update starten
update_sensors()

# Dimmer-Slider und Dim-Button aus Web-UI ausblenden
# o1 = Power Button 1 (Dim), .r = Slider-Container
# o2 (Display Button) bleibt sichtbar
import webserver
class HideDimmer : Driver
    def web_add_main_button()
        webserver.content_send("<style>#o1,.r{display:none!important}</style>")
    end
end
tasmota.add_driver(HideDimmer())
