#!/bin/bash

# Set thresholds for alerts
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=90

# Function to send alert
send_alert() {
  echo "System health alert: $1" >> /var/log/health_alerts.log
  # You can add more alert actions here, like sending emails,
  # triggering other scripts, etc.
}

# Get CPU usage
CPU_USAGE=$(grep 'cpu ' /proc/stat | awk '{print $2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15}' | awk '{print $1/($1+$2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15)*100}')

# Get memory usage
MEMORY_USAGE=$(free -m | grep Mem | awk '{print $3/$2*100}')

# Get disk space usage
DISK_USAGE=$(df -h | grep /dev/sda1 | awk '{print $5}' | sed 's/%//g')

# Check if any metric exceeds the threshold
if bc <<< "$CPU_USAGE >= $CPU_THRESHOLD" ; then
  send_alert "CPU usage is above $CPU_THRESHOLD%"
fi

if bc <<< "$MEMORY_USAGE >= $MEMORY_THRESHOLD" ; then
  send_alert "Memory usage is above $MEMORY_THRESHOLD%"
fi

if bc <<< "$DISK_USAGE >= $DISK_THRESHOLD" ; then
  send_alert "Disk space usage is above $DISK_THRESHOLD%"
fi

# Get running processes
echo "Running processes:"
ps aux | awk '{print $11}'
echo "System health check completed."