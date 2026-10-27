# Week 15: Capstone Lab - Design an Infrastructure as Code Solution

## 🎯 Learning Objectives

- Integrate Terraform/OpenTofu and Ansible into a single combined provisioning-and-configuration solution.
- Design an end-to-end infrastructure automation solution for a defined scenario.
- Apply best practices, security considerations, and CI/CD integration learned throughout the semester.
- Produce a working capstone project artifact for evaluation.

## 🛠️ Hour 3 - Guided Implementation and Consultation

### Task

Dedicated implementation time in the lab environment: students write and test their combined Terraform/OpenTofu provisioning code and Ansible configuration playbooks against their approved design from Hour 2.

Instructor provides one-on-one/team consultation during implementation, focused on troubleshooting integration issues between the provisioning and configuration-management stages (e.g., ensuring Ansible's inventory correctly reflects resources just provisioned by Terraform/OpenTofu).

Students perform an initial end-to-end test of their solution (provision, then configure, then verify the application/service is reachable), and begin drafting the short design-justification write-up required for submission.

Wrap up with a clear statement of remaining work expected before the final project submission (aligned with Week 16's final review/exam), and reminders of the CLO-3 rubric criteria.

### ✅ Solution / Example Code

📄 **File:** `main.tf`

```hcl
# Illustrative combined-solution skeleton
# Step 1: Terraform/OpenTofu provisions containers (Week 6 pattern)
resource "docker_container" "app_vm" {
  name  = "capstone-app"
  image = docker_image.base.image_id
}

output "app_container_name" {
  value = docker_container.app_vm.name
}
```

> 💾 Saved in this folder: [`main.tf`](main.tf)

📄 **File:** `inventory.ini`

```ini
# Step 2: Generated/updated Ansible inventory reflects provisioned resource
# inventory.ini
[app]
capstone-app ansible_connection=docker
```

> 💾 Saved in this folder: [`inventory.ini`](inventory.ini)

📄 **File:** `playbook.yml`

```yaml
# Step 3: Ansible playbook configures the provisioned container (Week 4 pattern)
- hosts: app
  tasks:
    - name: Install application dependencies
      apt:
        name: nginx
        state: present
```

> 💾 Saved in this folder: [`playbook.yml`](playbook.yml)

### 🧰 Recommended Open-Source / Free Tools

- OpenTofu/Terraform (open source)
- Ansible (open source)
- Docker or Vagrant/VirtualBox
- Git/GitHub

## 📁 Files in this folder

- [`main.tf`](main.tf)
- [`inventory.ini`](inventory.ini)
- [`playbook.yml`](playbook.yml)

---
⬅️ [Back to Lecture Notes index](../README.md)
