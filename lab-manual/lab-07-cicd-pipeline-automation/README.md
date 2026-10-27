# Lab 7: CI/CD Pipeline Automation

|  |  |
|---|---|
| **Week** | 11 |
| **Mapped CLO** | CLO-2 (Apply) |
| **Tools / Environment** | Jenkins (open source, self-hosted); Git; Docker; GitHub Actions free tier (optional) |
| **Estimated Time** | 150 minutes |

## 1. Objectives

On successful completion of this lab, the student will be able to:

- Explain the stages of a CI/CD pipeline as applied to infrastructure automation.
- Run a self-hosted Jenkins server with OpenTofu available to its pipelines.
- Run an automated format-check, validate, plan, approve, and apply pipeline from a Jenkinsfile stored in Git.

## 2. Preamble / Short Theory

The course outline lists both Jenkins and GitHub Actions. This manual teaches Jenkins as the primary tool because it is open source (MIT license) and self-hosted, so every student can build real pipelines without a hosted-service account; the GitHub Actions free tier is shown as an optional alternative.

The standard Jenkins image contains neither OpenTofu nor access to Docker, so you first build a small custom image. The pipeline includes a manual approval gate before apply, the safeguard discussed in Week 11.

## 3. Prerequisites

- Lab 6 completed, with its Git repository on branch `main`.
- Docker installed. Port 8090 free on the host (Jenkins uses 8090 so that it does not clash with the web containers of Lab 6, which use ports 8080 and up).

## 4. Step-by-Step Guide

### Step 1: Add the Jenkinsfile to your Lab 6 repository

Create a file named `Jenkinsfile` in the root of `lab06-terraform-provisioning` and commit it.

📄 **File:** `Jenkinsfile`

```groovy
pipeline {
  agent any
  stages {
    stage('Init')         { steps { sh 'tofu init -input=false' } }
    stage('Format Check') { steps { sh 'tofu fmt -check -recursive' } }
    stage('Validate')     { steps { sh 'tofu validate' } }
    stage('Plan')         { steps { sh 'tofu plan -input=false -out=tfplan' } }
    stage('Approval') {
      steps { input message: 'Review the plan above. Apply it?', ok: 'Apply' }
    }
    stage('Apply')        { steps { sh 'tofu apply -input=false tfplan' } }
  }
}
```

> 💾 Saved in this folder: [`Jenkinsfile`](Jenkinsfile)

```bash
cd ~/lab06-terraform-provisioning
git add Jenkinsfile
git commit -m "Add Jenkins pipeline"
```

### Step 2: Build a Jenkins image that contains OpenTofu

In a new folder `lab07-jenkins`, create a `Dockerfile`. Check opentofu.org for the current release and adjust `TOFU_VERSION` if you prefer a newer one.

📄 **File:** `lab07-jenkins/Dockerfile`

```dockerfile
FROM jenkins/jenkins:lts
USER root
ARG TOFU_VERSION=1.9.0
RUN apt-get update \
 && apt-get install -y --no-install-recommends unzip curl git \
 && ARCH=$(dpkg --print-architecture) \
 && curl -fsSL -o /tmp/tofu.zip "https://github.com/opentofu/opentofu/releases/download/v${TOFU_VERSION}/tofu_${TOFU_VERSION}_linux_${ARCH}.zip" \
 && unzip /tmp/tofu.zip tofu -d /usr/local/bin \
 && rm -f /tmp/tofu.zip \
 && rm -rf /var/lib/apt/lists/* \
 && git config --system --add safe.directory '*'
```

> 💾 Saved in this folder: [`lab07-jenkins/Dockerfile`](lab07-jenkins/Dockerfile)

### Step 3: Run Jenkins

The container runs as root for the lab so that it can use the Docker socket, and it mounts your Lab 6 repository read-only (adjust the path in the last `-v` option if your repository is somewhere else). Do not use this configuration in production.

```bash
docker build -t jenkins-iac:lab7 .
docker run -d --name jenkins -u root -p 8090:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$HOME/lab06-terraform-provisioning:/repos/lab06:ro" \
  jenkins-iac:lab7
```

### Step 4: Complete the setup wizard

Retrieve the initial admin password, browse to http://127.0.0.1:8090, install the suggested plugins, and create an admin user.

```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

### Step 5: Create a Pipeline job

New Item, Pipeline, name `lab07-iac-pipeline`. Under Pipeline choose Pipeline script from SCM, SCM Git, Repository URL `file:///repos/lab06`, Branch `*/main`, Script Path `Jenkinsfile`. Save.

### Step 6: Trigger the pipeline

Click Build Now. Watch each stage run in the Stage View. At the Approval stage, open the build, review the plan in the console output, and click Apply.

### Step 7: Review the console output

Open the Console Output of a completed build and identify exactly which `tofu` commands Jenkins executed and in what order. Verify the containers with `docker ps`. The pipeline keeps its own state inside the Jenkins workspace, so clean up from there:

```bash
docker exec -w /var/jenkins_home/workspace/lab07-iac-pipeline jenkins tofu destroy -auto-approve
```

### Step 8: (Optional) Mirror the pipeline in GitHub Actions

Create `.github/workflows/opentofu.yml` in a GitHub repository containing your Lab 6 code, push, and compare the setup effort with self-hosted Jenkins.

📄 **File:** `.github/workflows/opentofu.yml`

```yaml
name: OpenTofu pipeline
on: [push]
jobs:
  iac:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: opentofu/setup-opentofu@v1
      - run: tofu init -input=false
      - run: tofu fmt -check -recursive
      - run: tofu validate
      - run: tofu plan -input=false
```

> 💾 Saved in this folder: [`.github/workflows/opentofu.yml`](.github/workflows/opentofu.yml)

## 5. Your Tasks / Required Outcomes

- The `Jenkinsfile`, the `Dockerfile`, and the console output log of at least one full, successful pipeline run.
- A dated screenshot of the Jenkins Stage View showing all stages passing, including the approval gate.

## 📁 Files in this folder

- [`.github/workflows/opentofu.yml`](.github/workflows/opentofu.yml)
- [`Jenkinsfile`](Jenkinsfile)
- [`lab07-jenkins/Dockerfile`](lab07-jenkins/Dockerfile)

---
⬅️ [Back to Lab Manual index](../README.md)
