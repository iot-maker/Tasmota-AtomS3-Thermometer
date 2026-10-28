; AtomS3R Thermometer - Initial Configuration
; Wird nur beim ersten Boot ausgeführt
;
; Unterschiede zum AtomS3 (Pins laut M5GFX board_M5AtomS3R):
;   LCD MOSI G21, SCK G15, CS G14, DC G42, RST G48
;   Backlight ueber LP5562 (I2C 0x30) am internen Bus SDA G45 / SCL G0 -> I2C Bus 2, Ansteuerung in autoexec.be
;   IR-Sender G47, Button G41, Grove G2/G1 (unveraendert)

; GPIO Template setzen
Template {"NAME":"ATOMS3RDISPLAY","GPIO":[609,608,640,0,0,1,1,1,6210,0,0,0,0,0,768,736,0,0,0,0,0,704,0,0,0,0,0,0,416,0,32,800,0,0,641,0,1056,1024],"FLAG":0,"BASE":1}
Module 0

; GPIO OptionA aktivieren (erforderlich für display.ini)
SetOption1 1

; Web-UI Button-Namen setzen
WebButton2 Display
WebButton1 Dim

; Dimmer-Range auf nutzbaren Bereich begrenzen
DimmerRange 40,60

; Display-Einstellungen persistent setzen
DisplayRotate 0
DisplayInvert 1
