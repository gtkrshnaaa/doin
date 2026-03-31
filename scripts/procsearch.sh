#!/bin/bash
# Search for running processes
if [ -z "$1" ]; then
    echo "Usage: doin procsearch <process_name>"
    exit 1
fi
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}Searching for: $1${RESET}"
echo "-----------------------"
ps aux | grep -i "$1" | grep -v "grep"
echo "-----------------------"
