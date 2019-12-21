In this lesson, we will create a map to specify different environment variables based on conditions. This will allow us to dynamically deploy infrastructure configurations based on information we pass to the deployment.

Set up the environment:

cd terraform/basics

Edit variables.tf:

vi variables.tf

variables.tf contents:

#Define variables
variable "env" {
  description = "env: dev or prod"
}
variable "image_name" {
  type        = "map"
  description = "Image for container."
  default     = {
    dev  = "ghost:latest"
    prod = "ghost:alpine"
  }
}

variable "container_name" {
  type        = "map"
  description = "Name of the container."
  default     = {
    dev  = "blog_dev"
    prod = "blog_prod"
  }
}

variable "int_port" {
  description = "Internal port for container."
  default     = "2368"
}
variable "ext_port" {
  type        = "map"
  description = "External port for container."
  default     = {
    dev  = "8081"
    prod = "80"
  }
}

Validate the change:

terraform validate

Edit main.tf:

vi main.tf

main.tf contents:

# Download the latest Ghost Image
resource "docker_image" "image_id" {
  name = "${lookup(var.image_name, var.env)}"
}

# Start the Container
resource "docker_container" "container_id" {
  name  = "${lookup(var.container_name, var.env)}"
  image = "${docker_image.image_id.latest}"
  ports {
    internal = "${var.int_port}"
    external = "${lookup(var.ext_port, var.env)}"
  }
}

Plan the dev deploy:

terraform plan -out=tfdev_plan -var env=dev

Apply the dev plan:

terraform apply tfdev_plan

Plan the prod deploy:

terraform plan -out=tfprod_plan -var env=prod

Apply the prod plan:

terraform apply tfprod_plan

Destroy prod deployment:

terraform destroy -var env=prod -auto-approve

Use environment variables:

export TF_VAR_env=prod

Open the Terraform console:

terraform console

Execute a lookup:

lookup(var.ext_port, var.env)

Exit the console:

unset TF_VAR_env
