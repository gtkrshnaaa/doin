#!/bin/bash
# Monitoring CPU Usage
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}CPU Usage Statistics${RESET}"
echo "-----------------------"
top -bn1 | grep "CPU" | head -n 5
echo "-----------------------"
