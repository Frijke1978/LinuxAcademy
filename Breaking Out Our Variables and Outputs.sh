In this lesson, we will pull our variables and outputs from our main.tf file for a more stateless deployment. By separating the variables and outputs from our main file, this will allow us to deploy different environments by interchanging those files with files that contain different values.
# Download the latest Ghost Image
resource "docker_image" "image_id" {
  name = "${var.image}"
}

# Start the Container
resource "docker_container" "container_id" {
  name  = "${var.container_name}"
  image = "${docker_image.image_id.latest}"
  ports {
    internal = "${var.int_port}"
    external = "${var.ext_port}"
  }
}
view raw
breakingOutFiles_main.tf hosted with ❤ by GitHub
#Output the IP Address of the Container
output "ip" {
  value = "${docker_container.container_id.ip_address}"
}

output "container_name" {
  value = "${docker_container.container_id.name}"
}
view raw
breakingOutFiles_outputs.tf hosted with ❤ by GitHub
variable "container_name" {
  description = "Name of container"
  default = "blog"
}

variable "image" {
  description = "image for container"
  default = "ghost:latest"
}

variable "int_port" {
  description = "internal port for container"
  default = "2368"
}

variable "ext_port" {
  description = "external port for container"
  default = "80"
}