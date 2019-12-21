Setup your environment:

cd terraform/basics

Edit variables.tf:

vi variables.tf

variables.tf contents:

#Define variables
variable "container_name" {
  description = "Name of the container."
  default     = "blog"
}
variable "image_name" {
  description = "Image for container."
  default     = "ghost:latest"
}
variable "int_port" {
  description = "Internal port for container."
  default     = "2368"
}
variable "ext_port" {
  description = "External port for container."
  default     = "80"
}

Edit main.tf:

vi main.tf

main.tf contents:

# Download the latest Ghost Image
resource "docker_image" "image_id" {
  name = "${var.image_name}"
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

Edit outputs.tf:

vi outputs.tf

outputs.tf contents:

#Output the IP Address of the Container
output "IP Address" {
  value       = "${docker_container.container_id.ip_address}"
  description = "The IP for the container."
}

output "container_name" {
  value       = "${docker_container.container_id.name}"
  description = "The name of the container."
}

Validate the changes:

terraform validate

Plan the changes:

terraform plan -out=tfplan -var container_name=ghost_blog

Apply the changes:

terraform apply tfplan

Destroy deployment:

terraform destroy -auto-approve -var container_name=ghost_blog
