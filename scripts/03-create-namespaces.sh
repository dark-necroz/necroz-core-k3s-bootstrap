#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NAMESPACES_FILE="${SCRIPT_DIR}/../configs/namespaces.yaml"

echo "Creating cluster namespaces..."
kubectl apply -f "$NAMESPACES_FILE"

echo "✓ Namespaces created"
kubectl get namespaces
