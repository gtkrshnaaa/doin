#!/bin/bash
# Vertical Disk Usage
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}Disk Usage Statistics${RESET}"
echo "-----------------------"
# Get data for /data (common in Termux)
DISK_DATA=$(df -h /data | tail -n 1)
FILESYSTEM=$(echo $DISK_DATA | awk '{print $1}')
SIZE=$(echo $DISK_DATA | awk '{print $2}')
USED=$(echo $DISK_DATA | awk '{print $3}')
AVAIL=$(echo $DISK_DATA | awk '{print $4}')
USE_PCT=$(echo $DISK_DATA | awk '{print $5}')

printf "%-12s : %s\n" "Filesystem" "$FILESYSTEM"
printf "%-12s : %s\n" "Size" "$SIZE"
printf "%-12s : %s\n" "Used" "$USED ($USE_PCT)"
printf "%-12s : %s\n" "Available" "$AVAIL"
echo "-----------------------"
