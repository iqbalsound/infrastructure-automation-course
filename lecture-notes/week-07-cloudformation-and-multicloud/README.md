# Week 7: CloudFormation Concepts and Multi-Cloud Automation

## 🎯 Learning Objectives

- Explain the concept of provider-native declarative templating and how it compares to cloud-agnostic IaC tools.
- Identify the trade-offs between single-cloud and multi-cloud/cloud-agnostic automation strategies.
- Compare an open-source cloud-agnostic approach with a provider-native templating approach conceptually.
- Produce a structured comparison of two infrastructure automation approaches for a given scenario.

## 🛠️ Hour 3 - Assignment: Comparative Analysis Exercise

### Task

Students are given a short, provider-native template example (JSON/YAML, presented for reading and analysis only, not for execution against a paid account) describing a small set of resources.

Students rewrite the equivalent infrastructure using Terraform/OpenTofu syntax (targeting the Docker or LocalStack provider used in Week 6, or written as a syntactically valid but non-applied example) to concretely compare the two authoring experiences.

Students complete a comparison table (portability, syntax verbosity, state management, multi-resource dependency handling) and write a short justified recommendation for a hypothetical company scenario provided by the instructor.

Groups present their comparison table and recommendation briefly, with peer questions, reinforcing CLO-3 evaluative skills ahead of the midterm review in Week 8.

### ✅ Solution / Example Code

📄 **File:** `provider-native-template.yaml`

```yaml
# Illustrative provider-native style template (read-only comparison exercise)
Resources:
  MyBucket:
    Type: "CloudProviderX::Storage::Bucket"
    Properties:
      BucketName: "course-demo-bucket"
```

> 💾 Saved in this folder: [`provider-native-template.yaml`](provider-native-template.yaml)

📄 **File:** `equivalent-opentofu.tf`

```hcl
# Equivalent cloud-agnostic style (Terraform/OpenTofu, illustrative)
resource "local_file" "bucket_placeholder" {
  filename = "./course-demo-bucket/.keep"
  content  = "placeholder for storage bucket concept"
}
```

> 💾 Saved in this folder: [`equivalent-opentofu.tf`](equivalent-opentofu.tf)

### 🧰 Recommended Open-Source / Free Tools

- OpenTofu/Terraform (open source)
- Crossplane (open source, conceptual)
- LibreOffice Calc or Writer (free, for comparison table)

## 📁 Files in this folder

- [`provider-native-template.yaml`](provider-native-template.yaml)
- [`equivalent-opentofu.tf`](equivalent-opentofu.tf)

---
⬅️ [Back to Lecture Notes index](../README.md)
