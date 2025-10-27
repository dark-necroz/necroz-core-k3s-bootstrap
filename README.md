# K3s Cluster Bootstrap

Simple scripts for bootstrapping K3s cluster with declarative YAML configs.

## Structure

```
bootstrap/
├── scripts/
│   ├── 00-server-init.sh       # Initialize first K3s server
│   ├── 01-join-masters.sh      # Join additional masters (HA)
│   ├── 02-join-workers.sh      # Join worker nodes
│   └── 03-create-namespaces.sh # Create namespaces
├── configs/
│   ├── server-init.yaml        # K3s config for first server
│   ├── server-join.yaml        # K3s config template for masters
│   └── namespaces.yaml         # Namespace definitions
└── README.md
```

## Quick Start

### 1. Initialize First Server

Run on the **first master node**:

```bash
sudo ./scripts/00-server-init.sh
```

This copies `configs/server-init.yaml` to `/etc/rancher/k3s/config.yaml` and installs K3s.

Get the join token:
```bash
sudo cat /var/lib/rancher/k3s/server/token
```

### 2. Join Additional Masters (HA)

Run on **additional master nodes**:

```bash
sudo ./scripts/01-join-masters.sh
```

The script will interactively ask for:
- Server URL (default: `https://api-necroz-core.necroz.org:6443`)
- K3s Token

### 3. Join Worker Nodes

Run on **worker nodes**:

```bash
sudo ./scripts/02-join-workers.sh
```

The script will interactively ask for:
- Server URL (default: `https://api-necroz-core.necroz.org:6443`)
- K3s Token

### 4. Create Namespaces

Run from any master node:

```bash
./scripts/03-create-namespaces.sh
```

## Configuration

All K3s configuration is in YAML files in `configs/`:

- `server-init.yaml` - First server configuration
- `server-join.yaml` - Template for additional masters
- `namespaces.yaml` - Namespace definitions

### Network Settings

- Cluster CIDR: `10.128.0.0/14` (1M pod IPs)
- Service CIDR: `10.132.0.0/16` (65k service IPs)
- CNI: Flannel disabled (using Cilium)
- Kube-proxy: Disabled (Cilium replaces it)

### Disabled Components

- Traefik (using custom ingress)
- ServiceLB (using MetalLB)
- Metrics Server (using custom HA setup)
- Local Storage (using custom storage)

## Namespaces

The following namespaces are created:

| Namespace | Purpose | Environment |
|-----------|---------|-------------|
| `infra` | Infrastructure services | Infrastructure |
| `prod` | Production workloads | Production |
| `dev` | Development workloads | Development |
| `monitoring` | Observability stack | Infrastructure |
| `cert-manager` | Certificate management | Infrastructure |
| `cattle-system` | Rancher (optional) | Infrastructure |
| `metallb-system` | Load balancer | Infrastructure |

## Next Steps

After bootstrap:

1. Deploy Cilium CNI
2. Deploy cert-manager
3. Deploy MetalLB
4. Deploy Metrics Server
# necroz-core-k3s-bootstrap
