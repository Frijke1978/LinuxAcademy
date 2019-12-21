In this lesson, we will start working on our root module. We'll start off by adding the storage module created in the previous lesson.
Environment setup:
cd ~/terraform/AWS
touch {main.tf,variables.tf,outputs.tf,terraform.tfvars}
Edit main.tf:
vi main.tf
main.tf:
#----root/main.tf-----
provider "aws" {
  region = "${var.aws_region}"
}

# Deploy Storage Resources
module "storage" {
  source       = "./storage"
  project_name = "${var.project_name}"
}
Edit variables.tf:
vi variables.tf
variables.tf:
#----root/variables.tf-----
variable "aws_region" {}

#------ storage variables
variable "project_name" {}
Edit terraform.tfvars:
vi terraform.tfvars
terraform.tfvars:
aws_region   = "us-east-1"
project_name = "la-terraform"
Edit outputs.tf:
vi outputs.tf
outputs.tf:
#----root/outputs.tf-----

#----storage outputs------
output "Bucket Name" {
  value = "${module.storage.bucketname}"
}
Initialize terraform:
export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]]"
terraform init
Validate code:
terraform validate
Deploy the S3 bucket:
terraform apply -auto-approve
Destroy S3 bucket:
terraform destroy -auto-approve