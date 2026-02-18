; AtomS3 Thermometer - Initial Configuration
; Wird nur beim ersten Boot ausgeführt

; GPIO Template setzen
Template {"NAME":"ATOMS3DISPLAY","GPIO":[0,608,640,0,1056,1,1,1,6210,0,0,0,0,0,0,768,992,736,0,0,0,704,800,1024,0,0,0,0,416,0,32,0,0,0,0,0,0,0],"FLAG":0,"BASE":1}
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
DisplayInvert 0
