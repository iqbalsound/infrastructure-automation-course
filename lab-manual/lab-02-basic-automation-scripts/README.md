# Lab 2: Writing Basic Automation Scripts

|  |  |
|---|---|
| **Week** | 3 |
| **Mapped CLO** | CLO-2 (Apply) |
| **Tools / Environment** | Python 3; Bash (GNU); VS Code or VSCodium |
| **Estimated Time** | 90 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Write basic Python and Bash scripts that automate a repetitive infrastructure task.
- Compare scripting idioms between Python and Bash for the same task.
- Parameterize scripts with command-line arguments and environment variables.

## 2. Preamble / Short Theory

Before adopting dedicated configuration-management or IaC tools, engineers often automate small tasks with plain scripts: checking disk space, rotating logs, creating directory structures. This lab builds that scripting foundation using only free, built-in language features and reinforces the automation maturity model from Week 1 (ad-hoc scripts to standardized scripts).

## 3. Prerequisites

- Lab 1 completed.
- Python 3 and a Bash-capable shell (native on Linux and macOS; WSL2 on Windows).

## 4. Step-by-Step Guide

### Step 1: Write a Bash disk-usage check

Save as `disk_check.sh` and make it executable with `chmod +x disk_check.sh`.

📄 **File:** `disk_check.sh`

```bash
#!/usr/bin/env bash
THRESHOLD=80
USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "WARNING: disk usage at ${USAGE}%"
else
  echo "OK: disk usage at ${USAGE}%"
fi
```

> 💾 Saved in this folder: [`disk_check.sh`](disk_check.sh)

### Step 2: Write the equivalent in Python

Save as `disk_check.py`.

📄 **File:** `disk_check.py`

```python
import shutil

THRESHOLD = 80
total, used, free = shutil.disk_usage("/")
percent = used / total * 100
print(f"{'WARNING' if percent >= THRESHOLD else 'OK'}: disk usage at {percent:.1f}%")
```

> 💾 Saved in this folder: [`disk_check.py`](disk_check.py)

Run both scripts and compare their output. They differ slightly because `df` and `shutil.disk_usage` calculate the used percentage differently; note the difference and explain it in one sentence.

### Step 3: Parameterize both scripts

Accept the threshold as a command-line argument in each version instead of the hard-coded constant, and make the scripts exit with a non-zero status when the threshold is exceeded so that other tools can react to the result.

### Step 4: Use environment variables

Extend both scripts so that, when no argument is supplied, the threshold is read from the environment variable `DISK_THRESHOLD`, falling back to 80 if it is not set.

```bash
DISK_THRESHOLD=50 ./disk_check.sh
./disk_check.sh 10
./disk_check.sh 95
```

### Step 5: Automate bulk directory creation

Create `hosts.txt` and write a script (either language) that reads it and creates `<host>/logs` and `<host>/configs` for every host. Blank lines and lines beginning with `#` must be ignored, and running the script twice must not fail (idempotency).

📄 **File:** `hosts.txt`

```text
web01
web02
db01
# comments and blank lines are ignored

cache01
```

> 💾 Saved in this folder: [`hosts.txt`](hosts.txt)

### Step 6: Compare the two languages

Write a short comparison (bullet points are fine) of readability, portability, and error handling between your Bash and Python versions.

## 5. Your Tasks / Required Outcomes

- Both script versions (Bash and Python) plus the bulk directory-creation script.
- A dated terminal screenshot showing both versions run with at least two different threshold values, and the directory script run twice.
- A short written comparison (maximum half a page) of the two scripting approaches.

## 📁 Files in this folder

- [`disk_check.py`](disk_check.py)
- [`disk_check.sh`](disk_check.sh)
- [`hosts.txt`](hosts.txt)

---
⬅️ [Back to Lab Manual index](../README.md)
