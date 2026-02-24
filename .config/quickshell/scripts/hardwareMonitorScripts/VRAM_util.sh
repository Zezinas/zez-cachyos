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
    #VRAM_USAGE=$(awk -v u=$USED -v t=$TOTAL 'BEGIN{printf "%.2f", u/t}')
    VRAM_USAGE=$(awk -v u=$USED -v t=$TOTAL 'BEGIN{printf "%.0f", (u/t)*100}')
fi

echo $VRAM_USAGE
