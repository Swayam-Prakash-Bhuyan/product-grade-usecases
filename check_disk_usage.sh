#!/bin/bash

disk_usage=$(df -h / | tail -1 )
filesystem=$(echo $disk_usage | awk '{print $1}')
size=$(echo $disk_usage | awk '{print $2}')
used=$(echo $disk_usage | awk '{print $3}')
avail=$(echo $disk_usage | awk '{print $4}')     
use_percent=$(echo $disk_usage | awk '{print $5}')

echo "Disk Usage Information for /"
echo "-----------------------------------"
echo "Filesystem: $filesystem"
echo "Size: $size"
echo "Used: $used"
echo "Available: $avail"
echo "Use%: $use_percent"   