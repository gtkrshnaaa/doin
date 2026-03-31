#!/bin/bash
# Top 5 Memory Consuming Processes
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}Top 5 Memory Consumers${RESET}"
echo "-----------------------"
ps aux --sort=-%mem | head -n 6
echo "-----------------------"
