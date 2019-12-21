In this lesson, we are going to deploy our very first infrastructure. We will learn about Terraform resources and start exploring Terraform syntax and console commands.
# Download the latest Ghost image
resource "docker_image" "image_id" {
  name = "ghost:latest"
}
view raw
firsApply_main.tf hosted with ❤ by GitHub
Please use Terraform 0.11.5 to complete this lesson

sudo curl -O https://releases.hashicorp.com/terraform/0.11.5/terraform_0.11.5_linux_amd64.zip
sudo apt-get install unzip
sudo mkdir /bin/terraform 
sudo unzip terraform_0.11.5_linux_amd64.zip -d /usr/local/bin/