# Illustrative combined-solution skeleton
# Step 1: Terraform/OpenTofu provisions containers (Week 6 pattern)
resource "docker_container" "app_vm" {
  name  = "capstone-app"
  image = docker_image.base.image_id
}

output "app_container_name" {
  value = docker_container.app_vm.name
}
