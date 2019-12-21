Additional Information and Resources
Create a new SSH key for cloud_user.
Edit main.tf in the Compute Module
Update the public_key argument in the aws_key_pair resource to use the contents of id_rsa.pub.
Create a data source to using the template_file resource.
Because we will be working with multiple resources, add count and set it using the instance_count variable.
Set the template argument by reading the contents of userdata.tpl. Make sure to use path.module when referencing the template file.
Add a variable called message that will be passed to the template.
The message should be set to hello from the server. 
Deploy the infrastructure
Initialize Terraform. 
Validate the files. 
Deploy the EC2 instances. 
Learning Objectives
check_circle
Create a New SSH Key for `cloud_user`
keyboard_arrow_up
Create the SSH Key:
ssh-keygen
check_circle
Update the Compute Module's `main.tf` File
keyboard_arrow_up
Edit main.tf: 
vi compute/main.tf
main.tf contents:
#-----compute/main.tf

data "aws_ami" "server_ami" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

# Need to access the public key file referenced in var.public_key_path

resource "aws_key_pair" "tf_auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

# Template file goes here
data "template_file" "user-init" {
  count    = 2
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    message = "hello from the server"
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
check_circle
Deploy the Infrastructure
keyboard_arrow_up
Initialize Terraform:
terraform init
Validate the files:
terraform validate
Deploy the EC2 instances:
terraform apply -auto-approve