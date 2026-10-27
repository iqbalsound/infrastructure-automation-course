# Infrastructure Automation: Hands-on Labs and Weekly Tasks

> **CCIA-5214 Infrastructure Automation** · Hamdard University Karachi · Fall 2026
> Course instructor: Iqbal Uddin Khan

A step-by-step, learn-by-doing repository that turns the course into 12 guided labs and 15 weekly hands-on tasks. Every lab and weekly task has its own folder with a `README.md` (objectives, theory, steps, and the tasks you must complete) and the ready-to-use configuration, script, and code files, so you can clone the repo and follow along in order.

**Everything uses free and open-source tools.** No paid cloud account is required.

---

## 📚 What is inside

| Folder | What you get |
|---|---|
| [`lab-manual/`](lab-manual/) | 12 guided labs: objectives, short theory, prerequisites, a step-by-step guide with commands and files, and the tasks you must submit. |
| [`lecture-notes/`](lecture-notes/) | The Hour-3 hands-on task of each of the 15 weeks, with the example code that goes with it. |

### Repository layout

```text
infrastructure-automation-course/
├── README.md                  <- you are here
├── .gitignore
├── lab-manual/
│   ├── README.md              <- lab index, ports, tooling policy
│   ├── lab-01-introduction-to-iac/
│   │   ├── README.md          <- the full lab guide
│   │   └── main.tf            <- files you create in the lab
│   ├── lab-02-basic-automation-scripts/
│   └── ... (labs 03 to 12)
└── lecture-notes/
    ├── README.md              <- weekly index
    ├── week-01-intro-to-infrastructure-automation/
    │   ├── README.md          <- the week's task and example code
    │   └── automation_setup.sh
    └── ... (weeks 02 to 15)
```

---

## 🚀 How to use this repository

1. **Clone** it and open it in VS Code (or any editor):
   ```bash
   git clone https://github.com/iqbalsound/infrastructure-automation-course.git
   cd infrastructure-automation-course
   ```
2. **Set up the toolchain** (see [Prerequisites](#-prerequisites)).
3. **Follow the learning path in order** (see below). Open the folder's `README.md`, read the objectives and theory, then run the steps yourself.
4. **Type or copy the files** from the lab folder into a fresh working directory and run the commands. Try to write each file yourself first and use the provided one to check your work.
5. **Finish the "Your Tasks / Required Outcomes" section** of each lab before moving on.

> 💡 Labs 6, 7, 8, 10, 11, and 12 build on earlier labs, so complete the labs in sequence.

---

## 🧰 Prerequisites

- A laptop or desktop with Windows, macOS, or Linux. **Windows users should run all Bash, Docker, and OpenTofu commands inside WSL2** (free).
- A stable internet connection for downloads.
- Tools installed progressively through the labs: **Git, OpenTofu (or Terraform), Docker, Python 3, Ansible, OpenVox (Puppet), Minikube, kubectl, Jenkins, Prometheus, Grafana, OpenSCAP, Lynis, MinIO, Velero**.
- Replace placeholders such as `Your Name - Roll No` with your own values.

---

## 🗺️ Learning path

### Part 1: Lab Manual (12 labs)

| Lab | Title | Week | CLO | Tools | Time |
|---|---|---|---|---|---|
| 1 | [Introduction to Infrastructure as Code (IaC)](lab-manual/lab-01-introduction-to-iac/) | 1 | CLO-1 (Understand) | OpenTofu (open source) or Terraform; Git; OS terminal | 90 minutes |
| 2 | [Writing Basic Automation Scripts](lab-manual/lab-02-basic-automation-scripts/) | 3 | CLO-2 (Apply) | Python 3; Bash (GNU); VS Code or VSCodium | 90 minutes |
| 3 | [Configuration Management with Ansible](lab-manual/lab-03-ansible-configuration-management/) | 4 | CLO-2 (Apply) | Ansible (open source); Docker (disposable target hosts); OpenSSH | 120 minutes |
| 4 | [Automating Deployments with Puppet (OpenVox)](lab-manual/lab-04-puppet-openvox/) | 4 | CLO-2 (Apply) | OpenVox/Puppet open-source agent; Docker (disposable host) | 90 minutes |
| 5 | [Container Orchestration Basics](lab-manual/lab-05-container-orchestration/) | 5 | CLO-2 (Apply) | Docker; Kubernetes via Minikube; kubectl | 90 minutes |
| 6 | [Infrastructure Provisioning with Terraform / OpenTofu](lab-manual/lab-06-terraform-opentofu-provisioning/) | 6 | CLO-2 (Apply) | OpenTofu (or Terraform); Docker provider; Git | 120 minutes |
| 7 | [CI/CD Pipeline Automation](lab-manual/lab-07-cicd-pipeline-automation/) | 11 | CLO-2 (Apply) | Jenkins (open source, self-hosted); Git; Docker; GitHub Actions free tier (optional) | 150 minutes |
| 8 | [Automated Monitoring and Logging](lab-manual/lab-08-monitoring-and-logging/) | 10 | CLO-2 (Apply) | Prometheus; Grafana; node_exporter; Docker | 120 minutes |
| 9 | [Security in Infrastructure Automation](lab-manual/lab-09-security-automation/) | 12 | CLO-3 (Evaluate) | OpenSCAP; Lynis; Docker or a Linux VM | 120 minutes |
| 10 | [Multi-Cloud Automation Case Study](lab-manual/lab-10-multi-cloud-case-study/) | 13 | CLO-3 (Evaluate) | OpenTofu; Ansible; Docker provider | 150 minutes |
| 11 | [Disaster Recovery Automation](lab-manual/lab-11-disaster-recovery/) | 13 | CLO-3 (Evaluate) | Velero; MinIO; Restic; Minikube; kubectl | 150 minutes |
| 12 | [Capstone Project: Design and Implement an IaC Solution](lab-manual/lab-12-capstone-project/) | 15 | CLO-3 (Evaluate) | OpenTofu; Ansible; Jenkins; any tools from Labs 1-11 | Teams of 2-3, multi-session |

### Part 2: Weekly hands-on tasks (15 weeks)

| Week | Topic | Content |
|---|---|---|
| 1 | [Introduction to Infrastructure Automation and its Role in Cloud Computing](lecture-notes/week-01-intro-to-infrastructure-automation/) | Code + task |
| 2 | [Principles of Infrastructure as Code (IaC)](lecture-notes/week-02-principles-of-iac/) | Code + task |
| 3 | [Scripting Basics for Automation (Python, Bash, PowerShell)](lecture-notes/week-03-scripting-basics/) | Code + task |
| 4 | [Configuration Management Tools Overview (Ansible, Puppet, Chef)](lecture-notes/week-04-configuration-management-tools/) | Code + task |
| 5 | [Orchestration Frameworks and Automated Workflows](lecture-notes/week-05-orchestration-frameworks/) | Code + task |
| 6 | [Terraform Deep Dive - Provisioning Cloud Resources](lecture-notes/week-06-terraform-deep-dive/) | Code + task |
| 7 | [CloudFormation Concepts and Multi-Cloud Automation](lecture-notes/week-07-cloudformation-and-multicloud/) | Code + task |
| 8 | [Midterm Review and Assessment](lecture-notes/week-08-midterm-review/) | Discussion / written task |
| 9 | [Automated Provisioning and Scaling](lecture-notes/week-09-automated-provisioning-and-scaling/) | Code + task |
| 10 | [Monitoring and Logging in Automated Infrastructure](lecture-notes/week-10-monitoring-and-logging/) | Code + task |
| 11 | [Integration with CI/CD Pipelines](lecture-notes/week-11-cicd-integration/) | Code + task |
| 12 | [Security and Compliance in Automation](lecture-notes/week-12-security-and-compliance/) | Code + task |
| 13 | [Enterprise Automation Case Studies](lecture-notes/week-13-enterprise-case-studies/) | Discussion / written task |
| 14 | [Best Practices in Infrastructure Automation](lecture-notes/week-14-best-practices/) | Discussion / written task |
| 15 | [Capstone Lab - Design an Infrastructure as Code Solution](lecture-notes/week-15-capstone-lab/) | Code + task |

**Suggested order:** work through the weekly task for a topic first (it introduces the idea with a small example), then do the matching lab for the full guided exercise. The *Week* column in the lab table shows which weeks each lab matches.

---

## 🔌 Host ports used by the labs

To avoid clashes, each lab uses its own ports. If a port is already in use, stop the earlier lab's containers first.

| **Lab** | **Host ports** | **Purpose** |
|---|---|---|
| 3 | 2221, 2222, 8181, 8182 | SSH and HTTP for the two Ansible target containers |
| 6 | 8080 and up | Web containers (one port per container) |
| 7 | 8090, 50000 | Jenkins web interface and agent port |
| 8 | 9090, 9100, 3000 | Prometheus, node-exporter, Grafana |
| 11 | 9000, 9001 | MinIO API and console |
| 12 | 8088, 9091, 8090 | Load balancer, Prometheus, Jenkins |

## 🔓 Open-source tooling policy

Where the course outline names a proprietary tool, an open-source equivalent is used:

| **Item in course outline** | **Approach used in this manual** |
|---|---|
| Terraform (Labs 1, 6, 10, 12) | OpenTofu (MPL-2.0), command `tofu`. Terraform releases from 1.6 onward use the Business Source License, which is source-available rather than open source. Syntax and workflow are identical; replace `tofu` with `terraform` if you prefer. |
| Puppet Open Source (Lab 4) | OpenVox, the community-maintained open-source distribution. The `puppet` command and manifest language are unchanged. |
| GitHub Actions (Lab 7) | Jenkins (self-hosted, open source) is the primary CI/CD tool; the GitHub Actions free tier is an optional alternative. |
| Velero with Restic (Lab 11) | Velero's file-system backup now uses Kopia (Restic was deprecated and removed from its backup path). Restic is practiced as a standalone tool. |
| AWS CloudFormation (Week 7) and Google Cloud Deployment Manager (Week 9) | Theory only. No lab requires a proprietary cloud service; auto-scaling is practiced with Kubernetes. |

---

## ⚠️ Good practice

- Never commit secrets. The `.gitignore` in this repo already excludes Terraform/OpenTofu state, SSH keys, and the Velero credentials file.
- Lab files with credentials ship as `*.example` (for example `credentials-velero.example`). Copy the file to the real name before use.
- Always run `plan` (or a dry run) before `apply`, and run `destroy` / clean-up steps at the end of each lab to free ports and resources.

## 📝 About this content

The labs and weekly tasks come from the Fall 2026 course materials for CCIA-5214. Assessment questions, quizzes, and the instructor solution manual are intentionally **not** included. Each lab's step-by-step guide contains the commands and files needed to complete it.
