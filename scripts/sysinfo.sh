#!/bin/bash
# System Information
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}System Information${RESET}"
echo "-----------------------"
printf "%-12s : %s\n" "Kernel" "$(uname -r)"
printf "%-12s : %s\n" "Arch" "$(uname -m)"
printf "%-12s : %s\n" "Hostname" "$(hostname)"
printf "%-12s : %s\n" "Uptime" "$(uptime -p)"
echo "-----------------------"
