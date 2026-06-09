# Day 20 – Log Analyzer Script

---

## 📜 Script: log_analyzer.sh

```bash
#!/bin/bash

# Check input
if [ $# -eq 0 ]; then
    echo "Usage: ./log_analyzer.sh <log_file>"
    exit 1
fi

LOGFILE=$1

# Check if file exists
if [ ! -f "$LOGFILE" ]; then
    echo "Error: File doesn't exist"
    exit 1
fi

echo "Analysing Log file : $LOGFILE"

# -------------------------------
# Error Count
# -------------------------------
echo "Counting Errors....."

ERRORS=$(grep -Ei "ERROR|Failed" "$LOGFILE" | wc -l)

echo "Error Count : $ERRORS"

# -------------------------------
# Critical Events
# -------------------------------
echo ""
echo "===== CRITICAL LINES ====="

grep -ni "CRITICAL" "$LOGFILE" | while IFS=: read lineno message
do
    echo "Line $lineno: $message"
done

# -------------------------------
# Top 5 Error Messages
# -------------------------------
echo ""
echo "Top 5 Error Messages (Most Repeated one's)"

grep -Ei "ERROR" "$LOGFILE" \
| awk '{$1=$2=$3=""; print $0}' \
| sort \
| uniq -c \
| sort -rn \
| head -5

# -------------------------------
# Summary File (simple direct name)
# -------------------------------
echo ""
echo "Generating report file..."

DATE=$(date +%Y-%m-%d)

echo "===== LOG REPORT =====" > log_report_$DATE.txt
echo "Date : $DATE" >> log_report_$DATE.txt
echo "Log File : $LOGFILE" >> log_report_$DATE.txt

TOTAL_LINES=$(wc -l < "$LOGFILE")
echo "Total Lines : $TOTAL_LINES" >> log_report_$DATE.txt
echo "Total Errors : $ERRORS" >> log_report_$DATE.txt

echo "" >> log_report_$DATE.txt
echo "===== Top Errors =====" >> log_report_$DATE.txt

grep -Ei "ERROR" "$LOGFILE" \
| awk '{$1=$2=$3=""; print $0}' \
| sort \
| uniq -c \
| sort -rn \
| head -5 >> log_report_$DATE.txt

echo "" >> log_report_$DATE.txt
echo "===== Critical Events =====" >> log_report_$DATE.txt

grep -ni "CRITICAL" "$LOGFILE" >> log_report_$DATE.txt

echo ""
echo "Report Generated : log_report_$DATE.txt"
```

---

## ▶️ Run

```bash
chmod +x log_analyzer.sh
./log_analyzer.sh samplelog.log
```

---

## 📄 Output File

```bash
cat log_report_$(date +%Y-%m-%d).txt
```

---

## 🔥 What This Script Does

* Validates input file
* Counts ERROR & Failed logs
* Extracts CRITICAL events with line numbers
* Finds top 5 repeated error messages
* Generates a clean report file

---

## 🧠 Key Learnings

* `grep`, `awk`, `sort`, `uniq` for log analysis
* Looping with `while read`
* File handling and report generation

---

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
