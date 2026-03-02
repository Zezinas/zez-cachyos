#!/bin/bash
# RAM_util.sh
# Output: int 0-100 (Percentage %)

# Get values from /proc/meminfo (in KiB)
mem_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
mem_avail=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)

# Calculate Used RAM in KiB
mem_used=$((mem_total - mem_avail))

# 1. Calculate Percentage (0-100)
usage=$(awk -v t=$mem_total -v u=$mem_used 'BEGIN{printf "%d", (u/t) * 100}')

# 2. Format Used RAM to 00.0 GiB
# Divisor 1048576 converts KiB to GiB
mem_used_gb=$(awk -v u=$mem_used 'BEGIN {printf "%04.1f", u/1048576}')

# 3. Format Total RAM to 00.0 GiB
mem_total_gb=$(awk -v t=$mem_total 'BEGIN {printf "%04.1f", t/1048576}')

echo $usage $mem_used_gb $mem_total_gb
