In this lesson we will begin working with dynamic nested blocks to dynamically construct nested blocks.
Set up the environment:
mkdir ~/terraform/t12/loops
cd ~/terraform/t12/loops
Create main.tf:
vi main.tf
main.tf contents:
variable "vpc_cidr" {
  default = "10.123.0.0/16"
}

variable "accessip" {
  default = "0.0.0.0/0"
}

variable "service_ports" {
  default = ["22", "22"]
}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf_vpc"
  }
}

resource "aws_security_group" "tf_public_sg" {
  name        = "tf_public_sg"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.tf_vpc.id

  dynamic "ingress" {
    for_each = var.service_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.accessip]
    }
  }
}
Initialize Terraform:
export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]"
export AWS_DEFAULT_REGION="us-east-1"
terraform12 init
Plan the changes:
terraform12 plan
More information:
https://www.terraform.io/docs/configuration/index.html https://www.terraform.io/docs/configuration/expressions.html