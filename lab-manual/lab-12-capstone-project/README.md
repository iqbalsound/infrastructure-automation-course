# Lab 12: Capstone Project: Design and Implement an IaC Solution

|  |  |
|---|---|
| **Week** | 15 |
| **Mapped CLO** | CLO-3 (Evaluate) |
| **Tools / Environment** | OpenTofu; Ansible; Jenkins; any tools from Labs 1-11 |
| **Estimated Time** | Teams of 2-3, multi-session |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Design a complete, end-to-end Infrastructure as Code solution that integrates provisioning, configuration, CI/CD, monitoring, and security scanning.
- Implement it using only the free, open-source tooling from this manual.
- Evaluate and defend the design's scalability, reliability, and security in a live demonstration.

## 2. Preamble / Short Theory

The capstone combines every tool from the manual into one small but complete automated solution that runs on a single laptop. It mirrors real practice: a generated inventory connects provisioning to configuration, a pipeline runs the whole chain on each commit, and monitoring and scanning provide evidence that the result works and is reasonably safe.

## 3. Prerequisites

- All previous labs completed and their tools available.
- A Git repository for the project.
- Teams of 2-3 students, as agreed with the instructor.

## 4. Step-by-Step Guide

### Step 1: Define the scenario

In your team, choose a small but complete scenario, for example: "provision and configure a three-tier web application (load balancer, application containers, monitoring) that is reproducible from a single command." Get it approved before building.

### Step 2: Design the architecture

Produce a one-page architecture diagram showing every component, which tool provisions or configures it, and the data and control flow between them (OpenTofu to Ansible to Jenkins to Prometheus/Grafana to the security scan).

### Step 3: Implement provisioning

Write the OpenTofu configuration, reusing the module patterns of Labs 6 and 10. Validate inputs, pin provider versions, and expose outputs.

### Step 4: Implement configuration management

Write Ansible playbooks (or Puppet manifests) that configure the provisioned resources. Generate the inventory from OpenTofu rather than writing it by hand.

### Step 5: Wire in CI/CD

Create a Jenkinsfile (Lab 7) that runs init, lint, security scan, plan, approval, apply, and configure on each commit. Your Jenkins image will need Ansible and the Docker CLI in addition to OpenTofu.

### Step 6: Add monitoring and security evaluation

Instrument the solution with Prometheus (and Grafana if time allows), and scan the code with a static analyzer such as Checkov and, where applicable, the running targets with Lynis (Lab 9).

### Step 7: Run an end-to-end test

Trigger the full pipeline from a fresh commit and confirm that the infrastructure is provisioned, configured, monitored, and passes your baseline scan. Run the pipeline a second time and confirm it changes nothing.

### Step 8: Prepare the demonstration

Prepare a 10-15 minute live demonstration: trigger the pipeline live, show the running infrastructure, and walk through the monitoring and scan results while defending your design decisions.

### Assessment Criteria (CLO-3)

| **Criterion** | **What the instructor looks for** |
|---|---|
| Correctness and function | The pipeline provisions, configures, and verifies the infrastructure end to end, and a second run changes nothing. |
| Design quality | Reusable modules, validated inputs, clear provisioning-versus-configuration boundary, generated (not hand-written) inventory. |
| Best practice and security | At least one Week 14 practice (linting, version pinning, documentation) and no hard-coded secrets (Week 12), supported by a scan. |
| Evaluation and justification | A written, evidence-based discussion of scalability, reliability, and security, and of the trade-offs you chose. |
| Live demonstration | Every member can explain and modify any part of the solution on request. |

## 5. Your Tasks / Required Outcomes

- The project repository link, the architecture diagram, and a project report (maximum 6 pages) covering design decisions, trade-offs, and an evaluation of scalability, reliability, and security.
- A live, in-person demonstration of the working pipeline; no pre-recorded video will be accepted.
- Each team member must be able to explain and modify any part of the solution live if asked.

---
⬅️ [Back to Lab Manual index](../README.md)
