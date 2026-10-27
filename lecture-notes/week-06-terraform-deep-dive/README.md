# Week 6: Terraform Deep Dive - Provisioning Cloud Resources

## 🎯 Learning Objectives

- Explain Terraform/OpenTofu core concepts: providers, resources, variables, and state.
- Use modules and workspaces to organize infrastructure code.
- Configure remote state using an open-source backend.
- Provision, modify, and destroy infrastructure using an open-source or simulated provider.

## 🛠️ Hour 3 - Lab: Provisioning and Destroying Resources

### Task

Using LocalStack (open-source edition) to simulate cloud resources without cost or an account, or the Docker provider for Terraform/OpenTofu, students write a configuration provisioning multiple related resources (e.g., a storage bucket and a queue, or multiple Docker containers with a defined network).

Parameterize the configuration using input variables (e.g., resource count, naming prefix) and confirm via 'plan' that changing a variable produces the expected incremental change.

Refactor part of the configuration into a simple local module and re-apply, demonstrating no functional change but improved organization.

Run 'terraform destroy' and confirm complete removal of all provisioned resources, reinforcing responsible resource lifecycle management.

### ✅ Solution / Example Code

📄 **File:** `variables.tf`

```hcl
# variables.tf
variable "container_count" {
  type    = number
  default = 2
}
```

> 💾 Saved in this folder: [`variables.tf`](variables.tf)

📄 **File:** `versions.tf`

```hcl
# versions.tf
terraform {
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

📄 **File:** `main.tf`

```hcl
# main.tf (Docker provider - free/open source, no cloud cost)
resource "docker_image" "nginx" {
  name = "nginx:1.25"
}

resource "docker_container" "web" {
  count = var.container_count
  name  = "web-${count.index}"
  image = docker_image.nginx.image_id
}

# Commands
# tofu init
# tofu plan -var="container_count=3"
# tofu apply -var="container_count=3"
# tofu destroy
```

> 💾 Saved in this folder: [`main.tf`](main.tf)

### 🧰 Recommended Open-Source / Free Tools

- OpenTofu/Terraform (open source)
- Docker provider (free)
- LocalStack Community Edition (open source)
- MinIO (open source, optional)

## 📁 Files in this folder

- [`variables.tf`](variables.tf)
- [`versions.tf`](versions.tf)
- [`main.tf`](main.tf)

---
⬅️ [Back to Lecture Notes index](../README.md)
