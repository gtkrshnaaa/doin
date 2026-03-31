#!/bin/bash
# Vertical Uptime
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}System Uptime${RESET}"
echo "-----------------------"
UP=$(uptime -p | sed 's/up //')
SINCE=$(uptime -s)
printf "%-12s : %s\n" "Up Time" "$UP"
printf "%-12s : %s\n" "Since" "$SINCE"
echo "-----------------------"
