# 🐚 Shell Scripting Cheat Sheet

---

## 📊 Quick Reference Table

| Topic    | Syntax              | Example                     |
| -------- | ------------------- | --------------------------- |
| Variable | `VAR="value"`       | `NAME="Devansh"`            |
| Argument | `$1`, `$2`          | `./script.sh file.txt`      |
| If       | `if [ cond ]; then` | `if [ -f file ]; then`      |
| For Loop | `for i in list; do` | `for i in 1 2 3; do`        |
| Function | `name() {}`         | `greet() { echo "Hi"; }`    |
| Grep     | `grep pattern file` | `grep -i error log.txt`     |
| Awk      | `awk '{print $1}'`  | `awk -F: '{print $1}' file` |
| Sed      | `sed 's/a/b/g'`     | `sed -i 's/foo/bar/g' file` |

---

# 🧱 1. Basics

### 🔹 Shebang

```bash
#!/bin/bash
```

Defines interpreter for script execution.

---

### 🔹 Running Script

```bash
chmod +x script.sh
./script.sh
bash script.sh
```

---

### 🔹 Comments

```bash
# This is a comment
echo "Hello" # Inline comment
```

---

### 🔹 Variables

```bash
NAME="Devansh"
echo $NAME
echo "$NAME"
echo '$NAME'
```

---

### 🔹 User Input

```bash
read -p "Enter name: " name
echo $name
```

---

### 🔹 Arguments

```bash
echo $0  # script name
echo $1  # first arg
echo $#  # total args
echo $@  # all args
echo $?  # last command status
```

---

# ⚙️ 2. Operators & Conditionals

### 🔹 String

```bash
[ "$a" = "$b" ]
[ "$a" != "$b" ]
[ -z "$a" ]
[ -n "$a" ]
```

---

### 🔹 Integer

```bash
[ $a -eq $b ]
[ $a -gt $b ]
[ $a -lt $b ]
```

---

### 🔹 File Tests

```bash
[ -f file ]
[ -d dir ]
[ -e file ]
[ -r file ]
[ -w file ]
[ -x file ]
```

---

### 🔹 If-Else

```bash
if [ condition ]; then
    echo "Yes"
elif [ condition ]; then
    echo "Maybe"
else
    echo "No"
fi
```

---

### 🔹 Logical

```bash
cmd1 && cmd2
cmd1 || cmd2
! cmd
```

---

### 🔹 Case

```bash
case $var in
  start) echo "Start";;
  stop) echo "Stop";;
  *) echo "Invalid";;
esac
```

---

# 🔁 3. Loops

### 🔹 For Loop

```bash
for i in 1 2 3; do
  echo $i
done
```

---

### 🔹 While Loop

```bash
while [ $n -gt 0 ]; do
  echo $n
done
```

---

### 🔹 Until Loop

```bash
until [ $n -eq 0 ]; do
  echo $n
done
```

---

### 🔹 Break & Continue

```bash
break
continue
```

---

### 🔹 Loop Files

```bash
for file in *.log; do
  echo $file
done
```

---

### 🔹 Read Lines

```bash
while read line; do
  echo $line
done < file.txt
```

---

# 🔧 4. Functions

### 🔹 Define & Call

```bash
greet() {
  echo "Hello $1"
}

greet Devansh
```

---

### 🔹 Return vs Echo

```bash
return 1   # exit code
echo "data" # output
```

---

### 🔹 Local Variable

```bash
myfunc() {
  local var="hello"
}
```

---

# 🧪 5. Text Processing

### 🔹 grep

```bash
grep -i "error" file
grep -c "error" file
grep -n "error" file
```

---

### 🔹 awk

```bash
awk '{print $1}' file
awk -F: '{print $1}' file
```

---

### 🔹 sed

```bash
sed 's/foo/bar/g' file
sed -i 's/foo/bar/g' file
```

---

### 🔹 cut

```bash
cut -d ":" -f1 file
```

---

### 🔹 sort

```bash
sort file
sort -n file
sort -r file
```

---

### 🔹 uniq

```bash
uniq file
uniq -c file
```

---

### 🔹 tr

```bash
tr 'a-z' 'A-Z'
```

---

### 🔹 wc

```bash
wc -l file
wc -w file
```

---

### 🔹 head / tail

```bash
head -5 file
tail -5 file
tail -f file
```

---

# 🚀 6. Useful One-Liners

```bash
# Delete files older than 7 days
find . -type f -mtime +7 -delete

# Count lines in logs
wc -l *.log

# Replace text in all files
sed -i 's/old/new/g' *.txt

# Check service status
systemctl is-active nginx

# Real-time error monitoring
tail -f app.log | grep ERROR
```

---

# ⚠️ 7. Error Handling

### 🔹 Exit Codes

```bash
echo $?
exit 1
```

---

### 🔹 Strict Mode

```bash
set -e
set -u
set -o pipefail
set -x
```

---

### 🔹 Trap

```bash
trap 'echo "Exiting..."' EXIT
```

---

# 🧠 Final Tip

👉 Combine commands → automate → monitor → debug

This cheat sheet is your **DevOps weapon** 🚀
