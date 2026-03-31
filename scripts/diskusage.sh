#!/bin/bash
# Monitoring Disk Usage
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}Disk Usage Statistics${RESET}"
echo "-----------------------"
df -h | grep -E '^Filesystem|/data|/storage'
echo "-----------------------"
