#!/bin/bash
# GPU_util.sh
# Output: 0.70 (fraction 0–1)
# AMD GPU

GPU_USAGE=0
if [ -f /sys/class/drm/card1/device/gpu_busy_percent ]; then
    GPU_RAW=$(cat /sys/class/drm/card*/device/gpu_busy_percent)
    GPU_USAGE=$GPU_RAW
    #GPU_USAGE=$(awk -v val=$GPU_RAW 'BEGIN{printf "%.2f", val/100}')
fi

echo $GPU_USAGE
