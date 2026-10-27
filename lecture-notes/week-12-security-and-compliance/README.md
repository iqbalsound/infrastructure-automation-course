# Week 12: Security and Compliance in Automation

## 🎯 Learning Objectives

- Explain core security principles relevant to automated infrastructure: secrets management, least privilege, and policy as code.
- Identify open-source tools for compliance scanning and static analysis of infrastructure code.
- Evaluate a system's or codebase's security/compliance posture using automated scanning tools.
- Design mitigation for identified security or compliance findings.

## 🛠️ Hour 3 - Lab: Auditing and Scanning

### Task

Run Lynis against the Vagrant VM configured in Week 4's Ansible lab, review the generated hardening index and findings, and identify the top three recommended remediations.

Run Checkov or tfsec against the Terraform/OpenTofu configuration written in Week 6, review the findings report, and correct at least two flagged issues (e.g., adding an explicit security-relevant argument that was previously left at an insecure default).

Add the static-analysis scan as an additional step in the Week 11 GitHub Actions workflow, so that future pushes are automatically checked for security misconfigurations.

Discuss, as a group, which findings from the scans represent genuine risk versus acceptable trade-offs for a lab/teaching environment, reinforcing the evaluative (CLO-3) skill of contextualised risk assessment.

### ✅ Solution / Example Code

📄 **File:** `security-scans.sh`

```bash
# Lynis system audit (open source)
sudo lynis audit system

# Checkov scan against Terraform/OpenTofu code (open source)
pip install checkov
checkov -d ./week6-lab
```

> 💾 Saved in this folder: [`security-scans.sh`](security-scans.sh)

📄 **File:** `checkov-workflow-step.yml`

```yaml
# Add to GitHub Actions workflow (.github/workflows/iac-validate.yml)
      - name: Security Scan with Checkov
        run: pipx run checkov -d .
```

> 💾 Saved in this folder: [`checkov-workflow-step.yml`](checkov-workflow-step.yml)

### 🧰 Recommended Open-Source / Free Tools

- Lynis (open source)
- OpenSCAP (open source)
- Checkov (open source)
- tfsec (open source)

## 📁 Files in this folder

- [`security-scans.sh`](security-scans.sh)
- [`checkov-workflow-step.yml`](checkov-workflow-step.yml)

---
⬅️ [Back to Lecture Notes index](../README.md)
