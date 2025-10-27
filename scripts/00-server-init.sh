#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/../configs/server-init.yaml"

echo "Installing K3s server (first master)..."

# Copy config to K3s location
mkdir -p /etc/rancher/k3s
cp "$CONFIG_FILE" /etc/rancher/k3s/config.yaml

# Install K3s
curl -sfL https://get.k3s.io | sh -s - server

echo "✓ K3s server initialized"
echo "Get token with: sudo cat /var/lib/rancher/k3s/server/token"
