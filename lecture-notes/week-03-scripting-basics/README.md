# Week 3: Scripting Basics for Automation (Python, Bash, PowerShell)

## 🎯 Learning Objectives

- Apply Bash scripting constructs (variables, loops, conditionals, functions) to automate system tasks.
- Apply Python scripting fundamentals relevant to infrastructure automation (file handling, subprocess execution, basic parsing).
- Recognise the role of PowerShell in Windows-based infrastructure automation.
- Write and execute simple, reusable automation scripts.

## 🛠️ Hour 3 - Lab: Writing Automation Scripts

### Task

Lab Task A: Write a Bash script that automates local backup of a directory, adding a timestamp to the archive name and logging success/failure to a log file.

Lab Task B: Write a Python script that reads a CSV or text file listing multiple 'servers' (simulated as local folders/ports) and reports free disk space or a simulated health status for each.

Briefly introduce PowerShell Core (open source, cross-platform) syntax equivalents for the Bash concepts covered, so students recognize the parallel constructs (Get-ChildItem, ForEach-Object, If/Else) even without a full hands-on session.

Students commit both scripts to their GitHub repository under a week folder, continuing the version-control habit from Week 1.

### ✅ Solution / Example Code

📄 **File:** `backup.sh`

```bash
#!/bin/bash
# Bash: simple backup automation
set -euo pipefail
SRC="$HOME/infra-automation-course"
DEST="$HOME/backups"
mkdir -p "$DEST"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
tar -czf "$DEST/backup_$TIMESTAMP.tar.gz" "$SRC" \
  && echo "Backup succeeded: $TIMESTAMP" >> backup.log \
  || echo "Backup FAILED: $TIMESTAMP" >> backup.log
```

> 💾 Saved in this folder: [`backup.sh`](backup.sh)

📄 **File:** `disk_usage_check.py`

```python
# Python: disk usage check across a list of servers
import shutil
servers = ["server1", "server2", "server3"]
for s in servers:
    total, used, free = shutil.disk_usage("/")
    print(f"{s}: free={free // (2**30)} GB")
```

> 💾 Saved in this folder: [`disk_usage_check.py`](disk_usage_check.py)

### 🧰 Recommended Open-Source / Free Tools

- Bash
- Python 3 (free)
- PowerShell Core (open source)
- VS Code

## 📁 Files in this folder

- [`backup.sh`](backup.sh)
- [`disk_usage_check.py`](disk_usage_check.py)

---
⬅️ [Back to Lecture Notes index](../README.md)
