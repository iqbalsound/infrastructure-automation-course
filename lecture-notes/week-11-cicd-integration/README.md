# Week 11: Integration with CI/CD Pipelines

## 🎯 Learning Objectives

- Explain the stages of a CI/CD pipeline and their relationship to infrastructure automation.
- Describe Jenkins' pipeline-as-code model and GitHub Actions' workflow model.
- Integrate infrastructure automation (IaC/configuration management) commands into an automated pipeline.
- Evaluate pipeline design choices for safety and reliability.

## 🛠️ Hour 3 - Lab: Building an Automation Pipeline

### Task

Students create a GitHub Actions workflow file in their course repository that automatically runs on every push: checking out the repository, and running 'terraform fmt -check' and 'terraform plan' (or 'tofu' equivalents) against the Week 6 configuration using the Docker/local provider.

Extend the workflow to run an Ansible playbook's syntax check ('ansible-playbook --syntax-check') against the Week 4 playbook as an additional automated validation stage.

Introduce manual-approval concepts by discussing (and where feasible configuring) a required review/approval step before an 'apply' stage would run, even though the course lab environment will stop at 'plan' for safety.

As an optional stretch task for students with prior exposure, briefly demonstrate an equivalent Jenkinsfile achieving the same checkout-plan validation pipeline, for architectural comparison.

### ✅ Solution / Example Code

📄 **File:** `.github/workflows/iac-validate.yml`

```yaml
# .github/workflows/iac-validate.yml
name: IaC Validation Pipeline
on: [push]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup OpenTofu
        uses: opentofu/setup-opentofu@v1
      - name: Format Check
        run: tofu fmt -check
      - name: Init
        run: tofu init
      - name: Plan
        run: tofu plan
      - name: Install Ansible
        run: pipx install ansible-core
      - name: Ansible Syntax Check
        run: ansible-playbook --syntax-check playbook.yml
```

> 💾 Saved in this folder: [`.github/workflows/iac-validate.yml`](.github/workflows/iac-validate.yml)

### 🧰 Recommended Open-Source / Free Tools

- GitHub Actions (free tier)
- Jenkins (open source, optional comparison)
- OpenTofu/Terraform
- Ansible

## 📁 Files in this folder

- [`.github/workflows/iac-validate.yml`](.github/workflows/iac-validate.yml)

---
⬅️ [Back to Lecture Notes index](../README.md)
