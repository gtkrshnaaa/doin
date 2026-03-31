#!/bin/bash

# Vertical RAM check for Termux/Linux
# Optimized for narrow terminal screens

# Colors for output
CYAN='\033[1;36m'
RESET='\033[0m'

echo -e "${CYAN}Memory Usage Statistics${RESET}"
echo "-----------------------"

# Capture the 'Mem:' line from free -h
MEM_DATA=$(free -h | grep "Mem:")

# Extract values using awk
TOTAL=$(echo $MEM_DATA | awk '{print $2}')
USED=$(echo $MEM_DATA | awk '{print $3}')
FREE=$(echo $MEM_DATA | awk '{print $4}')
SHARED=$(echo $MEM_DATA | awk '{print $5}')
BUFF=$(echo $MEM_DATA | awk '{print $6}')
AVAIL=$(echo $MEM_DATA | awk '{print $7}')

# Display in a vertical list format
printf "%-12s : %s\n" "Total" "$TOTAL"
printf "%-12s : %s\n" "Used" "$USED"
printf "%-12s : %s\n" "Free" "$FREE"
printf "%-12s : %s\n" "Shared" "$SHARED"
printf "%-12s : %s\n" "Buff/Cache" "$BUFF"
printf "%-12s : %s\n" "Available" "$AVAIL"

echo "-----------------------"
