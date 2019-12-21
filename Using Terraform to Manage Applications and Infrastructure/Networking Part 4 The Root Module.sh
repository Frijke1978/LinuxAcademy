In this lesson, we will add the networking module to the root module.
Environment setup:
cd ~/terraform/AWS
Edit main.tf:
vi main.tf
main.tf:
provider "aws" {
  region = "${var.aws_region}"
}

# Deploy Storage Resources
module "storage" {
  source       = "./storage"
  project_name = "${var.project_name}"
}

# Deploy Networking Resources
module "networking" {
  source       = "./networking"
  vpc_cidr     = "${var.vpc_cidr}"
  public_cidrs = "${var.public_cidrs}"
  accessip     = "${var.accessip}"
}
Edit variables.tf:
vi variables.tf
variables.tf:
#----root/variables.tf-----
variable "aws_region" {}

#------ storage variables
variable "project_name" {}

#-------networking variables
variable "vpc_cidr" {}
variable "public_cidrs" {
  type = "list"
}
variable "accessip" {}
Edit terraform.tfvars:
vi terraform.tfvars
terraform.tfvars:
aws_region   = "us-east-1"
project_name = "la-terraform"
vpc_cidr     = "10.123.0.0/16"
public_cidrs = [
  "10.123.1.0/24",
  "10.123.2.0/24"
]
accessip    = "0.0.0.0/0"
Reinitialize Terraform:
export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]]"
terraform init
Validate code:
terraform validate
Apply Changes:
terraform apply -auto-approve
Destroy environment:
terraform destroy -auto-approve