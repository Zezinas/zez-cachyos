#!/bin/bash
# test.sh - Continuous hardware monitor test
# Prints CPU, RAM, GPU, VRAM, and temperatures every second

# Make sure all scripts are executable
chmod +x CPU_util_per_core.sh RAM_util.sh Temperature_sensors.sh GPU_util.sh VRAM_util.sh

# Continuous loop
while true; do
    TIMESTAMP=$(date +%T)

    CPU=$(./CPU_util_per_core.sh)
    RAM=$(./RAM_util.sh)
    GPU=$(./GPU_util.sh)
    VRAM=$(./VRAM_util.sh)
    TEMP=$(./Temperature_sensors.sh)

    echo "$TIMESTAMP | CPU: $CPU | RAM: $RAM | GPU: $GPU | VRAM: $VRAM | TEMP: $TEMP"

    sleep 1
done
