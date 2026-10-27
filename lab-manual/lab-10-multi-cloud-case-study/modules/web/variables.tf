variable "container_count" {
  type = number
}

variable "environment" {
  type = string
}

variable "image" {
  type    = string
  default = "ubuntu:24.04"
}
