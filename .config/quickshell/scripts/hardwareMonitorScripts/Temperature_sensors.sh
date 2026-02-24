#!/bin/bash
# Temperature_sensors.sh
# Output: CPU_TEMP GPU_TEMP

CPU_TEMP=0
GPU_TEMP=0

# --- CPU (k10temp) ---
for hw in /sys/class/hwmon/hwmon*; do
    if [[ "$(cat $hw/name 2>/dev/null)" == "k10temp" ]]; then
        # Prefer Tdie if available (more accurate on AMD)
        for i in $hw/temp*_input; do
            label_file="${i/_input/_label}"

            if [[ -f "$label_file" ]]; then
                label=$(cat "$label_file")
                if [[ "$label" == "Tdie" ]]; then
                    CPU_TEMP=$(cat "$i")
                    CPU_TEMP=$((CPU_TEMP/1000))
                    break 2
                fi
            fi
        done

        # fallback if no Tdie
        CPU_TEMP=$(cat "$hw/temp1_input" 2>/dev/null)
        CPU_TEMP=$((CPU_TEMP/1000))
        break
    fi
done

# --- GPU (amdgpu) ---
for hw in /sys/class/hwmon/hwmon*; do
    if [[ "$(cat $hw/name 2>/dev/null)" == "amdgpu" ]]; then
        GPU_TEMP=$(cat "$hw/temp1_input" 2>/dev/null)
        GPU_TEMP=$((GPU_TEMP/1000))
        break
    fi
done

echo "$CPU_TEMP $GPU_TEMP"
