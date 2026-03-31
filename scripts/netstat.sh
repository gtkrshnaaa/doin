#!/bin/bash
# Network Status
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}Network Status${RESET}"
echo "-----------------------"
printf "%-12s : %s\n" "Local IP" "$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1)"
printf "%-12s : %s\n" "Public IP" "$(curl -s https://ifconfig.me || echo 'Offline')"
echo "-----------------------"
