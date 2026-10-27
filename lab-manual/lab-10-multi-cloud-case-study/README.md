# Lab 10: Multi-Cloud Automation Case Study

|  |  |
|---|---|
| **Week** | 13 |
| **Mapped CLO** | CLO-3 (Evaluate) |
| **Tools / Environment** | OpenTofu; Ansible; Docker provider |
| **Estimated Time** | 150 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Design a provisioning-plus-configuration workflow that could target more than one environment or provider.
- Structure an OpenTofu project with a reusable module and two environments.
- Connect provisioning to configuration by generating an Ansible inventory from OpenTofu outputs.
- Evaluate trade-offs between modular, provider-agnostic design and duplicated per-environment code.

## 2. Preamble / Short Theory

Enterprises rarely commit to one cloud. This lab does not require paid accounts: it uses the Docker provider to simulate two environments (staging and production) from one reusable module, so the design and evaluation skills transfer directly to real AWS, Azure, or GCP setups.

Provisioning (OpenTofu) and configuration (Ansible) stay separate. OpenTofu writes the inventory file, so Ansible always sees the resources that actually exist.

## 3. Prerequisites

- Labs 3 and 6 completed.
- Ansible installed in your virtual environment (the `ansible` package includes the Docker connection plugin), and the Docker CLI available.

## 4. Step-by-Step Guide

### Step 1: Design the module structure

Sketch (on paper or in a diagram tool) the layout below: one module, two environment folders that call it with different variables, and a shared inventory template.

```bash
lab10-multienv/
  modules/web/{versions.tf,variables.tf,main.tf,outputs.tf}
  staging/main.tf
  production/main.tf
  templates/inventory.tftpl
  site.yml
```

### Step 2: Create the reusable module

Create the four files in `modules/web/`.

📄 **File:** `modules/web/versions.tf`

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}
```

> 💾 Saved in this folder: [`modules/web/versions.tf`](modules/web/versions.tf)

📄 **File:** `modules/web/variables.tf`

```hcl
variable "container_count" {
  type = number
}

variable "environment" {
  type = string
}

variable "image" {
  type    = string
  default = "ubuntu:24.04"
}
```

> 💾 Saved in this folder: [`modules/web/variables.tf`](modules/web/variables.tf)

📄 **File:** `modules/web/main.tf`

```hcl
resource "docker_image" "base" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "web" {
  count    = var.container_count
  name     = "${var.environment}-web-${count.index}"
  image    = docker_image.base.image_id
  command  = ["sleep", "infinity"]
  must_run = true
}
```

> 💾 Saved in this folder: [`modules/web/main.tf`](modules/web/main.tf)

📄 **File:** `modules/web/outputs.tf`

```hcl
output "container_names" {
  value = docker_container.web[*].name
}
```

> 💾 Saved in this folder: [`modules/web/outputs.tf`](modules/web/outputs.tf)

### Step 3: Create the inventory template

Create `templates/inventory.tftpl`.

📄 **File:** `templates/inventory.tftpl`

```ini
[web]
%{ for h in hosts ~}
${h} ansible_connection=community.docker.docker ansible_python_interpreter=/usr/bin/python3
%{ endfor ~}
```

> 💾 Saved in this folder: [`templates/inventory.tftpl`](templates/inventory.tftpl)

### Step 4: Call the module from two environments

Create `staging/main.tf` (module call with `container_count = 1` and `environment = "staging"`) and `production/main.tf` (`container_count = 3`, `environment = "production"`). Each environment also declares the providers and writes its own inventory, as in the staging example below; change the two values for production.

📄 **File:** `staging/main.tf`

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "docker" {}

module "web" {
  source          = "../modules/web"
  container_count = 1
  environment     = "staging"
}

resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"
  content  = templatefile("${path.module}/../templates/inventory.tftpl", {
    hosts = module.web.container_names
  })
}

output "container_names" {
  value = module.web.container_names
}
```

> 💾 Saved in this folder: [`staging/main.tf`](staging/main.tf)

### Step 5: Apply both environments independently

```bash
cd staging && tofu init && tofu apply && cd ..
cd production && tofu init && tofu apply && cd ..
```

### Step 6: Add a post-provisioning Ansible step

Write `site.yml` that configures the containers identically in both environments, and run it against each generated inventory.

📄 **File:** `site.yml`

```yaml
---
- name: Bootstrap Python on bare containers
  hosts: web
  gather_facts: false
  tasks:
    - name: Install python3 if it is missing
      ansible.builtin.raw: test -x /usr/bin/python3 || (apt-get update && apt-get install -y python3)
      register: bootstrap
      changed_when: "'Setting up' in bootstrap.stdout"

- name: Configure web servers identically in every environment
  hosts: web
  tasks:
    - name: Install nginx
      ansible.builtin.apt:
        name: nginx
        state: present
        update_cache: true
        cache_valid_time: 3600

    - name: Publish a page that names the host
      ansible.builtin.copy:
        content: "Hello from {{ inventory_hostname }}\n"
        dest: /var/www/html/index.html
        mode: "0644"

    - name: Ensure nginx is running
      ansible.builtin.service:
        name: nginx
        state: started
        use: service
```

> 💾 Saved in this folder: [`site.yml`](site.yml)

```bash
ansible-playbook -i staging/inventory.ini site.yml
ansible-playbook -i production/inventory.ini site.yml
```

### Step 7: Evaluate the design

Write a short evaluation (maximum one page) comparing this modular approach against writing separate, duplicated configurations per environment or provider. Discuss maintainability, drift risk, and the effort of onboarding a third environment.

## 5. Your Tasks / Required Outcomes

- The full module plus two-environment project structure and the Ansible playbook.
- A dated screenshot showing both environments applied with the correct differing container counts (1 and 3).
- The written evaluation (maximum one page).

> ℹ️ **Note:** `production/main.tf` is generated exactly as the manual instructs: it is `staging/main.tf` with `container_count = 3` and `environment = "production"`.

## 📁 Files in this folder

- [`modules/web/main.tf`](modules/web/main.tf)
- [`modules/web/outputs.tf`](modules/web/outputs.tf)
- [`modules/web/variables.tf`](modules/web/variables.tf)
- [`modules/web/versions.tf`](modules/web/versions.tf)
- [`production/main.tf`](production/main.tf)
- [`site.yml`](site.yml)
- [`staging/main.tf`](staging/main.tf)
- [`templates/inventory.tftpl`](templates/inventory.tftpl)

---
⬅️ [Back to Lab Manual index](../README.md)
