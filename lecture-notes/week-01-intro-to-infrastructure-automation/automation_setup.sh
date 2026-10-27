#!/bin/bash
# Example: simple automation script (Bash)
echo "Automated Environment Setup - $(date)"
mkdir -p ~/infra-automation-course/week1
cd ~/infra-automation-course/week1
df -h > disk_report_$(date +%F).txt
echo "Report generated successfully."
