# Load Balancing Analysis Using Least Connection Method

![HAProxy](https://img.shields.io/badge/HAProxy-Load%20Balancer-blue)
![Apache](https://img.shields.io/badge/Apache-Web%20Server-red)
![Ubuntu](https://img.shields.io/badge/Ubuntu-Server-orange)
![Killercoda](https://img.shields.io/badge/Killercoda-Interactive%20Lab-green)


## 🎯 About This Repository

This repository contains an interactive learning scenario
based on a **published research** about analysis load balancing
 in cloud computing using the Least Connection method.

---

## 🚀 Try It on Killercoda

**[▶ Start Interactive Scenario](https://killercoda.com/least-connection-loadbalancing/scenario/apache-loadbalancing)**

No installation needed — runs directly in your browser!

---

## 🏗️ Architecture

```
Client (JMeter - 192.168.100.9)
            ↓
   HAProxy (192.168.100.10)
   Load Balancer - Least Connection
   ↓            ↓            ↓
Apache1      Apache2      Apache3
(.11)        (.12)        (.13)
```

---

## 📦 Components

| Component | Version | Function |
|---|---|---|
| Ubuntu Server | 22.04 | Operating System |
| Apache2 | 2.4 | Web Server (x3) |
| HAProxy | 2.x | Load Balancer |
| Apache JMeter | 5.6.3 | Load Testing |

---

## 📁 Repository Structure

```
apache-loadbalancing/
├── index.json              # Scenario structure
├── intro.md                # Introduction page
├── step1.md                # Architecture overview
├── step2.md                # Install Apache
├── step3.md                # Configure Apache
├── step4.md                # Install & Configure HAProxy
├── step5.md                # JMeter & Testing
├── finish.md               # Conclusions & Suggestions
├── topologi.png            # Network topology diagram
│
├── background.sh           # Single node setup (Killercoda)
│
├── background-apache1.sh   # Apache Server 1 setup
├── background-apache2.sh   # Apache Server 2 setup
├── background-apache3.sh   # Apache Server 3 setup
├── background-haproxy.sh   # HAProxy setup
└── background-jmeter.sh    # JMeter setup
```

### For Real VM / Multi-Server Setup:
- **background-apache1.sh** → Install Apache on Server 1 (192.168.100.11)
- **background-apache2.sh** → Install Apache on Server 2 (192.168.100.12)
- **background-apache3.sh** → Install Apache on Server 3 (192.168.100.13)
- **background-haproxy.sh** → Install HAProxy (192.168.100.10)
- **background-jmeter.sh**  → Install JMeter (192.168.100.9)

### For Killercoda (Single Node):
- **background.sh** → All-in-one setup script
  Simulates multi-server using different ports (8081, 8082, 8083)

---

## 🧪 Testing Scenarios

| No | Thread User | Ramp-Up (s) | Duration (s) | Start Delay (s) | Loop Count |
|---|---|---|---|---|---|
| 1 | 10 | 10 | 60 | 2 | Infinite |
| 2 | 100 | 5 | 180 | 2 | Infinite |
| 3 | 300 | 3 | 300 | 2 | Infinite |
| 4 | 500 | 2 | 480 | 2 | Infinite |
| 5 | 750 | 1 | 600 | 2 | Infinite |
| 6 | 1000 | 1 | 900 | 2 | Infinite |

---

## 📊 QoS Parameters

| Parameter | Description |
|---|---|
| Throughput | Amount of data transferred per second |
| Delay | Time for data to travel from source to destination |
| Packet Loss | Percentage of lost packets |
| Jitter | Variation in packet delay |
| Error Rate | Percentage of failed requests |
| Response Time | Time for server to respond to a request |

---

## 🔧 Platform Compatibility

| Platform | Status |
|---|---|
| VM / VMware | ✅ Tested |
| Killercoda Single Node | ✅ Tested & Working |
| Killercoda Multi Node | ⚠️ Not yet tested |
| AWS | ⚠️ Not yet tested |
| Azure | ⚠️ Not yet tested |
| GCP | ⚠️ Not yet tested |

---

## 📄 Published Research

This scenario is based on a published research paper:

**"Analisa Load Balancing Pada Cloud Computing 
Menggunakan Metode Least Connection"**

- **Author:** Abdurrahman Hafiz (09011381924112)
- **Journal:** Jurnal Ilmu Komputer - NETPLG.COM
- **Volume:** Vol. 1 No. 1, Februari 2023
- **URL:** https://jik.netplg.com/index.php/open/article/view/2

---

## 📝 License

This project is licensed under the MIT License.
