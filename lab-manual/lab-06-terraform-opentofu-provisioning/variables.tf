variable "container_count" {
  description = "Number of web containers to provision"
  type        = number
  default     = 2
}

variable "external_base_port" {
  description = "Host port of the first container; each next one adds 1"
  type        = number
  default     = 8080
}
