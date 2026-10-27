# main.tf (Docker provider - free/open source, no cloud cost)
resource "docker_image" "nginx" {
  name = "nginx:1.25"
}

resource "docker_container" "web" {
  count = var.container_count
  name  = "web-${count.index}"
  image = docker_image.nginx.image_id
}

# Commands
# tofu init
# tofu plan -var="container_count=3"
# tofu apply -var="container_count=3"
# tofu destroy
