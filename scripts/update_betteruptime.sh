#!/bin/bash

download_url="https://uptime.betterstack.com/ips.txt"

curl -s https://uptime.betterstack.com/ips.txt | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sed 's/$/\/32/' > betteruptime_ips.txt

# Store the raw HTML into some variable
raw_response=$(curl -s "$download_url")

# Parse the JSON response and extract only IPv4s.
echo "$raw_response" | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sed 's/$/\/32/' > betteruptime_ips.txt

if [ ! -s betteruptime_ips.txt ]; then
  echo "0 IP address fetched from BetterUptime. There might be a parsing problem."
  exit 1;
fi
