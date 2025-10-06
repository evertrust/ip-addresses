#!/bin/bash

# Store the raw HTML into some variable
raw_response=$(curl -s "https://engineering.jamf.com/tc-docs-public-ip-lists/public-ips.json")

# Parse the JSON response and extract only IPs used for Jamf outbound traffic
echo "$raw_response" | jq -r '.public_ips[] | select(.traffic == "outbound") | .ip_prefixes[]' > jamf_ips.txt

if [ ! -s jamf_ips.txt ]; then
  echo "0 IP address fetched from Jamf. There might be a parsing problem."
  exit 1;
fi
