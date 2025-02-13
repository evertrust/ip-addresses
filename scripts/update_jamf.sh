#!/bin/bash

download_url="https://learn-be.jamf.com/api/bundle/technical-articles/page/Permitting_InboundOutbound_Traffic_with_Jamf_Cloud.html"

# Store the raw HTML into some variable
raw_response=$(curl -s -H "user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14_7_2) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Safari/605.1.15" "$download_url")

# Parse the JSON response and extract only IPs used for Azure AD SCIM provisioning
echo "$raw_response" | jq -r '.topic_html' | htmlq 'table li' --text | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sed 's/$/\/32/' > jamf_ips.txt

if [ ! -s jamf_ips.txt ]; then
  echo "0 IP address fetched from Microsoft. There might be a parsing problem."
  exit 1;
fi
