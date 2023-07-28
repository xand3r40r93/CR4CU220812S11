
;FLAVOR:Marlin
;TIME:16.0481
;Filament used:0.0156082m
;Layer height: 0.2
;MINX:90.221
;MINY:90.221
;MINZ:0.188
;MAXX:109.466
;MAXY:109.466
;MAXZ:0.188
                                                                                                                                   

;Creality Print GCode Generated by CXEngine
;CRSLICE_GIT_HASH:226059f
;Creality Print Version : V4.3.4.5553
;CXEngine Release Time:2023-04-25 16:49:01
;Gcode Generated Time:2023-05-12 17:14:03
;----------Machine Config--------------
;Machine Name:Fast Ender-3 S1
;Machine Height:270
;Machine Width:230
;Machine Depth:230
;Material name:cxsw
;Number of Extruders:1
;ExtruderParams[0] Nozzle Diameter:1000
;----------Profile Config---------------
;Layer Height:0.2
;Wall Thickness:1.2
;Top/Bottom Thickness:0.8
;Out Wall Line Width:0.4
;Inner Wall Line Width:0.4
;Inital Layer Height:188
;Wall Line Count:2
;Infill Line Distance:4
;Infill Pattern:zigzag
;Infill Sparse Density:10
;Infill Wipe Distance:0
;Print Temperature:200
;Bed Temperature:60
;Support Enable:false
;Support Density:10
;Support Angle:45
;Adhesion Type:none
;machine is belt:false
;machine belt offset:10
;machine belt offset Y:0
;Raft Base Line Spacing:1.6
;Wait Heatup Sync:true
;Enable Ironing:false
;----------Shell Config----------------
;Outer Wall Wipe Distance:200
;Outer Inset First:false
;Infill Before Walls:false
;Infill Overlap:0.04
;Fill Gaps Between Walls:everywhere
;Minimum Infill Area:15
;Top Surface Skin Layer:0
;Top Layers:4
;Z Seam Alignment:sharpest_corner
;Seam Corner Preference:z_seam_corner_weighted
;Z Seam X:100
;Z Seam Y:100
;Horizontal Expansion:0
;Top/Bottom Pattern:zigzag
;Ironing Pattern:zigzag
;Vase Model:false
;----------Support Config----------------
;Support Type:everywhere
;Support Pattern:zigzag
;Support Infill Layer Thickness:0.15
;Minimum Support Area:5
;Enable Support Roof:true
;Support Roof Thickness:0.8
;Support Roof Pattern:lines
;Connect Support Lines:0
;Connect Support ZigZags:1
;Minimum Support X/Y Distance:0.2
;Support Line Distance:1.33
; ---------PrintSpeed & Travel----------
;Enable Print Cool:true
;Avoid Printed Parts Traveling:true
;Enable Retraction:true
;Retraction Distance:0.4
;Retraction Speed:40
;Retraction Prime Speed:40
;Maximum Retraction Count:100
;Minimum Extrusion Distance Window:1
;Z Hop When Retracted:false
;Z Hop Height:0.2
;Retract Before Outer Wall:true
;Print Speed:170
;Infill Speed:170

;Prime Tower Speed:60
;Travel Speed:200
;Initial Layer Speed:60
;Skirt/Brim Speed:25
;Combing Mode:noskin
; --------SpecialModel&Mesh Fixes--------
;Union Overlapping Volum:true
;Remove All Holes:false
;Maximum Travel Resolution:0.25
;Maximum Deviation:0.05
;Maximum Model Angle:0.872665
;IS Mold Print:false
;Make Overhang Printable:false
;Enable Coasting:false
;Coasting Volumes:0.064
;Coasting Speed:0.9
;Raft AirGap:0.25
;Layer0 ZOverLap:0.13
;---------------------End of Head--------------------------
G28 ; Home all axes
M140 S60
M105
M190 S60
M104 S210
M105
M109 S210
M82 ;absolute extrusion mode
G90
G92 E0 ; Reset Extruder

;BED_MESH_CALIBRATE
G1 Z2.0 F3000 
G1 X5.1 Y20 Z0.3 F5000.0 
G1 X5.1 Y200.0 Z0.3 F1500.0 E15
G1 X5.4 Y200.0 Z0.3 F5000.0 
G1 X5.4 Y20 Z0.3 F1500.0 E30 
G92 E0 
G1 Z2.0 F3000
G1 X5 Y20 Z0.3 F5000.0
G92 E0
G92 E0
G1 F2400 E-0.4
;LAYER_COUNT:1

;LAYER:0
M106 S0
M106 P2 S0
M204 S1000
;MESH:
G0 F3900 X90.621 Y108.5 Z0.188
;TYPE:WALL-INNER
G1 F2400 E0
G1 F3600 X99.56 Y99.561 E0.39524
G1 X108.5 Y90.622 E0.79049
G1 X90.621 Y90.621 E1.34947
G1 X90.621 Y108.5 E1.90845
G0 F3900 X90.459 Y108.891
G0 X90.221 Y109.466
;TYPE:WALL-OUTER
G1 F3600 X99.843 Y99.844 E2.33388
G1 X109.466 Y90.222 E2.75934
G1 X90.221 Y90.221 E3.36103
G1 X90.221 Y109.466 E3.96271
G0 F3900 X90.362 Y109.325
G0 X90.459 Y108.891
G0 X91.198 Y107.78
G0 X91.002 Y107.583
;TYPE:SKIN
G1 F3600 X99.291 Y99.292 E4.32925
G1 X107.583 Y91.002 E4.69584
G1 X91.002 Y91.002 E5.21423
G1 X91.002 Y107.583 E5.73263
G0 F3900 X91.513 Y106.787
G1 F3600 X91.201 Y106.475 E5.74643
G0 F3900 X91.201 Y105.909
G1 F3600 X91.796 Y106.504 E5.77273
G0 F3900 X92.079 Y106.221
G1 F3600 X91.201 Y105.344 E5.81153
G0 F3900 X91.201 Y104.778
G1 F3600 X92.362 Y105.938 E5.86284
G0 F3900 X92.645 Y105.655
G1 F3600 X91.201 Y104.212 E5.92667
G0 F3900 X91.201 Y103.647
G1 F3600 X92.927 Y105.373 E6.00298
G0 F3900 X93.21 Y105.09
G1 F3600 X91.201 Y103.081 E6.09181
G0 F3900 X91.201 Y102.515
G1 F3600 X93.493 Y104.807 E6.19315
G0 F3900 X93.776 Y104.524
G1 F3600 X91.201 Y101.949 E6.307
G0 F3900 X91.201 Y101.384
G1 F3600 X94.059 Y104.241 E6.43334
G0 F3900 X94.342 Y103.958
G1 F3600 X91.201 Y100.818 E6.5722
G0 F3900 X91.201 Y100.252
G1 F3600 X94.625 Y103.675 E6.72357
G0 F3900 X94.907 Y103.393
G1 F3600 X91.201 Y99.687 E6.88743
G0 F3900 X91.201 Y99.121
G1 F3600 X95.19 Y103.11 E7.0638
G0 F3900 X95.473 Y102.827
G1 F3600 X91.201 Y98.555 E7.25269
G0 F3900 X91.201 Y97.99
G1 F3600 X95.756 Y102.544 E7.45406
G0 F3900 X96.039 Y102.261
G1 F3600 X91.201 Y97.424 E7.66795
G0 F3900 X91.201 Y96.858
G1 F3600 X96.322 Y101.978 E7.89435
G0 F3900 X96.604 Y101.696
G1 F3600 X91.201 Y96.293 E8.13325
G0 F3900 X91.201 Y95.727
G1 F3600 X96.887 Y101.413 E8.38465
G0 F3900 X97.17 Y101.13
G1 F3600 X91.201 Y95.161 E8.64857
G0 F3900 X91.201 Y94.596
G1 F3600 X97.453 Y100.847 E8.92498
G0 F3900 X97.736 Y100.564
G1 F3600 X91.201 Y94.03 E9.2139
G0 F3900 X91.201 Y93.464
G1 F3600 X98.019 Y100.281 E9.51533
G0 F3900 X98.301 Y99.999
G1 F3600 X91.201 Y92.898 E9.82928
G0 F3900 X91.201 Y92.333
G1 F3600 X98.584 Y99.716 E10.15572
G0 F3900 X98.867 Y99.433
G1 F3600 X91.201 Y91.767 E10.49467
G0 F3900 X91.201 Y91.201
G1 F3600 X99.15 Y99.15 E10.84613
G0 F3900 X99.433 Y98.867
G1 F3600 X91.767 Y91.201 E11.18508
G0 F3900 X92.333 Y91.201
G1 F3600 X99.716 Y98.584 E11.51152
G0 F3900 X99.999 Y98.301
G1 F3600 X92.898 Y91.201 E11.82546
G0 F3900 X93.464 Y91.201
G1 F3600 X100.281 Y98.019 E12.1269
G0 F3900 X100.564 Y97.736
G1 F3600 X94.03 Y91.201 E12.41582
G0 F3900 X94.596 Y91.201
G1 F3600 X100.847 Y97.453 E12.69223
G0 F3900 X101.13 Y97.17
G1 F3600 X95.161 Y91.201 E12.95614
G0 F3900 X95.727 Y91.201
G1 F3600 X101.413 Y96.887 E13.20755
G0 F3900 X101.696 Y96.604
G1 F3600 X96.293 Y91.201 E13.44644
G0 F3900 X96.858 Y91.201
G1 F3600 X101.978 Y96.322 E13.67284
G0 F3900 X102.261 Y96.039
G1 F3600 X97.424 Y91.201 E13.88673
G0 F3900 X97.99 Y91.201
G1 F3600 X102.544 Y95.756 E14.08811
G0 F3900 X102.827 Y95.473
G1 F3600 X98.555 Y91.201 E14.27699
G0 F3900 X99.121 Y91.201
G1 F3600 X103.11 Y95.19 E14.45336
G0 F3900 X103.393 Y94.907
G1 F3600 X99.687 Y91.201 E14.61722
G0 F3900 X100.252 Y91.201
G1 F3600 X103.675 Y94.625 E14.76859
G0 F3900 X103.958 Y94.342
G1 F3600 X100.818 Y91.201 E14.90745
G0 F3900 X101.384 Y91.201
G1 F3600 X104.241 Y94.059 E15.03379
G0 F3900 X104.524 Y93.776
G1 F3600 X101.949 Y91.201 E15.14765
G0 F3900 X102.515 Y91.201
G1 F3600 X104.807 Y93.493 E15.24899
G0 F3900 X105.09 Y93.21
G1 F3600 X103.081 Y91.201 E15.33781
G0 F3900 X103.647 Y91.201
G1 F3600 X105.373 Y92.927 E15.41413
G0 F3900 X105.655 Y92.645
G1 F3600 X104.212 Y91.201 E15.47795
G0 F3900 X104.778 Y91.201
G1 F3600 X105.938 Y92.362 E15.52926
G0 F3900 X106.221 Y92.079
G1 F3600 X105.344 Y91.201 E15.56806
G0 F3900 X105.909 Y91.201
G1 F3600 X106.504 Y91.796 E15.59437
G0 F3900 X106.787 Y91.513
G1 F3600 X106.475 Y91.201 E15.60816
;TIME_ELAPSED:16.048058

G1 F2400 E15.20816
M140 S0
M204 S10000
M140 S0
M104 S0
M106 S0
G91
G1 Z0.2 E-2 F2400
G1 X5 Y5 F3000
G1 Z10
G90
G1 X0 Y230
;M84
M82 ;absolute extrusion mode
M104 S0
;End of Gcode
