#!/bin/bash

# System Monitor Script
# This script monitors CPU, Memory, and Disk usage and alerts if they exceed the defined thresholds.

# Thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=90

# Function to check CPU usage
check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "Current CPU Usage: $CPU_USAGE%"
    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        echo "ALERT: CPU usage is above $CPU_THRESHOLD%!"
    else
        echo "CPU usage is within safe limits."
    fi
}

# Function to check Memory usage
check_memory() {
    MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "Current Memory Usage: $MEMORY_USAGE%"
    if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
        echo "ALERT: Memory usage is above $MEMORY_THRESHOLD%!"
    else
        echo "Memory usage is within safe limits."
    fi
}

# Function to check Disk usage
check_disk() {
    DISK_USAGE=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
    echo "Current Disk Usage: $DISK_USAGE%"
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        echo "ALERT: Disk usage is above $DISK_THRESHOLD%!"
    else
        echo "Disk usage is within safe limits."
    fi
}

# Main script execution
echo "Starting system monitor..."
check_cpu
check_memory
check_disk
echo "System monitor check complete."
