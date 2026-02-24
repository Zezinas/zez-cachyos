#!/bin/bash
# RAM_util.sh
# Output: 0.42 (fraction 0–1)

mem_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
mem_avail=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)

usage=$(awk -v t=$mem_total -v a=$mem_avail 'BEGIN{printf "%d", ((t-a)/t) * 100}')
echo $usage
