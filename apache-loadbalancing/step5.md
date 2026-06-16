# Install Apache JMeter and Testing

In this step, we will install Apache JMeter
and perform load testing on our load balancing setup.

> **Note:** In this Killercoda scenario, JMeter is
> already installed automatically via background script.
> Follow these steps to understand the process.

## 1. Network Configuration (On Real VM)

In the original research, JMeter uses
a static IP configured via Netplan:

### On jmeter node
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
        - 192.168.100.9/24
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
```

Apply configuration:
```bash
sudo netplan apply
```

## 2. Install JMeter

Install Java (required for JMeter):
```bash
apt-get update -y
apt-get install -y default-jdk wget
```

Download JMeter:
```bash
wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.6.3.tgz
```

Extract JMeter:
```bash
tar -xzf apache-jmeter-5.6.3.tgz -C /opt/
```

Create shortcut:
```bash
ln -s /opt/apache-jmeter-5.6.3/bin/jmeter /usr/local/bin/jmeter
```

Verify installation:
```bash
jmeter --version
```

## 3. Testing Scenarios

In the original research, testing was conducted
with gradually increasing number of users:

| Test | Number of Users | Ramp-up Period |
|---|---|---|
| Test 1 | 10 users | 1 second |
| Test 2 | 100 users | 1 second |
| Test 3 | 300 users | 1 second |
| Test 4 | 500 users | 1 second |
| Test 5 | 750 users | 1 second |

## 4. Run JMeter Test

### On Killercoda (Non-GUI mode)
```bash
jmeter -n -t testplan.jmx -l results.jtl
```

### On Real VM (GUI mode)
```bash
jmeter
```

## 5. Send Request to HAProxy

Test if HAProxy is distributing requests correctly:
```bash
# Send 10 requests to HAProxy
for i in {1..10}; do
  curl http://haproxy
  echo ""
done
```

## Expected Output

Each request should be served by different servers:
```
webserver1 dijalankan
webserver2 dijalankan
webserver3 dijalankan
webserver1 dijalankan
webserver2 dijalankan
...
```

HAProxy distributes using **Least Connection** —
server with fewest active connections gets the request!

## 6. QoS Parameters to Analyze

| Parameter | Formula |
|---|---|
| Throughput | Total Data / Total Time |
| Delay | (Total Delay / Total Packet) |
| Packet Loss | (Packet Loss / Packet Sent) x 100% |
| Jitter | Absolute Delay Difference between packets |
| Error Rate | (Failed Request / Total Request) x 100% |
| Response Time | Time from request sent to response received |

## 7. Check HAProxy Stats

Monitor which server receives most requests:
```bash
curl http://haproxy:8081/stats
```

This shows real-time connection distribution
across all 3 Apache servers!
