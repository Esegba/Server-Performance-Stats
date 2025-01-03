#!/bin/bash

# Total CPU usage
echo "Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
awk '{print 100 - $1"%"}'

# Total memory usage (Free vs Used including percentage)
echo "Total Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB (%.2f%%), Free: %sMB (%.2f%%)\n", $3, $3*100/$2, $4, $4*100/$2}'

# Total disk usage (Free vs Used including percentage)
echo "Total Disk Usage:"
df -h | awk '$NF=="/"{printf "Used: %dGB (%s), Free: %dGB (%s)\n", $3, $5, $4, $5}'

# Top 5 processes by CPU usage
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by memory usage
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

# Stretch goal: Additional stats
echo "OS Version:"
lsb_release -a

echo "Uptime:"
uptime

echo "Load Average:"
uptime | awk -F'load average:' '{ print $2 }'

echo "Logged in Users:"
who

echo "Failed Login Attempts:"
grep "Failed password" /var/log/auth.log | wc -l

