#!/bin/bash
set -eu

clk_tck=$(getconf CLK_TCK)
pids=$(ls /proc | grep -E '^[0-9]+$')

(
echo -e "PID|TTY|STAT|TIME|COMMAND"
for pid in $pids; do
    if [ -d /proc/"$pid" ]; then
        stat_file=$(</proc/"$pid"/stat)
        tty=$(echo "$stat_file" | cut -d " " -f 7)
        stat=$(echo "$stat_file" | cut -d " " -f 3)
        utime=$(echo "$stat_file" | cut -d " " -f 14)
        stime=$(echo "$stat_file" | cut -d " " -f 15)
        total_time=$((utime + stime))
        time=$(date +'%M:%S' -d @$((total_time / clk_tck)))
        cmd=$(echo "$stat_file" | cut -d " " -f 2 | tr -d '()')
        echo "${pid}|${tty}|${stat}|${time}|${cmd}"
    fi
done
) | column -t -s "|"
