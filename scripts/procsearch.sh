#!/bin/bash
# Cleaner Process Search
if [ -z "$1" ]; then
    echo "Usage: doin procsearch <name>"
    exit 1
fi
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}Search Results: $1${RESET}"
echo "-----------------------"
# List matching processes with limited columns for narrow screens
ps -eo pid,pmem,comm | grep -i "$1" | grep -v "grep" | while read -r line; do
    PID=$(echo $line | awk '{print $1}')
    MEM=$(echo $line | awk '{print $2}')
    NAME=$(echo $line | awk '{print $3}')
    echo "CMD : $NAME"
    echo "PID : $PID | MEM: $MEM%"
    echo "---"
done
