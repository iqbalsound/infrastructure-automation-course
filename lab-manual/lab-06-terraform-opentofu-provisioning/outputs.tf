output "container_names" {
  value = docker_container.web[*].name
}

output "urls" {
  value = [for i in range(var.container_count) : "http://localhost:${var.external_base_port + i}"]
}
