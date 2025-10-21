#!/bin/bash
# ======================================================
# 🧠 SYSTEM HEALTH REPORT GENERATOR
# Runs all health check scripts and emails the report
# ======================================================

# --- Configuration ---
REPORT_DIR="/opt/syshealth/reports"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT_FILE="$REPORT_DIR/system_health_$TIMESTAMP.txt"
MAIL_TO="admin@example.com"   # ✅ change to your email
HOSTNAME=$(hostname)

# --- Ensure report directory exists ---
mkdir -p "$REPORT_DIR"

# --- Start report ---
{
echo "==============================================="
echo "🧠 SYSTEM HEALTH REPORT - $HOSTNAME"
echo "Generated on: $(date)"
echo "==============================================="
echo

# --- Disk Usage ---
echo "💾 DISK USAGE:"
bash /opt/syshealth/check_disk.sh
echo
echo "-----------------------------------------------"
echo

# --- Running Services ---
echo "⚙️ RUNNING SERVICES:"
bash /opt/syshealth/monitor_services.sh
echo
echo "-----------------------------------------------"
echo

# --- Memory Usage ---
echo "🧠 MEMORY USAGE:"
bash /opt/syshealth/memory_check.sh
echo
echo "-----------------------------------------------"
echo

# --- CPU Usage ---
echo "🔥 CPU USAGE:"
bash /opt/syshealth/cpu_check.sh
echo
echo "-----------------------------------------------"
echo

echo "✅ END OF REPORT"
echo "==============================================="

} > "$REPORT_FILE"

# --- Email the report ---
mail -s "[$HOSTNAME] System Health Report - $TIMESTAMP" "$MAIL_TO" < "$REPORT_FILE"

# --- Optional: clean old reports (older than 7 days) ---
find "$REPORT_DIR" -type f -mtime +7 -name "system_health_*.txt" -delete
