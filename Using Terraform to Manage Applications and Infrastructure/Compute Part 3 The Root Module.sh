In this lesson, we will finish working with the EC2 resources by adding the compute module to the root module.
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
  accessip    = "${var.accessip}"
}

# Deploy Compute Resources
module "compute" {
  source          = "./compute"
  instance_count  = "${var.instance_count}"
  key_name        = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  instance_type   = "${var.server_instance_type}"
  subnets         = "${module.networking.public_subnets}"
  security_group  = "${module.networking.public_sg}"
  subnet_ips      = "${module.networking.subnet_ips}"
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

#-------compute variables
variable "key_name" {}
variable "public_key_path" {}
variable "server_instance_type" {}
variable "instance_count" {
  default = 1
}
Edit outputs.tf:
vi outputs.tf
outputs.tf:
#----root/outputs.tf-----

#----storage outputs------

output "Bucket Name" {
  value = "${module.storage.bucketname}"
}

#---Networking Outputs -----

output "Public Subnets" {
  value = "${join(", ", module.networking.public_subnets)}"
}

output "Subnet IPs" {
  value = "${join(", ", module.networking.subnet_ips)}"
}

output "Public Security Group" {
  value = "${module.networking.public_sg}"
}

#---Compute Outputs ------

output "Public Instance IDs" {
  value = "${module.compute.server_id}"
}

output "Public Instance IPs" {
  value = "${module.compute.server_ip}"
}
terraform.tfvars:
aws_region   = "us-west-1"
project_name = "la-terraform"
vpc_cidr     = "10.123.0.0/16"
public_cidrs = [
  "10.123.1.0/24",
  "10.123.2.0/24"
]
accessip    = "0.0.0.0/0"
key_name = "tf_key"
public_key_path = "/home/cloud_user/.ssh/id_rsa.pub"
server_instance_type = "t2.micro"
instance_count = 2
Initialize Terraform:
export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]"
terraform init
Validate changes:
terraform validate

Plan the changes:
terraform plan
Apply the changes:
terraform apply
Destroy environment:
terraform destroy