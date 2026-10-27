terraform {
  required_version = ">= 1.6.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

variable "student_name" {
  description = "Your full name and roll number"
  type        = string
  default     = "Your Name (Roll No)"
}

resource "local_file" "hello" {
  filename = "${path.module}/hello.txt"
  content  = "Provisioned by OpenTofu for ${var.student_name}\n"
}
