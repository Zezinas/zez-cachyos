#!/bin/bash

# Continuous loop
for hw in /sys/class/hwmon/hwmon*; do
    echo "$hw: $(cat $hw/name 2>/dev/null)"
    done

# /sys/class/hwmon/hwmon*
#/sys/class/hwmon/hwmon0: nvme
#/sys/class/hwmon/hwmon1: nvme
#/sys/class/hwmon/hwmon2: amdgpu
#/sys/class/hwmon/hwmon3: r8169_0_900:00
#/sys/class/hwmon/hwmon4: spd5118
#/sys/class/hwmon/hwmon5: spd5118
#/sys/class/hwmon/hwmon6: k10temp
#/sys/class/hwmon/hwmon7: mt7921_phy0
#/sys/class/hwmon/hwmon8: hidpp_battery_0
