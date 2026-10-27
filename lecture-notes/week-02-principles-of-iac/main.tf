# main.tf - minimal declarative example (local provider, no cloud cost)
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

resource "local_file" "course_note" {
  content  = "Week 2 - Infrastructure as Code Lab"
  filename = "${path.module}/week2_output.txt"
}

# Commands
# tofu init
# tofu plan
# tofu apply
# tofu destroy
