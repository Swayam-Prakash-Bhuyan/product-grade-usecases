#!/bin/bash
# ===============================================
# ⚙️ Linux CPU Usage Assessment Script
# ===============================================

echo "==============================================="
echo "          ⚙️ LINUX CPU USAGE REPORT"
echo "==============================================="
echo "Generated on: $(date)"
echo

# --- CPU Model and Core Info ---
echo "🧩 CPU Information:"
lscpu | grep -E '^Model name|^CPU\(s\)|^Thread|^Core|^Socket'
echo

# --- Overall CPU Usage ---
echo "📊 Current CPU Usage (top 5 processes):"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
echo

# --- Load Average ---
echo "📈 System Load Average:"
uptime
echo

# --- CPU Utilization via mpstat ---
if command -v mpstat >/dev/null 2>&1; then
  echo "🧮 mpstat Summary (average CPU usage):"
  mpstat 1 3
else
  echo "mpstat not found. Install with: sudo apt install sysstat -y"
fi
echo

# --- vmstat snapshot ---
echo "🧾 vmstat (process + CPU stats):"
vmstat 1 3
echo

echo "==============================================="
echo "✅ CPU Usage Assessment Completed"
echo "==============================================="
