#!/bin/bash
set -e

echo "Join K3s cluster as worker node"
echo "================================"

# Ask for server URL
read -p "Server URL [https://master-01.necroz.local:6443]: " SERVER_URL
SERVER_URL=${SERVER_URL:-https://api-necroz-core.necroz.org:6443}

# Ask for token
read -p "K3s Token: " TOKEN
if [ -z "$TOKEN" ]; then
    echo "Error: Token is required"
    exit 1
fi

echo "Installing K3s as worker node..."
curl -sfL https://get.k3s.io | sh -s - agent \
    --server="$SERVER_URL" \
    --token="$TOKEN"

echo "✓ Worker node joined successfully"
