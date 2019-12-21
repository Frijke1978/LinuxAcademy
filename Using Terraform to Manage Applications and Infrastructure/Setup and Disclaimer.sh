In this lesson, we will install Terraform 0.12.2 and talk about some of the pitfalls you may encounter working with such a new release.
Install Terraform 0.12:
cd /tmp
sudo curl -O https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip
sudo unzip terraform_0.12.2_linux_amd64.zip
sudo cp terraform /usr/bin/terraform12
Test the Terraform installation:
terraform12 version
Setup a Terraform 0.12 directory:
mkdir /home/cloud_user/terraform/t12
cd /home/cloud_user/terraform/t12
cp -r /home/cloud_user/terraform/basics .
cd basics
rm -r .terraform
Test Docker by initializing Terraform:
terraform12 init
Copy AWS/storage to the Terraform 0.12 directory:
cd /home/cloud_user/terraform/t12
cp -r ../AWS/storage .
cd storage
Edit main.tf:
vi main.tf
main.tf contents:
#---------storage/main.tf---------

# Create a random id
resource "random_id" "tf_bucket_id" {
  byte_length = 2
}

# Create the bucket
resource "aws_s3_bucket" "tf_code" {
    bucket        = "${var.project_name}-${random_id.tf_bucket_id.dec}"
    acl           = "private"

    force_destroy =  true

    tags = {
      Name = "tf_bucket"
    }
}
Set up the AWS access key:
export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]]"
export AWS_DEFAULT_REGION="us-east-1"
Initialize Terraform:
terraform12 init
Deploy the S3 bucket:
terraform12 apply -var project_name=la-terraform -auto-approve
Destroy the S3 bucket:
terraform12 destroy -var project_name=la-terraform -auto-approve
Test with the older version of Terraform:
ls -la
rm -r .terraform terraform.tfstate*
terraform init
terraform apply -var project_name=la-terraform -auto-approve
terraform destroy -var project_name=la-terraform -auto-approve