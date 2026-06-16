# Install Apache Web Server

In this step, we will install Apache Web Server
on all 3 backend servers.

> **Note:** In this Killercoda scenario, Apache is
> already installed automatically via background script.
> Follow these steps to understand the installation process.

## Run on apache1, apache2, and apache3

Update package list:
```bash
apt-get update -y
```

Install Apache:
```bash
apt-get install -y apache2
```

Start Apache:
```bash
systemctl start apache2
```

Enable Apache on boot:
```bash
systemctl enable apache2
```

## Verify Apache is Running
```bash
systemctl status apache2
```

You should see **active (running)**!

## Why 3 Apache Servers?

Having 3 backend servers allows HAProxy to:
- Distribute incoming traffic across all servers
- Keep the system running if one server fails
- Handle more concurrent users

## On Real VM (VMware)
In the original research, Apache was installed
on 3 separate Ubuntu VMs with these IPs:

| Server | IP Address |
|---|---|
| Apache1 | 192.168.100.11 |
| Apache2 | 192.168.100.12 |
| Apache3 | 192.168.100.13 |

## On This Killercoda Scenario
Apache is installed on nodes:
**apache1**, **apache2**, and **apache3**

Each node automatically serves a different page
to help identify which server is responding!
