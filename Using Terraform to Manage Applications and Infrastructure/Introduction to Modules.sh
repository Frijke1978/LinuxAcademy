In this video we will start talking about how to use modules in Terraform.

Set up the environment:

mkdir -p modules/image
mkdir -p modules/container

Create files for the image:

cd ~/terraform/basics/module/image
touch main.tf variables.tf outputs.tf

Create files for container:

cd ~/terraform/basics/module/container
touch main.tf variables.tf outputs.tf
