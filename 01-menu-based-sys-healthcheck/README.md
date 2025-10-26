
---

## 🧠 **Menu-Based System Health Check Script**

This project provides a **modular, menu-driven Linux system health check solution** that:

* Assesses **CPU**, **Memory**, and **Disk** usage
* Monitors **Running Services**
* Generates a **comprehensive report**
* Sends it automatically via **email every 4 hours** using **Postfix**

---

## 📂 **Project Structure**

```
01-menu-based-sys-healthcheck/
│
├── assess_memory_usage.sh        # Memory usage assessment
├── check_disk_usage.sh           # Disk space report
├── cpu_check.sh                  # CPU performance evaluation
├── monitor_running_system.sh     # Running services check
├── system_health_report.sh       # Master script (collects + emails report)
├── mail_setups.md                # Postfix setup & email configuration guide
└── README.md                     # (this file)
```

---

## ⚙️ **1. Prerequisites**

Ensure your system has the following tools installed:

```bash
sudo apt update
sudo apt install mailutils sysstat postfix -y
```

* **mailutils** → sends emails from CLI
* **sysstat** → provides `mpstat`, `sar` utilities for CPU metrics
* **postfix** → handles mail delivery

---

## 💌 **2. Postfix Setup (Email Sending)**

If not already configured, follow these steps (full details in `mail_setups.md`):

```bash
sudo apt install postfix -y
sudo systemctl enable postfix
sudo systemctl start postfix
```

When prompted:

* Choose **Internet Site**
* Enter your server’s hostname (e.g., `server01.example.com`)

Test email sending:

```bash
echo "Health check test email" | mail -s "Test Email" admin@example.com
```

✅ If you receive the email, Postfix is working.

---

## 🧩 **3. Make All Scripts Executable**

Run once:

```bash
cd 01-menu-based-sys-healthcheck
chmod +x *.sh
```

---

## 🧱 **4. Place Scripts in a System Path**

Move all scripts to a central directory:

```bash
sudo mkdir -p /opt/syshealth
sudo cp *.sh /opt/syshealth/
```

Create a reports directory:

```bash
sudo mkdir -p /opt/syshealth/reports
```

---

## 🧮 **5. Individual Script Usage**

| Script                      | Purpose                                                        | Command                          |
| --------------------------- | -------------------------------------------------------------- | -------------------------------- |
| `check_disk_usage.sh`       | Shows disk usage (df -h)                                       | `bash check_disk_usage.sh`       |
| `monitor_running_system.sh` | Lists active systemd services                                  | `bash monitor_running_system.sh` |
| `assess_memory_usage.sh`    | Displays memory utilization & top memory processes             | `bash assess_memory_usage.sh`    |
| `cpu_check.sh`              | Shows CPU usage, load average, and top CPU-consuming processes | `bash cpu_check.sh`              |
| `system_health_report.sh`   | Runs all checks, creates report, and emails it                 | `bash system_health_report.sh`   |

---

## 📧 **6. Configure Email Delivery in `system_health_report.sh`**

Open the script:

```bash
sudo nano /opt/syshealth/system_health_report.sh
```

Find and edit this section:

```bash
MAIL_TO="admin@example.com"   # ✅ change to your email
```

You can add multiple recipients separated by spaces:

```bash
MAIL_TO="admin1@example.com admin2@example.com"
```

---

## 🕓 **7. Automate Every 4 Hours (via Cron)**

Edit root’s crontab:

```bash
sudo crontab -e
```

Add this line:

```
0 */4 * * * /opt/syshealth/system_health_report.sh >/dev/null 2>&1
```

✅ This runs the health check automatically at:

```
00:00, 04:00, 08:00, 12:00, 16:00, 20:00
```

---

## 📄 **8. Example Email Report**

**Subject:**

```
[server01] System Health Report - 2025-10-21_16-00-00
```

**Body (Excerpt):**

```
===============================================
🧠 SYSTEM HEALTH REPORT - server01
Generated on: Tue Oct 21 16:00:00 IST 2025
===============================================

💾 DISK USAGE:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        40G   12G   26G  32% /

⚙️ RUNNING SERVICES:
sshd.service active
nginx.service active

🧠 MEMORY USAGE:
Total: 15Gi | Used: 3.2Gi | Free: 8.1Gi | Buffers/Cache: 3.7Gi

🔥 CPU USAGE:
Load Average: 0.32, 0.28, 0.25
Top CPU-consuming process: java (35.4%)
```

---

## 🧹 **9. Report Storage & Cleanup**

* All reports are saved in:

  ```
  /opt/syshealth/reports/
  ```
* Old reports (older than 7 days) are automatically deleted by:

  ```bash
  find "$REPORT_DIR" -type f -mtime +7 -name "system_health_*.txt" -delete
  ```

---

## 🚀 **10. Optional Enhancements**

* Generate **HTML email reports** with color-coded output using `mailx`
* Add **Slack or Teams webhook** for alerts
* Extend the menu to allow **interactive system checks**

---

## 🧰 **11. Troubleshooting**

| Issue                    | Solution                                         |
| ------------------------ | ------------------------------------------------ |
| Email not delivered      | Check `/var/log/mail.log`                        |
| `mail` command not found | Install with `sudo apt install mailutils`        |
| Postfix not running      | `sudo systemctl restart postfix`                 |
| Cron not executing       | Verify cron status: `sudo systemctl status cron` |

---

## 🏁 **12. Summary**

✅ Features Implemented

* Disk, CPU, Memory, and Service Monitoring
* Centralized Reporting
* Automatic Email Delivery (Postfix)
* Scheduled via Cron
* Modular Shell Scripts

---

### 💡 Example Commands Recap

```bash
# Run once manually
bash /opt/syshealth/system_health_report.sh

# Test email
echo "Hello" | mail -s "Test" admin@example.com

# Check cron logs
grep CRON /var/log/syslog
```

---

**Author:** *Swayam*
**Version:** `v1.0`
**Last Updated:** `October 2025`

---

