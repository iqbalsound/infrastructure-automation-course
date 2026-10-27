# Lab 4: Automating Deployments with Puppet (OpenVox)

|  |  |
|---|---|
| **Week** | 4 |
| **Mapped CLO** | CLO-2 (Apply) |
| **Tools / Environment** | OpenVox/Puppet open-source agent; Docker (disposable host) |
| **Estimated Time** | 90 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Explain Puppet's declarative, manifest-based approach and contrast it with Ansible's agentless model.
- Write a Puppet manifest that declares desired package, file, and service state.
- Apply a manifest locally and verify convergence and drift correction.

## 2. Preamble / Short Theory

Puppet pioneered the declarative-manifest model: you describe resources and their relationships, and the agent converges the node to that state. Since 2025 the open-source distribution of Puppet is maintained by the community as **OpenVox**; the `puppet` command and the manifest language are unchanged, so everything in this lab applies to both.

In production, agents pull a catalog from a server on a schedule and continuously enforce it. In this lab you use `puppet apply`, which compiles and applies a local manifest, to concentrate on the resource model.

## 3. Prerequisites

- Lab 3 completed.
- Docker installed.

## 4. Step-by-Step Guide

### Step 1: Start a clean Ubuntu container

```bash
docker run -it --name puppet-lab --hostname puppet-lab ubuntu:24.04 bash
```

### Step 2: Install the open-source agent

Inside the container, install the agent from the community repository. If the package URL has changed, follow the current instructions at voxpupuli.org/openvox/install.

```bash
apt-get update && apt-get install -y wget ca-certificates
wget https://apt.voxpupuli.org/openvox8-release-ubuntu24.04.deb
dpkg -i openvox8-release-ubuntu24.04.deb
apt-get update && apt-get install -y openvox-agent
export PATH=/opt/puppetlabs/bin:$PATH
puppet --version
```

### Step 3: Write a basic manifest

Create `site.pp` declaring a package, a file, and a service (write it with `cat > site.pp` and paste, or install `nano` first).

📄 **File:** `site.pp`

```puppet
package { 'nginx':
  ensure => installed,
}

file { '/var/www/html/index.html':
  ensure  => file,
  content => "Managed by Puppet\n",
  require => Package['nginx'],
}

service { 'nginx':
  ensure   => running,
  provider => 'init',   # no systemd inside a container
  require  => Package['nginx'],
}
```

> 💾 Saved in this folder: [`site.pp`](site.pp)

### Step 4: Preview, then apply

First run a dry run, which reports what would change without changing anything, then apply.

```bash
puppet apply --noop site.pp
puppet apply site.pp
```

### Step 5: Re-apply and observe convergence

Run `puppet apply site.pp` again and note that no resource changes are reported because the node has already converged.

```bash
puppet apply site.pp
```

### Step 6: Correct drift

Change the managed file by hand and apply again. Puppet restores the declared content.

```bash
echo 'tampered' > /var/www/html/index.html
puppet apply site.pp
cat /var/www/html/index.html
```

### Step 7: Compare with Lab 3

Write a short comparison of Puppet's resource model versus Ansible's playbook model, covering agent requirements, language, ordering (explicit `require` versus top-to-bottom tasks), and learning curve.

## 5. Your Tasks / Required Outcomes

- `site.pp`.
- A dated terminal screenshot of two `puppet apply` runs showing convergence (no changes on the second run) and the drift-correction run.
- A short written comparison (maximum half a page) of Puppet versus Ansible.

## 📁 Files in this folder

- [`site.pp`](site.pp)

---
⬅️ [Back to Lab Manual index](../README.md)
