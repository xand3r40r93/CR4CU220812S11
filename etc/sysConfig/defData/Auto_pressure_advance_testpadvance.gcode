; ### K1Max Klipper Pressure Advance Calibration Pattern ###
; -------------------------------------------
;
; Printer: printer name
; Filament: filament name
; Created: Fri Sep 16 2022 16:04:26 GMT+0800 (中国标准时间)

; 

; Slow Printing Speed = 20mm/s
; Fast Printing Speed = 200mm/s
; Printing Acceleration = 12000 mm/s^2

; Flow Detection Start x = 10
; Flow Detection Start y = 50
; Flow Detection End x = 10
; Flow Detection End y = 250
; Flow Detection interval = 30

; Flow Detection Accelerate y1 = 60
; Flow Detection SlowDown y1 = 90

; Flow Detection Accelerate y2 = 110
; Flow Detection SlowDown y2 = 140

; Flow Detection Accelerate y3 = 160
; Flow Detection SlowDown y3 = 190

; Flow Detection Accelerate y4 = 210
; Flow Detection SlowDown y4 = 240

; Flow Detection PointCount = 8

M104 S140
M140 S60.000000
M109 S140
M190 S60.000000

M204 S500

M109 S220.000000

G21
G92 E0 ; Reset Extruder
G1 F2400 E-0.5

M204 S12000
SET_VELOCITY_LIMIT SQUARE_CORNER_VELOCITY=20
SET_VELOCITY_LIMIT ACCEL_TO_DECEL=6000
SET_PRESSURE_ADVANCE SMOOTH_TIME=0.04
M220 S100
M221 S100
G1 Z2.0 F3000 ; Move Z Axis up little  to prevent scratching of Heat Bed
G1 X295.1 Y100 Z0.25 F6000.0 ; Move to start position
G1 X295.4 Y200 Z0.25 F3000.0 E10 ; Draw the first line
G1 X295.4 Y100 Z0.3 F3000.0 E20 ; Move to side a little
G1 Z2 F1200
G92 E0 ; Reset Extruder
G1 F2400 E-0.5
G1 X20 Y20 Z3 F12000  ; Draw the second line

;G1 Z2.0 F3000 ; Move Z Axis up little to prevent scratching of Heat Bed
G1 F12000

SET_PRESSURE_ADVANCE ADVANCE=0 ; set Pressure Advance
M117 K0 ; 

M83

G1 E0.5 F1800 ; un-retract
SET_PRESSURE_ADVANCE ADVANCE=0.02 ; set Pressure Advance
M117 K0.02 ; 
G1 Y50 X5  F12000
G1 Y50 X5 Z0.2 F12000
G1 Y50 X5 E0.2 F1200
G1 Y60 X5 E0.5 F1200 ; print line
G1 Y90 X5 E1.5 F12000 ; print line
G1 Y100 X5 E0.5 F1200 ; print line
SET_PRESSURE_ADVANCE ADVANCE=0.025 ; set Pressure Advance
M900 K0.025
M117 K0.025 ; 
G1 Y100 X5 
G1 Y110 X5 E0.5 F1200 ; print line
G1 Y140 X5 E1.5 F12000 ; print line
G1 Y150 X5 E0.5 F1200 ; print line
SET_PRESSURE_ADVANCE ADVANCE=0.030 ; set Pressure Advance
M117 K0.030 ; 
G1 Y150 X5 
G1 Y160 X5 E0.5 F1200 ; print line
G1 Y190 X5 E1.5 F12000 ; print line
G1 Y200 X5 E0.5 F1200 ; print line
SET_PRESSURE_ADVANCE ADVANCE=0.035 ; set Pressure Advance
M117 K0.035 ; 
G1 Y200 X5 
G1 Y210 X5 E0.5 F1200 ; print line
G1 Y240 X5 E1.5 F12000 ; print line
G1 Y250 X5 E0.5 F1200 ; print line

G1 E-0.5 F2000
G1 Y255 X10 Z0.6 F12000
;next line

SET_PRESSURE_ADVANCE ADVANCE=0.040 ; set Pressure Advance
M117 K0.040 ; 
G1 Y50 X10 Z0.2 F12000
G1 Y50 X10 E0.7 F1200
G1 Y60 X10 E0.5 F1200 ; print line
G1 Y90 X10 E1.5 F12000 ; print line
G1 Y100 X10 E0.5 F1200 ; print line
SET_PRESSURE_ADVANCE ADVANCE=0.045 ; set Pressure Advance
M117 K0.045 ; 
G1 Y100 X10 
G1 Y110 X10 E0.5 F1200 ; print line
G1 Y140 X10 E1.5 F12000 ; print line
G1 Y150 X10 E0.5 F1200 ; print line
SET_PRESSURE_ADVANCE ADVANCE=0.050 ; set Pressure Advance
M117 K0.050 ; 
G1 Y150 X10 
G1 Y160 X10 E0.5 F1200 ; print line
G1 Y190 X10 E1.5 F12000 ; print line
G1 Y200 X10 E0.5 F1200 ; print line
SET_PRESSURE_ADVANCE ADVANCE=0.055 ; set Pressure Advance
M117 K0.055 ; 
G1 Y200 X10 
G1 Y210 X10 E0.5 F1200 ; print line
G1 Y240 X10 E1.5 F12000 ; print line
G1 Y250 X10 E0.5 F1200 ; print line

G1 E-0.5 F2400
G1 Y255 X15 Z0.6 F12000
;next line


SET_PRESSURE_ADVANCE ADVANCE=0.060 ; set Pressure Advance
M117 K0.060 ; 
G1 Y50 X15 Z0.2 F12000
G1 Y50 X15 E0.7 F1200
G1 Y60 X15 E0.5 F1200 ; print line
G1 Y90 X15 E1.5 F12000 ; print line
G1 Y100 X15 E0.5 F1200 ; print line
SET_PRESSURE_ADVANCE ADVANCE=0.065 ; set Pressure Advance
M117 K0.065 ; 
G1 Y100 X15 
G1 Y110 X15 E0.5 F1200 ; print line
G1 Y140 X15 E1.5 F12000 ; print line
G1 Y150 X15 E0.5 F1200 ; print line
SET_PRESSURE_ADVANCE ADVANCE=0.070 ; set Pressure Advance
M117 K0.070 ; 
G1 Y150 X15 
G1 Y160 X15 E0.5 F1200 ; print line
G1 Y190 X15 E1.5 F12000 ; print line
G1 Y200 X15 E0.5 F1200 ; print line
SET_PRESSURE_ADVANCE ADVANCE=0.075 ; set Pressure Advance
M117 K0.075 ; 
G1 Y200 X15 
G1 Y210 X15 E0.5 F1200 ; print line
G1 Y240 X15 E1.5 F12000 ; print line
G1 Y250 X15 E0.5 F1200 ; print line

G1 E-0.2 F2400
G1 Y255 X15 Z0.6 F12000
;next line

; FINISH

;


