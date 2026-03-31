#!/bin/bash
# Weather Report
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}Local Weather Report${RESET}"
echo "-----------------------"
curl -s "wttr.in?0&q&T" | head -n 7
echo "-----------------------"
