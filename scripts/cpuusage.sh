#!/bin/bash
# Vertical CPU Usage
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}CPU Load Statistics${RESET}"
echo "-----------------------"
LOAD=$(uptime | awk -F'load average:' '{ print $2 }')
L1=$(echo $LOAD | awk -F',' '{print $1}')
L5=$(echo $LOAD | awk -F',' '{print $2}')
L15=$(echo $LOAD | awk -F',' '{print $3}')

printf "%-12s : %s\n" "Load 1m" "$L1"
printf "%-12s : %s\n" "Load 5m" "$L5"
printf "%-12s : %s\n" "Load 15m" "$L15"
echo "-----------------------"
