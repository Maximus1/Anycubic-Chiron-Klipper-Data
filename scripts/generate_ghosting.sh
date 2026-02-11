#!/bin/bash
OUTPUT="/home/guru/printer_data/gcodes/ghosting_test.gcode"

# Temperaturen (Hier anpassen, falls nötig)
HOTEND_TEMP=200
BED_TEMP=60

# Start-G-Code mit Aufheizphase
echo "M140 S$BED_TEMP ; Bett aufheizen" > $OUTPUT
echo "M104 S$HOTEND_TEMP ; Hotend aufheizen" >> $OUTPUT
echo "M190 S$BED_TEMP ; Warten auf Bett" >> $OUTPUT
echo "M109 S$HOTEND_TEMP ; Warten auf Hotend" >> $OUTPUT

echo "G21 ; set units to millimeters" >> $OUTPUT
echo "G90 ; use absolute coordinates" >> $OUTPUT
echo "M82 ; absolute extrusion mode" >> $OUTPUT
echo "G28 ; Home all axes" >> $OUTPUT
echo "G1 Z10 F3000" >> $OUTPUT

# Einfache Adhäsionsschicht
echo "G1 X140 Y140 Z0.3 F3000" >> $OUTPUT
echo "G1 X260 Y140 E2 F1200" >> $OUTPUT
echo "G1 X260 Y260 E4 F1200" >> $OUTPUT
echo "G1 X140 Y260 E6 F1200" >> $OUTPUT
echo "G1 X140 Y140 E8 F1200" >> $OUTPUT

# Der Turm (Wände hochziehen)
for i in {1..100}
do
    Z=$(echo "scale=2; 0.3 + ($i * 0.2)" | bc)
    # Reduzierte Extrusionswerte für 0.4er Düse
    E_VAL=$(echo "scale=4; 8 + ($i * 0.5)" | bc)
    echo "G1 Z$Z F3000" >> $OUTPUT
    echo "G1 X260 Y140 E$(echo "scale=2; $E_VAL + 1" | bc) F1800" >> $OUTPUT
    echo "G1 X260 Y260 E$(echo "scale=2; $E_VAL + 2" | bc) F1800" >> $OUTPUT
    echo "G1 X140 Y260 E$(echo "scale=2; $E_VAL + 3" | bc) F1800" >> $OUTPUT
    echo "G1 X140 Y140 E$(echo "scale=2; $E_VAL + 4" | bc) F1800" >> $OUTPUT
done

# End-G-Code
echo "G1 Z50 F3000" >> $OUTPUT
echo "M104 S0" >> $OUTPUT
echo "M140 S0" >> $OUTPUT
echo "M84" >> $OUTPUT