In this lesson we will continue working with Terraform modules by breaking out the container code into it's own module.
Go to the container directory:
cd ~/terraform/basics/modules/container
Edit main.tf:
vi main.tf
main.tf contents:
# Start the Container
resource "docker_container" "container_id" {
  name  = "${var.container_name}"
  image = "${var.image}"
  ports {
    internal = "${var.int_port}"
    external = "${var.ext_port}"
  }
}
Edit variables.tf:
vi variables.tf
variables.tf contents:
#Define variables
variable "container_name" {}
variable "image" {}
variable "int_port" {}
variable "ext_port" {}
Edit outputs.tf:
vi outputs.tf
outputs.tf contents:
#Output the IP Address of the Container
output "ip" {
  value = "${docker_container.container_id.ip_address}"
}

output "container_name" {
  value = "${docker_container.container_id.name}"
}
Initialize:
terraform init
Create the image plan:
terraform plan -out=tfplan -var 'container_name=blog' -var 'image=ghost:alpine' -var 'int_port=2368' -var 'ext_port=80'
Deploy container using the plan:
terraform apply tfplan