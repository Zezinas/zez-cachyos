#!/bin/bash
# VRAM_util.sh
# Output: 0.55 (fraction 0–1)
# AMD GPU

VRAM_USAGE=0

USED_FILE=/sys/class/drm/card*/device/mem_info_vram_used
TOTAL_FILE=/sys/class/drm/card*/device/mem_info_vram_total

if [ -f $USED_FILE ] && [ -f $TOTAL_FILE ]; then
    USED=$(cat $USED_FILE)
    TOTAL=$(cat $TOTAL_FILE)
    # 1. Calculate Percentage (0-100)
    VRAM_USAGE=$(awk -v t=$TOTAL -v u=$USED 'BEGIN{printf "%d", (u/t) * 100}')
    # 2. Format Used VRAM to 00.0 GiB (Binary GB)
    VRAM_USED=$(awk -v t=$USED 'BEGIN {printf "%04.1f", t/1073741824}')
    # 3. Format Total VRAM to 00.0 GiB (Binary GB)
    VRAM_TOTAL=$(awk -v t=$TOTAL 'BEGIN {printf "%04.1f", t/1073741824}')
fi

echo $VRAM_USAGE $VRAM_USED $VRAM_TOTAL
