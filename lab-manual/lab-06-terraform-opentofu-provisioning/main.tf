resource "docker_network" "lab" {
  name = "lab06-net"
}

resource "docker_image" "nginx" {
  name         = "nginx:stable"
  keep_locally = true
}

resource "docker_container" "web" {
  count = var.container_count
  name  = "web-${count.index}"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.lab.name
  }

  ports {
    internal = 80
    external = var.external_base_port + count.index
  }
}
