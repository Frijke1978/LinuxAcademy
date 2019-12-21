In this lesson, we will start our networking resource deployment and we will deploy our Internet Gateway and route tables.
Environment setup:
mkdir -p  ~/terraform/AWS/networking
cd ~/terraform/AWS/networking
Touch the files:
touch {main.tf,variables.tf,outputs.tf,terraform.tfvars}
Edit main.tf:
vi main.tf
main.tf:
#----networking/main.tf----

data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "tf_vpc"
  }
}

resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  tags {
    Name = "tf_igw"
  }
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf_internet_gateway.id}"
  }

  tags {
    Name = "tf_public"
  }
}

resource "aws_default_route_table" "tf_private_rt" {
  default_route_table_id  = "${aws_vpc.tf_vpc.default_route_table_id}"

  tags {
    Name = "tf_private"
  }
}

resource "aws_subnet" "tf_public_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.tf_vpc.id}"
  cidr_block              = "${var.public_cidrs[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "tf_public_${count.index + 1}"
  }
}

resource "aws_route_table_association" "tf_public_assoc" {
  count          = "${aws_subnet.tf_public_subnet.count}"
  subnet_id      = "${aws_subnet.tf_public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.tf_public_rt.id}"
}

resource "aws_security_group" "tf_public_sg" {
  name        = "tf_public_sg"
  description = "Used for access to the public instances"
  vpc_id      = "${aws_vpc.tf_vpc.id}"

  #SSH

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  #HTTP

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
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