In this lesson we will refactor the root module to use the image and container modules we created in the previous two lessons.
Go to the module directory:
cd ~/terraform/basics/modules/
touch {main.tf,variables.tf,outputs.tf}
Edit main.tf:
vi main.tf
main.tf contents:
# Download the image
module "image" {
  source = "./image"
  image_name  = "${var.image_name}"
}

# Start the container
module "container" {
  source             = "./container"
  image              = "${module.image.image_out}"
  container_name     = "${var.container_name}"
  int_port           = "${var.int_port}"
  ext_port           = "${var.ext_port}"
}
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
Edit outputs.tf:
vi outputs.tf
outputs.tf contents:
#Output the IP Address of the Container
output "ip" {
  value = "${module.container.ip}"
}

output "container_name" {
  value = "${module.container.container_name}"
}
Initialize Terraform:
terraform init
Create the image plan:
terraform plan -out=tfplan
Deploy the container using the plan:
terraform apply tfplan
Destroy the deployment:
terraform destroy -auto-approve