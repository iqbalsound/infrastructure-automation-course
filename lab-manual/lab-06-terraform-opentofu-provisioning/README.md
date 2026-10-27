# Lab 6: Infrastructure Provisioning with Terraform / OpenTofu

|  |  |
|---|---|
| **Week** | 6 |
| **Mapped CLO** | CLO-2 (Apply) |
| **Tools / Environment** | OpenTofu (or Terraform); Docker provider; Git |
| **Estimated Time** | 120 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Write a configuration that provisions multiple related resources.
- Use variables, outputs, and implicit dependencies.
- Apply, modify, and destroy infrastructure with the standard workflow, and read an incremental plan.

## 2. Preamble / Short Theory

This lab returns to the tool from Lab 1 and goes deeper into real provisioning. To keep it free and reproducible, the open-source Docker provider provisions a network, an image, and containers: the same workflow used to provision AWS, Azure, or GCP resources when credentials are available. Because the containers reference the network and the image, OpenTofu builds a dependency graph and orders creation and destruction automatically.

## 3. Prerequisites

- Labs 1 and 5 completed.
- Docker installed and running.

## 4. Step-by-Step Guide

### Step 1: Set up the project

```bash
mkdir lab06-terraform-provisioning && cd lab06-terraform-provisioning
git init -b main
printf '.terraform/\n*.tfstate\n*.tfstate.*\ntfplan\n' > .gitignore
```

### Step 2: Declare the provider (versions.tf)

📄 **File:** `versions.tf`

```hcl
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}
```

> 💾 Saved in this folder: [`versions.tf`](versions.tf)

### Step 3: Add variables (variables.tf)

📄 **File:** `variables.tf`

```hcl
variable "container_count" {
  description = "Number of web containers to provision"
  type        = number
  default     = 2
}

variable "external_base_port" {
  description = "Host port of the first container; each next one adds 1"
  type        = number
  default     = 8080
}
```

> 💾 Saved in this folder: [`variables.tf`](variables.tf)

### Step 4: Provision a network, an image, and containers (main.tf)

📄 **File:** `main.tf`

```hcl
resource "docker_network" "lab" {
  name = "lab06-net"
}

resource "docker_image" "nginx" {
  name         = "nginx:stable"
  keep_locally = true
}

resource "docker_container" "web" {
  count = var.container_count
  name  = "web-${count.index}"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.lab.name
  }

  ports {
    internal = 80
    external = var.external_base_port + count.index
  }
}
```

> 💾 Saved in this folder: [`main.tf`](main.tf)

### Step 5: Add outputs (outputs.tf) and a variable file

📄 **File:** `outputs.tf`

```hcl
output "container_names" {
  value = docker_container.web[*].name
}

output "urls" {
  value = [for i in range(var.container_count) : "http://localhost:${var.external_base_port + i}"]
}
```

> 💾 Saved in this folder: [`outputs.tf`](outputs.tf)

Create `terraform.tfvars` containing:

📄 **File:** `terraform.tfvars`

```hcl
container_count = 2
```

> 💾 Saved in this folder: [`terraform.tfvars`](terraform.tfvars)

### Step 6: Format, validate, and run the workflow

```bash
tofu fmt
tofu validate
tofu init
tofu plan -out=tfplan
tofu apply tfplan
curl http://localhost:8080
```

### Step 7: Modify and re-apply

Change `container_count` to 4 in `terraform.tfvars`, then run `tofu plan -out=tfplan` and `tofu apply tfplan`. Observe that only two new containers are added and the existing ones are untouched.

```bash
tofu plan -out=tfplan
tofu apply tfplan
tofu output
```

### Step 8: Commit your work

```bash
git add .
git commit -m "Lab 6: Docker provisioning with OpenTofu"
```

### Step 9: Destroy

```bash
tofu destroy
```

## 5. Your Tasks / Required Outcomes

- `versions.tf`, `variables.tf`, `main.tf`, `outputs.tf`, and `terraform.tfvars`.
- A dated terminal screenshot of `tofu apply` and of the `tofu plan` output after the `container_count` change, showing only 2 additions.
- Two sentences explaining how OpenTofu knew to create the network before the containers.

## 📁 Files in this folder

- [`main.tf`](main.tf)
- [`outputs.tf`](outputs.tf)
- [`terraform.tfvars`](terraform.tfvars)
- [`variables.tf`](variables.tf)
- [`versions.tf`](versions.tf)

---
⬅️ [Back to Lab Manual index](../README.md)
