#!/bin/bash

# Update system
apt-get update -y
apt-get install -y apache2 haproxy

# ===========================
# Setup Apache - Server 1
# Port 8081
# ===========================
cat > /etc/apache2/sites-available/server1.conf << 'EOF'
<VirtualHost *:8081>
    DocumentRoot /var/www/server1
</VirtualHost>
EOF

mkdir -p /var/www/server1
cat > /var/www/server1/index.html << 'EOF'
<html>
  <head><title>Web Server 1</title></head>
  <body><h1>webserver1 dijalankan</h1></body>
</html>
EOF

# ===========================
# Setup Apache - Server 2
# Port 8082
# ===========================
cat > /etc/apache2/sites-available/server2.conf << 'EOF'
<VirtualHost *:8082>
    DocumentRoot /var/www/server2
</VirtualHost>
EOF

mkdir -p /var/www/server2
cat > /var/www/server2/index.html << 'EOF'
<html>
  <head><title>Web Server 2</title></head>
  <body><h1>webserver2 dijalankan</h1></body>
</html>
EOF

# ===========================
# Setup Apache - Server 3
# Port 8083
# ===========================
cat > /etc/apache2/sites-available/server3.conf << 'EOF'
<VirtualHost *:8083>
    DocumentRoot /var/www/server3
</VirtualHost>
EOF

mkdir -p /var/www/server3
cat > /var/www/server3/index.html << 'EOF'
<html>
  <head><title>Web Server 3</title></head>
  <body><h1>webserver3 dijalankan</h1></body>
</html>
EOF

# Enable ports
echo "Listen 8081
Listen 8082
Listen 8083" >> /etc/apache2/ports.conf

# Enable sites
a2ensite server1.conf server2.conf server3.conf

# Restart Apache
systemctl restart apache2

# ===========================
# Setup HAProxy
# ===========================
cat > /etc/haproxy/haproxy.cfg << 'EOF'
defaults
    mode http
    timeout client 5s
    timeout connect 10s
    timeout server 10s
    timeout http-request 10s

frontend my_frontend
    bind localhost:80
    default_backend my_backend

backend my_backend
    balance leastconn
    server server1 localhost:81 check
    server server2 localhost:82 check
    server server3 localhost:83 check

listen stats
    bind :8081
    stats enable
    stats uri /stats
    stats auth admin:admin
EOF

systemctl restart haproxy
systemctl enable haproxy

echo "Setup complete!"
