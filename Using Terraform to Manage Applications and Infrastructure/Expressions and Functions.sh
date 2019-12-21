In this lesson, we will look at the documenation for functions. Then we will use the cidrsubnet function to calculates a subnet address within given IP network address prefix.
Set up the environment:
mkdir ~/terraform/t12/functions
cd ~/terraform/t12/functions
Create main.tf:
vi main.tf
main.tf contents:
variable "vpc_cidr" {
  default = "10.123.0.0/16"
}

variable "accessip" {
  default = "0.0.0.0/0"
}

variable "subnet_numbers" {
  default = [1, 2, 3]
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

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = [
      for num in var.subnet_numbers:
      cidrsubnet(aws_vpc.tf_vpc.cidr_block, 8, num)
    ]
  }
}
Initialize Terraform:
export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]"
export AWS_DEFAULT_REGION="us-east-1"
terraform12 init
Plan the changes:
terraform12 plan
Functions
cidrsubnet funciton