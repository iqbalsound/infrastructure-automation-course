# Lab 3: Configuration Management with Ansible

|  |  |
|---|---|
| **Week** | 4 |
| **Mapped CLO** | CLO-2 (Apply) |
| **Tools / Environment** | Ansible (open source); Docker (disposable target hosts); OpenSSH |
| **Estimated Time** | 120 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Explain agentless configuration management and how Ansible differs from scripting alone.
- Write and run an Ansible playbook against more than one target host.
- Use Ansible modules for package installation, service control, and templated files.
- Demonstrate idempotency from the play recap.

## 2. Preamble / Short Theory

Ansible (open source, GPL-3.0) is an agentless configuration-management tool: the control node connects over SSH and runs small Python modules on each target, so nothing needs to be pre-installed except SSH and Python. Playbooks describe the desired state declaratively in YAML, and modules check the current state before acting.

Docker containers serve as free, disposable target hosts. Authentication uses an SSH key pair instead of a password, which avoids hard-coded credentials (a Week 12 principle) and the need for `sshpass`.

## 3. Prerequisites

- Lab 2 completed.
- Docker installed (Docker Engine or Docker Desktop).
- Python 3 with the `venv` module.

## 4. Step-by-Step Guide

### Step 1: Install Ansible in a virtual environment

```bash
mkdir lab03-ansible && cd lab03-ansible
python3 -m venv ~/.venvs/ansible
source ~/.venvs/ansible/bin/activate
pip install ansible
ansible --version
```

### Step 2: Create an SSH key pair for the lab

```bash
ssh-keygen -t ed25519 -f id_ed25519_lab -N ""
printf 'id_ed25519_lab\n' > .gitignore
```

### Step 3: Build the target image

Create a file named `Dockerfile` with the content below. The image contains an SSH server, Python 3, and a sudo-enabled user named `ansible` that accepts only your key.

📄 **File:** `Dockerfile`

```dockerfile
FROM ubuntu:24.04

RUN apt-get update \
 && apt-get install -y --no-install-recommends openssh-server python3 sudo ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /run/sshd \
 && useradd -m -s /bin/bash ansible \
 && echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible \
 && mkdir -p /home/ansible/.ssh && chmod 700 /home/ansible/.ssh

COPY id_ed25519_lab.pub /home/ansible/.ssh/authorized_keys
RUN chown -R ansible:ansible /home/ansible/.ssh \
 && chmod 600 /home/ansible/.ssh/authorized_keys

EXPOSE 22 80
CMD ["/usr/sbin/sshd", "-D"]
```

> 💾 Saved in this folder: [`Dockerfile`](Dockerfile)

```bash
docker build -t ansible-target:1.0 .
```

### Step 4: Start two target containers

Each container publishes SSH on its own host port and HTTP on its own host port.

```bash
docker run -d --name node1 -p 2221:22 -p 8181:80 ansible-target:1.0
docker run -d --name node2 -p 2222:22 -p 8182:80 ansible-target:1.0
```

### Step 5: Create the inventory and configuration

Create `inventory.ini` and `ansible.cfg`.

📄 **File:** `inventory.ini`

```ini
[webservers]
node1 ansible_host=127.0.0.1 ansible_port=2221
node2 ansible_host=127.0.0.1 ansible_port=2222

[webservers:vars]
ansible_user=ansible
ansible_ssh_private_key_file=./id_ed25519_lab
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
```

> 💾 Saved in this folder: [`inventory.ini`](inventory.ini)

📄 **File:** `ansible.cfg`

```ini
[defaults]
inventory = inventory.ini
host_key_checking = False
retry_files_enabled = False
```

> 💾 Saved in this folder: [`ansible.cfg`](ansible.cfg)

### Step 6: Test connectivity

```bash
ansible webservers -m ping
```

Both nodes must answer with `"ping": "pong"`. If not, see the troubleshooting hints at the end of this lab.

### Step 7: Write the playbook

Create `site.yml` that installs nginx and ensures it is running on both hosts.

📄 **File:** `site.yml`

```yaml
---
- name: Configure web servers
  hosts: webservers
  become: true
  vars:
    student_id: "Your Name - Roll No"
  tasks:
    - name: Install nginx
      ansible.builtin.apt:
        name: nginx
        state: present
        update_cache: true
        cache_valid_time: 3600

    - name: Ensure nginx is running
      ansible.builtin.service:
        name: nginx
        state: started
        use: service   # containers have no systemd, so use the init-script backend
```

> 💾 Saved in this folder: [`site.yml`](site.yml)

### Step 8: Run the playbook and verify idempotency

Run the playbook twice and compare the `PLAY RECAP` lines. Explain why the second run reports `changed=0` and why that matters for configuration management.

```bash
ansible-playbook site.yml
ansible-playbook site.yml
```

### Step 9: Extend the playbook with a template

Create `templates/index.html.j2` and append the extra task to `site.yml` (at the same indentation as the other tasks). Re-run the playbook, then check both pages in the browser or with `curl`.

📄 **File:** `templates/index.html.j2`

```html
<!DOCTYPE html>
<html>
  <head><title>{{ inventory_hostname }}</title></head>
  <body>
    <h1>Configured by Ansible</h1>
    <p>Host: {{ inventory_hostname }} | Owner: {{ student_id }}</p>
  </body>
</html>
```

> 💾 Saved in this folder: [`templates/index.html.j2`](templates/index.html.j2)

📄 **File:** `site-with-template.yml (baseline site.yml + this task)`

```yaml
    - name: Deploy a custom index page
      ansible.builtin.template:
        src: templates/index.html.j2
        dest: /var/www/html/index.html
        mode: "0644"
```

> 💾 Saved in this folder: [`site-with-template.yml`](site-with-template.yml)

```bash
curl http://127.0.0.1:8181
curl http://127.0.0.1:8182
```

### Step 10: Clean up

```bash
docker rm -f node1 node2
```

### Troubleshooting Hints

- `UNREACHABLE ... Permission denied (publickey)`: confirm that you built the image after generating the key, and that `ansible_ssh_private_key_file` points to the private key (not the `.pub` file).
- `Connection refused`: run `docker ps` to check the containers are up and the ports match the inventory.
- Windows: run all commands inside WSL2, and keep the lab folder inside the Linux file system so that key-file permissions work.

## 5. Your Tasks / Required Outcomes

- `Dockerfile`, `inventory.ini`, `ansible.cfg`, `site.yml`, and `templates/index.html.j2`.
- A dated terminal screenshot of two playbook runs showing the second run with `changed=0`.
- A screenshot of `curl` output from both nodes after the template task.

## 📁 Files in this folder

- [`Dockerfile`](Dockerfile)
- [`ansible.cfg`](ansible.cfg)
- [`inventory.ini`](inventory.ini)
- [`site-with-template.yml`](site-with-template.yml)
- [`site.yml`](site.yml)
- [`templates/index.html.j2`](templates/index.html.j2)

---
⬅️ [Back to Lab Manual index](../README.md)
