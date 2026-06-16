# Install and Configure HAProxy

In this step, we will install and configure
HAProxy as the load balancer using
the **Least Connection** method.

> **Note:** In this Killercoda scenario, HAProxy is
> already installed automatically via background script.
> Follow these steps to understand the process.

## 1. Network Configuration (On Real VM)

In the original research, HAProxy uses
a static IP configured via Netplan:

### On haproxy node
```bash
sudo nano /etc/netplan/01-network-manager-all.yaml
```

Fill with:
```yaml
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    ens33:
      dhcp4: no
      addresses:
        - 192.168.100.10/24
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
```

Apply configuration:
```bash
sudo netplan apply
```

## 2. Install HAProxy

```bash
apt-get update -y
apt-get install -y haproxy
```

## 3. Configure HAProxy

Edit HAProxy configuration file:
```bash
nano /etc/haproxy/haproxy.cfg
```

Fill with Least Connection configuration:
```
defaults
    mode http
    timeout client 5s
    timeout connect 10s
    timeout server 10s
    timeout http-request 10s

frontend my_frontend
    bind 192.168.100.10:80
    default_backend my_backend

backend my_backend
    balance leastconn
    server server1 192.168.100.11:80 check
    server server2 192.168.100.12:80 check
    server server3 192.168.100.13:80 check

listen stats
    bind :8081
    stats enable
    stats uri /stats
    stats auth username:password
```

## 4. On Killercoda (using hostname)

HAProxy configuration uses hostnames instead of IPs:
```
backend my_backend
    balance leastconn
    server server1 apache1:80 check
    server server2 apache2:80 check
    server server3 apache3:80 check
```

## 5. Restart HAProxy
```bash
systemctl restart haproxy
systemctl enable haproxy
```

## 6. Verify HAProxy is Running
```bash
systemctl status haproxy
```

You should see **active (running)**!

## 7. Check HAProxy Stats

Open HAProxy statistics dashboard:
```bash
curl http://haproxy:8081/stats
```

Or on Real VM:
```bash
curl http://192.168.100.10:8081/stats
```

## Expected Result

HAProxy is now distributing traffic to
3 Apache servers using **Least Connection** method:

```
Incoming Request
      ↓
HAProxy (192.168.100.10)
      ↓
Checks active connections on each server
      ↓
Sends to server with LEAST connections!
```
