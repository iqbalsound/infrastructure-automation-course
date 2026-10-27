terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "docker" {}

module "web" {
  source          = "../modules/web"
  container_count = 3
  environment     = "production"
}

resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"
  content  = templatefile("${path.module}/../templates/inventory.tftpl", {
    hosts = module.web.container_names
  })
}

output "container_names" {
  value = module.web.container_names
}
