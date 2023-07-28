

;------------------------------------------- 
G21
G92 E0 ; Reset Extruder
G1 F2400 E-0.8
M204 5000
M220 S100
M221 S100
G1 Z2.0 F600 
G1 X50 Y4 F3000.0 E10
G1 X160 Y4 F6000.0 
G1 Z0.2 F600.0
G1 X40 Y4.3 F3000.0 E10
G92 E0 
G1 F2400 E-0.8
G1 Z3 F600

G90 
M83 

;------------------------------------------- 
G1 X35 Y10 F3600
G1 E0.8 F2400 
G1 Z.2 F600
G1 X35 Y20 E0.5 F3600


;------------------------------------------- Z Offset 0.000mm z = 0.20mm
G1 Z.2 F600
G1 X35 Y30 E0.5 F3600
;------------------------------------------- Z Offset 0.020mm z = 0.22mm
G1 Z.22 F600
G1 X35 Y40 E0.5 F3600
;------------------------------------------- Z Offset 0.040mm z = 0.24mm
G1 Z.24 F600
G1 X35 Y50 E0.5 F3600
;------------------------------------------- Z Offset 0.060mm z = 0.26mm
G1 Z.26 F600
G1 X35 Y60 E0.5 F3600
;------------------------------------------- Z Offset 0.080mm z = 0.28mm
G1 Z.28 F600
G1 X35 Y70 E0.5 F3600
;------------------------------------------- Z Offset 0.100mm z = 0.30mm
G1 Z.30 F600
G1 X35 Y80 E0.5 F3600
;------------------------------------------- Z Offset 0.120mm z = 0.32mm
G1 Z.32 F600
G1 X35 Y90 E0.5 F3600
;------------------------------------------- Z Offset 0.140mm z = 0.34mm
G1 Z.34 F600
G1 X35 Y100 E0.5 F3600
;------------------------------------------- Z Offset 0.160mm z = 0.36mm
G1 Z.36 F600
G1 X35 Y110 E0.5 F3600
;------------------------------------------- Z Offset 0.180mm z = 0.38mm
G1 Z.38 F600
G1 X35 Y120 E0.5 F3600
;------------------------------------------- Z Offset 0.200mm z = 0.40mm
G1 Z.40 F600
G1 X35 Y130 E0.5 F3600

;------------------------------------------- 后抹料
G1 Z.2 F600
G1 X35 Y140 E0.5 F3600

;-------------------------------------------  移动停止
G1 E-0.8 F2400 
G1 Z5 F600
