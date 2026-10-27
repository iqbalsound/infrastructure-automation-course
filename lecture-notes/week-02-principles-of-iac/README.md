# Week 2: Principles of Infrastructure as Code (IaC)

## 🎯 Learning Objectives

- Define Infrastructure as Code and differentiate declarative and imperative approaches.
- Explain idempotency, version control, and repeatability as core IaC principles.
- Describe the IaC lifecycle: write, plan, apply, and destroy.
- Identify the benefits of IaC for disaster recovery and environment consistency.

## 🛠️ Hour 3 - Lab: First Steps with Terraform/OpenTofu

### Task

Install OpenTofu (the open-source, community-governed fork of Terraform) or Terraform Community Edition on the student lab machines.

Initialize a first project directory and write a minimal configuration using the local provider (creating local files/directories) so that no cloud account or cost is required.

Walk through 'init', 'plan', and 'apply', observing the plan output and confirming that a second 'apply' with no changes reports no differences - demonstrating idempotency directly.

Modify the configuration and re-run 'plan' to observe how the tool calculates only the incremental change (drift correction), then run 'destroy' to clean up.

### ✅ Solution / Example Code

📄 **File:** `main.tf`

```hcl
# main.tf - minimal declarative example (local provider, no cloud cost)
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

resource "local_file" "course_note" {
  content  = "Week 2 - Infrastructure as Code Lab"
  filename = "${path.module}/week2_output.txt"
}

# Commands
# tofu init
# tofu plan
# tofu apply
# tofu destroy
```

> 💾 Saved in this folder: [`main.tf`](main.tf)

### 🧰 Recommended Open-Source / Free Tools

- OpenTofu / Terraform (open source)
- Git
- VS Code with HCL/Terraform extension (free)

## 📁 Files in this folder

- [`main.tf`](main.tf)

---
⬅️ [Back to Lecture Notes index](../README.md)
