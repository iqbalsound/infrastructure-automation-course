# 🧪 Lab Manual

Twelve hands-on labs, each in its own folder with a full guide (`README.md`) and the files you create during the lab.

| Lab | Title | Week | CLO | Time | Files |
|---|---|---|---|---|---|
| 1 | [Introduction to Infrastructure as Code (IaC)](lab-01-introduction-to-iac/) | 1 | CLO-1 (Understand) | 90 minutes | 1 |
| 2 | [Writing Basic Automation Scripts](lab-02-basic-automation-scripts/) | 3 | CLO-2 (Apply) | 90 minutes | 3 |
| 3 | [Configuration Management with Ansible](lab-03-ansible-configuration-management/) | 4 | CLO-2 (Apply) | 120 minutes | 6 |
| 4 | [Automating Deployments with Puppet (OpenVox)](lab-04-puppet-openvox/) | 4 | CLO-2 (Apply) | 90 minutes | 1 |
| 5 | [Container Orchestration Basics](lab-05-container-orchestration/) | 5 | CLO-2 (Apply) | 90 minutes | commands only |
| 6 | [Infrastructure Provisioning with Terraform / OpenTofu](lab-06-terraform-opentofu-provisioning/) | 6 | CLO-2 (Apply) | 120 minutes | 5 |
| 7 | [CI/CD Pipeline Automation](lab-07-cicd-pipeline-automation/) | 11 | CLO-2 (Apply) | 150 minutes | 3 |
| 8 | [Automated Monitoring and Logging](lab-08-monitoring-and-logging/) | 10 | CLO-2 (Apply) | 120 minutes | 1 |
| 9 | [Security in Infrastructure Automation](lab-09-security-automation/) | 12 | CLO-3 (Evaluate) | 120 minutes | commands only |
| 10 | [Multi-Cloud Automation Case Study](lab-10-multi-cloud-case-study/) | 13 | CLO-3 (Evaluate) | 150 minutes | 8 |
| 11 | [Disaster Recovery Automation](lab-11-disaster-recovery/) | 13 | CLO-3 (Evaluate) | 150 minutes | 1 |
| 12 | [Capstone Project: Design and Implement an IaC Solution](lab-12-capstone-project/) | 15 | CLO-3 (Evaluate) | Teams of 2-3, multi-session | commands only |

## How to use the labs

- Complete the labs in sequence. Later labs (6, 7, 8, 10, 11, 12) build on the OpenTofu, Docker, and Minikube environments from Labs 1, 3, and 5.
- Commands are written for Linux and macOS. Windows users should run Bash, Docker, and OpenTofu commands inside WSL2 (free) unless noted.
- Replace placeholders such as `Your Name - Roll No` and `<one-of-your-pod-names>` with your own values.
- When a step refers to a previous lab's files or cluster, make sure they still exist or re-create them first.

Each lab follows the same structure: **Objectives, Preamble / Short Theory, Prerequisites, Step-by-Step Guide, Your Tasks / Required Outcomes.**

## Host ports used by the labs

| **Lab** | **Host ports** | **Purpose** |
|---|---|---|
| 3 | 2221, 2222, 8181, 8182 | SSH and HTTP for the two Ansible target containers |
| 6 | 8080 and up | Web containers (one port per container) |
| 7 | 8090, 50000 | Jenkins web interface and agent port |
| 8 | 9090, 9100, 3000 | Prometheus, node-exporter, Grafana |
| 11 | 9000, 9001 | MinIO API and console |
| 12 | 8088, 9091, 8090 | Load balancer, Prometheus, Jenkins |

⬅️ [Back to main README](../README.md)
