#!/bin/bash

# System Health Check Script
# Author: Your Name
# Date: 2025-05-17

REPORT="/tmp/system_health_report_$(date +'%Y%m%d_%H%M%S').txt"

echo "System Health Report - $(date)" > $REPORT
echo "===================================" >> $REPORT

echo -e "\nCPU Usage:" >> $REPORT
top -bn1 | grep "Cpu(s)" >> $REPORT

echo -e "\nMemory Usage:" >> $REPORT
free -h >> $REPORT

echo -e "\nDisk Usage:" >> $REPORT
df -h >> $REPORT

echo -e "\nTop 5 Memory-consuming Processes:" >> $REPORT
ps aux --sort=-%mem | head -n 6 >> $REPORT

echo -e "\nChecking Services (sshd, nginx, mysql):" >> $REPORT
for service in sshd nginx mysql; do
    systemctl is-active --quiet $service
    if [ $? -eq 0 ]; then
        echo "$service is running" >> $REPORT
    else
        echo "$service is NOT running" >> $REPORT
    fi
done

echo -e "\nReport saved at $REPORT"

# Optional: send email (configure mail server beforehand)
# mail -s "System Health Report" your.email@example.com < $REPORT
