#!/bin/bash

echo "==============================================="
echo "        🧠 LINUX MEMORY USAGE REPORT"
echo "==============================================="
echo "Generated on: $(date)"
echo

# --- System Memory Overview ---
echo "📊 Overall Memory Usage (free -h):"
free -h
echo

# --- Top Memory Consuming Processes ---
echo "🔥 Top 10 Memory Consuming Processes:"
ps aux --sort=-%mem | head -n 11
echo

# --- Memory Details from /proc/meminfo ---
echo "📘 Detailed Memory Info (first 10 lines):"
head -n 10 /proc/meminfo
echo

# --- Swap Usage ---
echo "💾 Swap Usage:"
swapon --show || echo "Swap not configured."
echo

# --- Cached / Buffers ---
echo "🧩 Memory Statistics via vmstat:"
vmstat -s | grep -E 'mem|swap|cache'
echo

# --- Optional: Process Count Summary ---
echo "🧍 Process Memory Summary:"
ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -n 15
echo

echo "==============================================="
echo "✅ Memory Assessment Completed"
echo "==============================================="
