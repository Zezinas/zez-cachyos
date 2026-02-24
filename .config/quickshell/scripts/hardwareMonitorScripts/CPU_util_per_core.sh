#!/bin/bash
# CPU_util_per_core.sh
# Output: 10 20 5 15 (space-separated integers, % per core)
# Uses /proc/stat with 1-second delta for approximate usage

cores=$(grep -c ^cpu[0-9] /proc/stat)

get_cpu_stats() {
    awk '/^cpu[0-9]+/ {print $2,$3,$4,$5,$6,$7,$8,$9}' /proc/stat
}

cpu1=($(get_cpu_stats))
sleep 1
cpu2=($(get_cpu_stats))

output=""
for ((i=0;i<cores;i++)); do
    idx=$((i*8))
    idle1=${cpu1[idx+3]}
    total1=0
    for j in {0..7}; do total1=$((total1 + cpu1[idx+j])); done

    idle2=${cpu2[idx+3]}
    total2=0
    for j in {0..7}; do total2=$((total2 + cpu2[idx+j])); done

    diff_idle=$((idle2 - idle1))
    diff_total=$((total2 - total1))
    usage=$(( (100*(diff_total-diff_idle))/diff_total ))

    output="$output $usage"
done

echo $output
