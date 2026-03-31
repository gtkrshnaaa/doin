#!/bin/bash
# Battery Status (Termux Optimized)
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}Battery Information${RESET}"
echo "-----------------------"
if command -v termux-battery-status &> /dev/null; then
    termux-battery-status | grep -E 'percentage|status|health|temperature' | sed 's/[",]//g'
else
    echo "Termux-API not installed."
    echo "Please install: pkg install termux-api"
fi
echo "-----------------------"
