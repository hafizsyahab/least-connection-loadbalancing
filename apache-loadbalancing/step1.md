# Architecture Overview

## What Are We Building?

In this scenario, we build a load balancing
architecture based on real research using
**HAProxy** with **Least Connection** method.

```
Client (JMeter - 192.168.100.9)
            ↓
   HAProxy (192.168.100.10)
   Load Balancer - Least Connection
   ↓            ↓            ↓
Apache1      Apache2      Apache3
(192.168.100.11) (192.168.100.12) (192.168.100.13)
```

## Load Balancing Algorithms

### Static Algorithms
Static algorithms distribute requests without
considering the current server load.

| Method | Description |
|---|---|
| Round Robin | Distributes requests to each server in fixed rotation. Best when all servers have equal capacity. |
| Weighted Round Robin | Same as Round Robin but gives more requests to servers with higher capacity. |
| IP Hash | Directs requests based on client IP hash. Same IP always goes to the same server — useful for session persistence. |

### Dynamic Algorithms
Dynamic algorithms consider the current server
condition before distributing requests.

| Method | Description |
|---|---|
| Least Connection | Sends requests to server with fewest active connections. Best for varying connection times. |
| Weighted Least Connection | Same as Least Connection but considers server capacity. |
| Least Response Time | Sends requests to server with fastest response time. |
| Resource Based | Distributes based on available server resources (CPU, RAM). |

## Why Least Connection?

Least Connection is a **dynamic load balancing algorithm**
that checks which server has the fewest active connections
and sends new requests to that server.

This method is well-suited because:
- Each request may have **different processing times**
- Traffic load is **unpredictable**
- Provides **stable performance** on high-traffic systems

## How Least Connection Works

```
New request arrives at HAProxy
            ↓
HAProxy checks active connections:
apache1 → 5 connections
apache2 → 2 connections  ← least!
apache3 → 4 connections
            ↓
Request sent to apache2
            ↓
After request done, connection count updates
            ↓
Next request → HAProxy checks again
```

## Network Configuration

| Platform | How IP is Configured |
|---|---|
| VM / VMware (this research) | Static IP via Netplan |
| Killercoda | Automatic per node |
| AWS | VPC / Elastic IP |
| Azure | Virtual Network (VNet) |
| GCP | VPC Network |

## On Real VM (VMware)
```bash
sudo nano /etc/netplan/01-network-manager-all.yaml
sudo netplan apply
```

## On This Killercoda Scenario
No IP configuration needed!
Each node connects automatically using its hostname.

| Node | Hostname |
|---|---|
| Web Server 1 | apache1 |
| Web Server 2 | apache2 |
| Web Server 3 | apache3 |
| Load Balancer | haproxy |
| Load Testing | jmeter |
