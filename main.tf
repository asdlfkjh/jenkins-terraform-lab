terraform {
  required_version = ">= 1.5.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "web_app" {
  image = docker_image.nginx.image_id
  name  = "jenkins-pipeline-nginx"

  ports {
    internal = 80
    external = 8085
  }
}
