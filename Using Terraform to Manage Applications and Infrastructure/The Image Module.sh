In this lesson we will create our first Terraform module.
Go to the image directory:
cd ~/terraform/docker/modules/image
Edit main.tf:
vi main.tf
main.tf contents:
# Download the Image
resource "docker_image" "image_id" {
  name = "${var.image_name}"
}
Edit variables.tf:
vi variables.tf
variables.tf contents:
variable "image_name" {
  description = "Name of the image"
}
Edit outputs.tf:
vi outputs.tf
outputs.tf: contents:
output "image_out" {
  value       = "${docker_image.image_id.latest}"
}
Initialize Terraform:
terraform init
Create the image plan:
terraform plan -out=tfplan -var 'image_name=ghost:alpine'
Deploy the image using the plan:
terraform apply -auto-approve tfplan
Destroy the image:
terraform destroy -auto-approve -var 'image_name=ghost:alpine'