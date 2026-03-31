#!/bin/bash
# Vertical Top Memory Processes
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}Top Memory Processes${RESET}"
echo "-----------------------"
# Get top 3 processes to keep it short vertically
ps -eo pmem,comm --sort=-%mem | head -n 4 | tail -n 3 | while read -r line; do
    MEM=$(echo $line | awk '{print $1}')
    NAME=$(echo $line | awk '{print $2}')
    printf "%-12s : %s%%\n" "$NAME" "$MEM"
done
echo "-----------------------"
