#  Analysis Load Balancing in Cloud Computing Using the Least Connection Method

## Welcome!

In this scenario, you will learn how to implement
and analyze load balancing using the **Least Connection**
method with HAProxy as the load balancer.

This scenario is based on a real research study conducted
in a VMware virtual machine environment.

## Research Overview

Cloud computing provides dynamic computing resources
over a network. However, increasing user requests can
lead to higher server workloads and decreased performance.

This study analyzes load balancing performance using
the **Least Connection** method to distribute traffic
more efficiently across multiple servers.

## Environment Setup

| Node | IP Address | Function |
|---|---|---|
| Apache JMeter | 192.168.100.9 | Client / Load Testing |
| HAProxy | 192.168.100.10 | Load Balancer |
| Apache1 | 192.168.100.11 | Web Server 1 |
| Apache2 | 192.168.100.12 | Web Server 2 |
| Apache3 | 192.168.100.13 | Web Server 3 |

## Quality of Service (QoS) Parameters

Performance will be measured using these parameters:

| Parameter | Description |
|---|---|
| Throughput | Amount of data transferred per second |
| Delay | Time for data to travel from source to destination |
| Packet Loss | Percentage of lost packets |
| Jitter | Variation in packet delay |
| Error Rate | Percentage of failed requests |
| Response Time | Time for server to respond to a request |

## Prerequisites
- No installation required!
- All components are set up automatically.
- Basic knowledge of Linux commands is helpful.
