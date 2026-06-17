# Congratulations! 🎉

You have successfully completed the
**Load Balancing Analysis using Least Connection Method**
scenario!

## What You Have Accomplished

```
✅ Understood load balancing architecture
✅ Installed Apache Web Server on 3 nodes
✅ Configured Apache with unique pages
✅ Installed and configured HAProxy with Least Connection method
✅ Performed load testing using Apache JMeter
```

## Conclusions

Based on this scenario and the original research:

**1. Least Connection is Effective**
The Least Connection method successfully distributes
traffic based on active connections, resulting in
more balanced and efficient load distribution
compared to static methods like Round Robin.

**2. System Stability**
The system remained stable even under high workloads
(up to 1000 concurrent users), with low error rates
and acceptable response times.

**3. Scalability**
Adding more backend servers is straightforward —
simply add a new server line in HAProxy configuration
without downtime.

**4. Killercoda Implementation**
This scenario successfully demonstrated load balancing
on a single node using different ports to simulate
multiple servers — proving the concept works
regardless of the infrastructure setup.

## Suggestions

**For Better Performance:**
- Use dedicated servers for each component
  (as done in the original VMware research)
- Implement health checks and automatic failover
- Monitor server metrics using Prometheus & Grafana

**For Production Environment:**
- Deploy on cloud platforms (AWS, Azure, GCP)
  for better scalability and reliability
- Use HTTPS instead of HTTP for security
- Implement rate limiting in HAProxy
- Set up automated backup and monitoring

**For Further Research:**
- Compare Least Connection with other methods
  (Round Robin, Weighted Least Connection)
- Test with higher concurrent users (>1000)
- Implement in containerized environment (Docker + Kubernetes)

