#!/bin/bash

apt-get update -y
apt-get install -y apache2 haproxy

# Hapus Listen 80 dari ports.conf
sed -i 's/Listen 80/# Listen 80/' /etc/apache2/ports.conf

# Tambah port 8081, 8082, 8083
echo "Listen 8081
Listen 8082
Listen 8083" >> /etc/apache2/ports.conf

# Setup Server 1 - Port 8081
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

# Setup Server 2 - Port 8082
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

# Setup Server 3 - Port 8083
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

# Disable default site
a2dissite 000-default.conf

# Enable sites
a2ensite server1.conf server2.conf server3.conf

# Restart Apache
systemctl restart apache2

# Setup HAProxy
cat > /etc/haproxy/haproxy.cfg << 'EOF'
global
    log /dev/log local0

defaults
