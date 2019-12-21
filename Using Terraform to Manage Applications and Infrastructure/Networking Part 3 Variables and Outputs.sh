In this lesson, we will finish off the networking module by creating the variables and outputs Terraform files. Finally we will test the module before integrating it into the root module.
Edit variables.tf:
vi variables.tf
variables.tf:
#----networking/variables.tf----
variable "vpc_cidr" {}

variable "public_cidrs" {
  type = "list"
}

variable "accessip" {}
Edit outputs.tf:
vi outputs.tf
outputs.tf:
#-----networking/outputs.tf----

output "public_subnets" {
  value = "${aws_subnet.tf_public_subnet.*.id}"
}

output "public_sg" {
  value = "${aws_security_group.tf_public_sg.id}"
}

output "subnet_ips" {
  value = "${aws_subnet.tf_public_subnet.*.cidr_block}"
}
Edit terraform.tfvars:
vi terraform.tfvars
terraform.tfvars:
vpc_cidr     = "10.123.0.0/16"
public_cidrs = [
  "10.123.1.0/24",
  "10.123.2.0/24"
]
accessip    = "0.0.0.0/0"
Initialize Terraform:
export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]]"
terraform init
Validate code:
terraform validate
Deploy Network:
terraform apply -auto-approve
Destroy Network:
terraform destroy -auto-approve
Delete terraform.tfvars:
rm terraform.tfvars