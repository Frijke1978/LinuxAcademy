In this lesson, we will finish off the Compute module by adding the aws_instance resource.
Edit main.tf:
vi main.tf
main.tf:
#-----compute/main.tf#-----

data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "tf_auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

data "template_file" "user-init" {
  count    = 2
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    firewall_subnets = "${element(var.subnet_ips, count.index)}"
  }
}

resource "aws_instance" "tf_server" {
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${data.aws_ami.server_ami.id}"

  tags {
    Name = "tf_server-${count.index +1}"
  }

  key_name               = "${aws_key_pair.tf_auth.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = "${element(var.subnets, count.index)}"
  user_data              = "${data.template_file.user-init.*.rendered[count.index]}"
}
Create userdata.tpl:
vi userdata.tpl
userdata.tpl:
#!/bin/bash
yum install httpd -y
echo "Subnet for Firewall: ${firewall_subnets}" >> /var/www/html/index.html
service httpd start
chkconfig httpd on
Edit variables.tf:
vi variables.tf
variables.tf:
#-----compute/variables.tf

variable "key_name" {}

variable "public_key_path" {}

variable "subnet_ips" {
  type = "list"
}

variable "instance_count" {}

variable "instance_type" {}

variable "security_group" {}

variable "subnets" {
  type = "list"
}
Edit outputs.tf:
vi outputs.tf
outputs.tf"
#-----compute/outputs.tf-----

output "server_id" {
  value = "${join(", ", aws_instance.tf_server.*.id)}"
}

output "server_ip" {
  value = "${join(", ", aws_instance.tf_server.*.public_ip)}"
}