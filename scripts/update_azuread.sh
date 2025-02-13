#!/bin/bash

# Fetch the latest download link from the Microsoft download center
download_url=$(curl https://www.microsoft.com/en-us/download/details.aspx?id=56519 | grep -o 'https://download.microsoft.com/[^"]*.json' | head -n 1)

# Store the raw JSON into some variable
raw_response=$(curl -s -H "user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14_7_2) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Safari/605.1.15" "$download_url")

# Parse the JSON response and extract only IPs used for Azure AD SCIM provisioning
echo "$raw_response" | jq -r '.values[] | select(.id == "AzureActiveDirectory") | .properties.addressPrefixes[]' > azuread_ips.txt

if [ ! -s azuread_ips.txt ]; then
  echo "0 IP address fetched from Microsoft. There might be a parsing problem."
  exit 1;
fi
