#!/bin/bash

# Fetch the latest download link from the Microsoft download center
download_url=$(curl https://www.microsoft.com/en-us/download/confirmation.aspx?id=56519 | grep -o 'https://download.microsoft.com/[^"]*.json' | head -n 1)

# Store the raw JSON into some variable
raw_response=$(curl "$download_url")

# Parse the JSON response and extract only IPs used for Azure AD SCIM provisioning
echo "$raw_response" | jq -r '.values[] | select(.id == "AzureActiveDirectory") | .properties.addressPrefixes[]' > azuread_ips.txt
