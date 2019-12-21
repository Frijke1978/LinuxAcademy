Input variables serve as parameters for a Terraform file. A variable block configures a single input variable for a Terraform module. Each block declares a single variable.

Syntax:

variable [NAME] {
  [OPTION] = "[VALUE]"
}

Arguments

Within the block body (between { }) is configuration for the variable, which accepts the following arguments:

    type (Optional): If set, this defines the type of the variable. Valid values are string, list, and map.
    default (Optional): This sets a default value for the variable. If no default is provided, Terraform will raise an error if a value is not provided by the caller.
    description (Optional): A human-friendly description for the variable.

Using variables during an apply:

terraform apply -var 'foo=bar'

Set up the environment:

cd terraform/basics

Edit main.tf:

vi main.tf

main.tf contents:

#Define variables
variable "image_name" {
  description = "Image for container."
  default     = "ghost:latest"
}

variable "container_name" {
  description = "Name of the container."
  default     = "blog"
}

variable "int_port" {
  description = "Internal port for container."
  default     = "2368"
}

variable "ext_port" {
  description = "External port for container."
  default     = "80"
}

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

terraform plan

Apply the changes using a variable:

terraform apply -var 'ext_port=8080'

Change the container name:

terraform apply -var 'container_name=ghost_blog' -var 'ext_port=8080'

Reset the environment:

terraform destroy -var 'ext_port=8080'

Read more

Variables https://www.terraform.io/docs/configuration-0-11/variables.html