# Week 4: Configuration Management Tools Overview (Ansible, Puppet, Chef)

## 🎯 Learning Objectives

- Define configuration management and distinguish agent-based from agentless architectures.
- Describe the architecture of Ansible: inventory, playbooks, modules, and roles.
- Compare Ansible with Puppet and Chef at a conceptual level.
- Configure a server using an Ansible playbook.

## 🛠️ Hour 3 - Lab: Configuring a Server with Ansible

### Task

Set up a local test environment using Vagrant with VirtualBox (both free/open source) to create one or two lightweight virtual machines that will act as 'managed nodes' for Ansible.

Write an inventory file listing the Vagrant VM(s) and confirm connectivity using 'ansible all -m ping'.

Write a simple playbook that installs a package (e.g., nginx or a lightweight web server), starts and enables the service, and copies a custom configuration/index file to the node.

Re-run the playbook a second time and observe Ansible reporting the relevant tasks as 'ok' rather than 'changed', reinforcing the idempotency concept from Weeks 2 and 3 in a configuration-management context.

### ✅ Solution / Example Code

📄 **File:** `inventory.ini`

```ini
# inventory.ini
[webservers]
192.168.56.10 ansible_user=vagrant
```

> 💾 Saved in this folder: [`inventory.ini`](inventory.ini)

📄 **File:** `playbook.yml`

```yaml
# playbook.yml
---
- hosts: webservers
  become: yes
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
        update_cache: yes
    - name: Ensure nginx is running
      service:
        name: nginx
        state: started
        enabled: yes

# Run: ansible-playbook -i inventory.ini playbook.yml
```

> 💾 Saved in this folder: [`playbook.yml`](playbook.yml)

### 🧰 Recommended Open-Source / Free Tools

- Ansible (open source)
- Vagrant (free)
- VirtualBox (open source)
- Git

## 📁 Files in this folder

- [`inventory.ini`](inventory.ini)
- [`playbook.yml`](playbook.yml)

---
⬅️ [Back to Lecture Notes index](../README.md)
