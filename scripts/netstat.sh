#!/bin/bash
# Network Status (Optimized for Android/Linux)
CYAN='\033[1;36m'
RESET='\033[0m'
echo -e "${CYAN}Network Status${RESET}"
echo "-----------------------"

# Get Local IP using 'ip' command (more reliable than ifconfig on Android)
LOCAL_IP=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1 | head -n 1)
[ -z "$LOCAL_IP" ] && LOCAL_IP="Not connected"

# Get Default Gateway
GATEWAY=$(ip route | grep default | awk '{print $3}' | head -n 1)
[ -z "$GATEWAY" ] && GATEWAY="N/A"

# Get Public IP (Silently)
PUBLIC_IP=$(curl -s --connect-timeout 5 https://ifconfig.me || echo "Offline")

printf "%-12s : %s\n" "Local IP" "$LOCAL_IP"
printf "%-12s : %s\n" "Gateway" "$GATEWAY"
printf "%-12s : %s\n" "Public IP" "$PUBLIC_IP"
echo "-----------------------"
