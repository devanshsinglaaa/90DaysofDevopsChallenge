# Day 04 – Linux Practice: Processes and Services

Today I practiced some basic Linux commands to understand how processes and services work in real systems.

---

## 🛠️ Process Checks

### Command:
`ps aux | head`

### Output Observed:
- It listed currently running processes along with their PID and user  
- I noticed the first process is usually `systemd` (PID 1)  
- I also saw Python-based processes (gunicorn) running in my system  

---

### Command:
`top`

### Observation:
- Shows real-time CPU and memory usage  
- Helps identify which process is consuming more resources  

---

## ⚙️ Service Checks

### Command:
`systemctl status nginx`

### Observation:
- Used to check whether the service is active or inactive  
- Shows details like:
  - Service state (running/stopped)  
  - Main PID  
  - Logs summary  

---

### Command:
`sudo systemctl start nginx`

### Observation:
- Used to start a service manually  
- Can also use `stop` and `restart` for managing services  

---

## 📜 Log Checks

### Command:
`journalctl -u nginx --no-pager | tail -n 10`

### Observation:
- Displays the last 10 log entries of the nginx service  
- Useful for debugging errors and checking recent activity  

---

## 🚀 Mini Troubleshooting Flow

If a service is not running, my approach would be:

1. Check service status:
   - `systemctl status <service>`

2. Check if process is running:
   - `ps aux | head`

3. Check logs for errors:
   - `journalctl -u <service>`

4. Analyze:
   - If logs show error → fix configuration or dependency  
   - If no logs → try restarting the service  

---

## 📌 Key Learning

- Learned how to inspect running processes using `ps` and `top`  
- Understood how to manage services using `systemctl`  
- Logs from `journalctl` are very useful for debugging issues  

This practice helped me understand how real troubleshooting works in Linux systems.