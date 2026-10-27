# Lab 1: Introduction to Infrastructure as Code (IaC)

|  |  |
|---|---|
| **Week** | 1 |
| **Mapped CLO** | CLO-1 (Understand) |
| **Tools / Environment** | OpenTofu (open source) or Terraform; Git; OS terminal |
| **Estimated Time** | 90 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Explain the principles of Infrastructure as Code and how it differs from manual provisioning.
- Install and configure OpenTofu and Git.
- Initialize a version-controlled project, apply a first minimal configuration, and demonstrate idempotency and drift detection.

## 2. Preamble / Short Theory

Infrastructure as Code (IaC) treats server, network, and platform configuration as versioned source files rather than manual console clicks, making infrastructure repeatable, auditable, and reviewable like application code. This course uses OpenTofu, the MPL-2.0 open-source Terraform-compatible tool, paired with Git for version control. The commands are identical to Terraform's; if you already have Terraform installed, replace `tofu` with `terraform`.

This first lab establishes the workflow that every later lab builds on: write, initialize, plan, apply, and destroy. You will also see the two properties that make IaC safe: a second apply with no changes does nothing (idempotency), and a manual edit to a managed resource is detected as drift.

## 3. Prerequisites

- A laptop or desktop running Windows, macOS, or Linux with permission to install software (Windows users: use WSL2).
- No prior automation experience is assumed.
- A stable internet connection for the initial downloads.

## 4. Step-by-Step Guide

### Step 1: Install OpenTofu

Follow the instructions at opentofu.org/docs/intro/install, or use a package manager:

```bash
# macOS
brew install opentofu

# Ubuntu / WSL2
sudo snap install --classic opentofu

# Windows (PowerShell)
choco install opentofu
```

### Step 2: Install Git and set your identity

Install Git from git-scm.com or your package manager, then tell Git who you are (commits fail without this).

```bash
sudo apt install -y git        # or: brew install git / winget install Git.Git
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
```

### Step 3: Verify both installations

```bash
tofu version
git --version
```

### Step 4: Initialize a Git repository

```bash
mkdir lab01-iac-intro && cd lab01-iac-intro
git init -b main
printf '.terraform/\n*.tfstate\n*.tfstate.*\n' > .gitignore
```

### Step 5: Write a minimal configuration

Create `main.tf`. It uses the local provider, so no cloud account is needed. Replace the default value of `student_name` with your own name and roll number.

📄 **File:** `main.tf`

```hcl
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

variable "student_name" {
  description = "Your full name and roll number"
  type        = string
  default     = "Your Name (Roll No)"
}

resource "local_file" "hello" {
  filename = "${path.module}/hello.txt"
  content  = "Provisioned by OpenTofu for ${var.student_name}\n"
}
```

> 💾 Saved in this folder: [`main.tf`](main.tf)

### Step 6: Initialize, plan, and apply

```bash
tofu init
tofu plan
tofu apply
cat hello.txt
```

Read the plan before typing `yes`. Note the symbols `+` (create), `~` (change), and `-` (destroy).

### Step 7: Prove idempotency

Run `tofu apply` a second time without changing anything and record the exact message that OpenTofu prints.

### Step 8: Detect and correct drift

Edit `hello.txt` by hand, then run `tofu plan`. Observe how OpenTofu detects that reality no longer matches the code, and run `tofu apply` to restore it.

```bash
echo 'tampered' > hello.txt
tofu plan
tofu apply
```

### Step 9: Inspect the state file

List and inspect what OpenTofu tracks, then open `terraform.tfstate` (OpenTofu keeps this historic file name). Explain in your own words why the state file must not be edited by hand.

```bash
tofu state list
tofu state show local_file.hello
```

### Step 10: Commit the configuration

```bash
git add main.tf .gitignore .terraform.lock.hcl
git commit -m "Lab 1: first OpenTofu configuration"
git log --oneline
```

### Step 11: Destroy the resource

```bash
tofu destroy
```

## 5. Your Tasks / Required Outcomes

- `main.tf` and a screenshot of `git log --oneline` showing your commit.
- A dated terminal screenshot showing a full init, plan, apply, drift-fix, and destroy cycle.
- The exact text printed by the second `apply` (Step 7) and your one-paragraph explanation of what the state file is for.

## 📁 Files in this folder

- [`main.tf`](main.tf)

---
⬅️ [Back to Lab Manual index](../README.md)
