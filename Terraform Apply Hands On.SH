Additional Information and Resources

Open the AWS console and access the Cloud9 console. Once you have launched the provided IDE, clone the git repository at: https://github.com/linuxacademy/content-terraform

NOTE: When you run the command terraform apply, you will get the unique error Unable to read Docker image into resource: Unable to list Docker images: Error response from daemon: client version 1.39 is too new. Maximum supported API version is 1.38.

To avoid this add the below line to your main.tf and run terraform init:

provider "docker" { version = "1.1" }

Learning Objectives
check_circle
Download the GitHub Repository
keyboard_arrow_up

We've got to grab all of the scripts that need attention, and they're sitting up in a GitHub repository:

git clone https://github.com/linuxacademy/content-terraform

check_circle
Install Terraform
keyboard_arrow_up

Within content-terraform are several other directories. One, install-scripts, contains scripts that will install various things. Let's get in there and run the script that installs Terraform:

cd install-scripts
./terraform.sh

check_circle
Edit main.tf
keyboard_arrow_up

Below the # Download the ghost... line, but above the resource that's already sitting there, let's make another resource:

resource "docker_image" "image_id" {
  name = "ghost:latest"
}

check_circle
Initialize and Apply Terraform
keyboard_arrow_up

terraform init
terraform apply

Type yes when prompted.

Running docker image ls should show the ghost image in the list.
