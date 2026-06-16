# Configure Apache Web Server

In this step, we will configure the network
and web pages for each Apache server.

> **Note:** In this Killercoda scenario, configuration
> is done automatically via background script.
> Follow these steps to understand the process.

## 1. Network Configuration (On Real VM)

In the original research, each server uses
a static IP configured via Netplan:

### On apache1
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
        - 192.168.100.11/24
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
```

Apply configuration:
```bash
sudo netplan apply
```

### On apache2
Same steps but use IP: **192.168.100.12/24**

### On apache3
Same steps but use IP: **192.168.100.13/24**

## 2. Create HTML Page for Each Server

### On apache1
```bash
cat > /var/www/html/index.html << 'EOF'
<html>
  <head>
    <title>Web Server 1</title>
  </head>
  <body>
    <h1>webserver1 dijalankan</h1>
  </body>
</html>
EOF
```

### On apache2
```bash
cat > /var/www/html/index.html << 'EOF'
<html>
  <head>
    <title>Web Server 2</title>
  </head>
  <body>
    <h1>webserver2 dijalankan</h1>
  </body>
</html>
EOF
```

### On apache3
```bash
cat > /var/www/html/index.html << 'EOF'
<html>
  <head>
    <title>Web Server 3</title>
  </head>
  <body>
    <h1>webserver3 dijalankan</h1>
  </body>
</html>
EOF
```

## 3. Restart Apache
```bash
systemctl restart apache2
```

## 4. Verify Each Server

### On Killercoda (using hostname)
```bash
curl http://apache1
curl http://apache2
curl http://apache3
```

### On Real VM (using IP)
```bash
curl http://192.168.100.11
curl http://192.168.100.12
curl http://192.168.100.13
```

## Expected Output
```
apache1 → "webserver1 dijalankan"
apache2 → "webserver2 dijalankan"
apache3 → "webserver3 dijalankan"
```

All 3 servers are ready for HAProxy load balancing!
