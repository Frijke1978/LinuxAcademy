In this lesson, we will start working on building out the resources for out AWS compute.
Environment setup:
mkdir -p  ~/terraform/AWS/compute
cd ~/terraform/AWS/compute
Touch the files:
touch {main.tf,variables.tf,outputs.tf}
Create a SSH key.
ssh-keygen
Edit main.tf:
vi main.tf
main.tf:
#----compute/main.tf#----
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
Edit variables.tf:
vi variables.tf
variables.tf:
#----compute/variables.tf----
variable "key_name" {}

variable "public_key_path" {}
Initialize Terraform:
export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]]"
terraform init
Validate changes:
terraform validate
Plan the changes:
terraform plan -out=tfplan -var 'key_name=tfkey' -var 'public_key_path=/home/cloud_user/.ssh/id_rsa.pub'
Apply the changes:
terraform apply -auto-approve
Provide the values for key_name and public_key_path: key_name: tfkey public_key_path: /home/cloud_user/.ssh/id_rsa.pub
Destroy environment:
terraform destroy -auto-approve
Provide the values for key_name and public_key_path: key_name: tfkey public_key_path: /home/cloud_user/.ssh/id_rsa.pub