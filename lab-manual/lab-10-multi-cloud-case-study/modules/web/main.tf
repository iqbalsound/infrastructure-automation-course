resource "docker_image" "base" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "web" {
  count    = var.container_count
  name     = "${var.environment}-web-${count.index}"
  image    = docker_image.base.image_id
  command  = ["sleep", "infinity"]
  must_run = true
}
