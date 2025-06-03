#!/usr/bin/env sh

# Define the domain
# Check if the SUBDOMAIN variable is set
if [ -z "$subdomain" ]; then
    echo "❌ Error: SUBDOMAIN environment variable is not set!"
    echo "Usage: subdomain=bob ./careers.sh"
    exit 1
fi

# Define the domain
DOMAIN="$subdomain.careers.hibob.com"

# Get the IPv4 address (second line from dig output)
IP_ADDRESS="$(dig +short A "$DOMAIN" | sed -n '2p')"

# Check if IP_ADDRESS is not empty
if [ -n "$IP_ADDRESS" ]; then
    # Remove existing entry for the domain (if any)
    sudo sed -i.bak "/$DOMAIN/d" /etc/hosts

    # Append new entry
    echo "$IP_ADDRESS $DOMAIN" | sudo tee -a /etc/hosts > /dev/null

    echo "Added: $IP_ADDRESS $DOMAIN to /etc/hosts ✅"
    subdomain="$subdomain" npm run careers
else
    echo "Failed to retrieve IPv4 address for $DOMAIN ❌"
fi

# Launch the frontend
subdomain="$subdomain" npm run careers
