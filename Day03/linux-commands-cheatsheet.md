# Day 03 – Linux Commands Cheat Sheet

This is my personal set of Linux commands that I’ll be using regularly while working and troubleshooting systems.

---

## 🛠️ Process Management

- `ps aux` → Shows all the running processes along with their PID  
- `top` → Gives a live view of CPU and memory usage  
- `htop` → Better and more interactive version of top  
- `kill <PID>` → Used to stop a process  
- `kill -9 <PID>` → Forcefully kill a process if it’s not stopping  
- `systemctl status <service>` → Check if a service is running or not  

---

## 📁 File System Commands

- `ls` → List files and directories  
- `cd <dir>` → Move inside a directory  
- `pwd` → Shows current working directory  
- `touch <file>` → Create a new file  
- `mkdir <dir>` → Create a new directory  
- `vim <file>` → Open file in vim editor  
- `cp <src> <dest>` → Copy files or directories  
- `mv <src> <dest>` → Move or rename files  
- `rm <file>` → Delete a file  
- `chmod <mode> <file>` → Change file permissions  

### 🔐 Permission Note
- `chmod 755 file` → Owner gets full access, others can read & execute  
- `chmod 777 file` → Everyone gets full access (generally unsafe)

---

![Linux Networking](../images/linux_networking.png)

## 🌐 Networking Commands

- `ping <host>` → Check if the system can reach another system  
- `curl <url>` → Send request to a server (mostly used for APIs)  
- `ip addr` → Shows IP address of the system  
- `netstat -tulnp` → Shows open ports and running services  

---

## 📜 Logs & Debugging

- `journalctl` → View system logs (very useful for debugging)  
- `journalctl -u <service>` → Logs for a specific service  
- `tail -f <file>` → Monitor logs in real time  
- `head <file>` → Shows top lines of a file  
- `less <file>` → Read large files easily  

---

## 🚀 How I Would Debug a Down Server

If a server is down, my approach would be:

- First check network using `ping`  
- Then check disk space using `df -h`  
- Check CPU/memory using `top`  
- Verify service using `systemctl status`  
- Finally check logs using `journalctl`  

---

## ⭐ Commands I Like the Most

- `ping` → Very quick way to check network connectivity  
- `chmod` → Important for controlling access in multi-user systems  

---

## 📌 Final Thought

Linux commands are something I’ll be using daily as a DevOps engineer.  
The better I get at them, the faster I’ll be able to debug and solve real-world issues.