#!/bin/bash

apt-get update -y
apt-get install -y apache2 haproxy tmux

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
    mode http
    timeout client 5s
    timeout connect 10s
    timeout server 10s
    timeout http-request 10s

frontend my_frontend
    bind *:80
    default_backend my_backend

backend my_backend
    balance leastconn
    server server1 localhost:8081 check
    server server2 localhost:8082 check
    server server3 localhost:8083 check

listen stats
    bind *:9000
    stats enable
    stats uri /stats
    stats auth admin:admin
EOF

systemctl restart haproxy
systemctl enable haproxy

# Setup tmux windows
cat > /root/start-lab.sh << 'EOF'
#!/bin/bash
tmux new-session -d -s lab -n "apache1"
tmux send-keys -t lab:apache1 "echo '=== Apache Server 1 - Port 8081 ==='; curl http://localhost:8081" Enter

tmux new-window -t lab -n "apache2"
tmux send-keys -t lab:apache2 "echo '=== Apache Server 2 - Port 8082 ==='; curl http://localhost:8082" Enter

tmux new-window -t lab -n "apache3"
tmux send-keys -t lab:apache3 "echo '=== Apache Server 3 - Port 8083 ==='; curl http://localhost:8083" Enter

tmux new-window -t lab -n "haproxy"
tmux send-keys -t lab:haproxy "echo '=== HAProxy Load Balancer - Port 80 ==='; systemctl status haproxy" Enter

tmux new-window -t lab -n "jmeter"
tmux send-keys -t lab:jmeter "echo '=== JMeter Load Testing ==='" Enter

tmux attach -t lab
EOF

chmod +x /root/start-lab.sh

echo "Setup complete! Run: /root/start-lab.sh"
