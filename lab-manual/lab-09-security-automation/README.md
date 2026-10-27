# Lab 9: Security in Infrastructure Automation

|  |  |
|---|---|
| **Week** | 12 |
| **Mapped CLO** | CLO-3 (Evaluate) |
| **Tools / Environment** | OpenSCAP; Lynis; Docker or a Linux VM |
| **Estimated Time** | 120 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Evaluate the security and compliance posture of a target using open-source scanning tools.
- Run and interpret an OpenSCAP compliance scan.
- Run and interpret a Lynis hardening audit.
- Propose automated remediation for the findings.

## 2. Preamble / Short Theory

Automation that provisions infrastructure quickly can just as quickly propagate a misconfiguration. OpenSCAP (open source, Red Hat) and Lynis (open source, CISOfy) are free compliance and hardening auditors that let you evaluate, not just apply, automation outcomes.

A container shares the host kernel and has no boot loader, so some rules are not applicable and will be reported as such. Treat the container as a teaching target and say so in your evaluation; a Vagrant VM gives more complete results if you have one.

## 3. Prerequisites

- Docker installed (or a Debian/Ubuntu VM you can scan as root).
- Lab 3 completed (for the remediation discussion).

## 4. Step-by-Step Guide

### Step 1: Start a scan target and install the tools

```bash
docker run -it --name scan-target debian:12 bash

# inside the container:
apt-get update
apt-get install -y openscap-scanner ssg-debian lynis procps
cd /root
```

### Step 2: Locate the compliance content and list profiles

The exact data-stream file name depends on the Debian release, so list the directory first and use the name you see. Choose one profile ID printed by `oscap info`.

```bash
ls /usr/share/xml/scap/ssg/content/
DS=/usr/share/xml/scap/ssg/content/ssg-debian12-ds.xml    # use the file name printed above
oscap info "$DS"                                           # lists the available profile IDs

oscap xccdf eval \
  --profile <PROFILE_ID_FROM_OSCAP_INFO> \
  --results results.xml --report report.html \
  "$DS"
# exit status 2 simply means "some rules failed" - that is expected
```

### Step 3: Review the HTML report

Copy `report.html` out of the container and open it in a browser. Identify the three highest-severity failed rules and, for each, note what the rule checks and why it matters.

```bash
docker cp scan-target:/root/report.html ./report.html
docker cp scan-target:/var/log/lynis-report.dat ./lynis-report.dat
```

### Step 4: Run Lynis

Back inside the container, run the audit and extract the hardening index and the top five suggestions.

```bash
lynis audit system
grep hardening_index /var/log/lynis-report.dat
grep '^suggestion\[\]' /var/log/lynis-report.dat | head -n 5
```

### Step 5: Write an evaluation

In a short report (maximum one page), evaluate whether the scanned target is fit for production use, citing specific findings from both tools, and propose which automation step (an Ansible task, a Puppet resource, or a Terraform setting) could remediate each issue.

## 5. Your Tasks / Required Outcomes

- `report.html` (OpenSCAP) and the Lynis report or log.
- The written evaluation (maximum one page) with specific, cited findings and proposed automated remediation.
- A dated screenshot of both scans running.

---
⬅️ [Back to Lab Manual index](../README.md)
