In this lesson, we will continue refactoring the storage module by adding in variables.
Create variables.tf:
vi variables.tf
variables.tf contents:
variable "project_name" {
  type = string
}
Create main.tf:
vi main.tf
main.tf contents:
# Create a random id
resource "random_id" "tf_bucket_id" {
  byte_length = 2
}

# Create the bucket
resource "aws_s3_bucket" "tf_code" {
    bucket        = format("%s-%d", var.project_name, random_id.tf_bucket_id.dec)
    acl           = "private"
    force_destroy =  true
    tags          = {
      Name = "tf_bucket"
    }
}
Set up the AWS access key:
export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]]"
export AWS_DEFAULT_REGION="us-east-1"
Plan the deploy of the S3 bucket:
terraform12 plan -var project_name=la-terraform
Deploy the S3 bucket:
terraform12 apply -var project_name=la-terraform -auto-approve
Destroy the S3 bucket:
terraform12 destroy -var project_name=la-terraform -auto-approve