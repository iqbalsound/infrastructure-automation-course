# Week 1: Introduction to Infrastructure Automation and its Role in Cloud Computing

## 🎯 Learning Objectives

- Define infrastructure automation and distinguish it from traditional manual system administration.
- Explain the evolution of infrastructure management from bare-metal to cloud-native environments.
- Identify the categories of automation: provisioning, configuration management, and orchestration.
- Describe how automation supports scalability, reliability, and operational efficiency in cloud computing.

## 🛠️ Hour 3 - Lab: Setting Up the Automation Toolchain

### Task

Guide students through installing and configuring the free, open-source tools that will be used throughout the semester: Git, a text editor/IDE (VS Code), and a terminal/shell environment (Bash on Linux/macOS or WSL on Windows).

Create a GitHub account (free tier) and initialize a personal course repository to store all weekly lab work and assignments.

Write and execute a first automation script in Bash that performs a repetitive administrative task (e.g., creating a folder structure, generating log files with timestamps, or checking free disk space) to concretely illustrate the difference between a manual task and an automated one.

Commit and push the first script to the student's GitHub repository, establishing the version-control habit that will be reinforced every week.

### ✅ Solution / Example Code

📄 **File:** `automation_setup.sh`

```bash
#!/bin/bash
# Example: simple automation script (Bash)
echo "Automated Environment Setup - $(date)"
mkdir -p ~/infra-automation-course/week1
cd ~/infra-automation-course/week1
df -h > disk_report_$(date +%F).txt
echo "Report generated successfully."
```

> 💾 Saved in this folder: [`automation_setup.sh`](automation_setup.sh)

### 🧰 Recommended Open-Source / Free Tools

- Git (open source)
- Visual Studio Code (free)
- Bash / WSL (free)
- GitHub free tier

## 📁 Files in this folder

- [`automation_setup.sh`](automation_setup.sh)

---
⬅️ [Back to Lecture Notes index](../README.md)
