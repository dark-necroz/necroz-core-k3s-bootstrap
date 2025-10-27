#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_FILE="${SCRIPT_DIR}/../configs/server-join.yaml"

echo "Join K3s cluster as master node"
echo "================================"

# Ask for server URL
read -p "Server URL [https://api-necroz-core.necroz.org:6443]: " SERVER_URL
SERVER_URL=${SERVER_URL:-https://api-necroz-core.necroz.org:6443}

# Ask for token
read -p "K3s Token: " TOKEN
if [ -z "$TOKEN" ]; then
    echo "Error: Token is required"
    exit 1
fi

# Create config from template
mkdir -p /etc/rancher/k3s
sed -e "s|REPLACE_SERVER_URL|$SERVER_URL|g" \
    -e "s|REPLACE_TOKEN|$TOKEN|g" \
    "$TEMPLATE_FILE" > /etc/rancher/k3s/config.yaml

echo "Installing K3s as master node..."
curl -sfL https://get.k3s.io | sh -s - server

echo "✓ Master node joined successfully"
