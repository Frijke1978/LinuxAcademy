In this lesson, we will start refactoring the storage module to use some of the new features of Terraform 0.12.x.
cd /home/cloud_user/terraform/t12/storage
rm -rf *
Create main.tf:
vi main.tf
main.tf contents:
# Create a random id
resource "random_id" "tf_bucket_id" {
  byte_length = 2
}

# Create the bucket
resource "aws_s3_bucket" "tf_code" {
    bucket        = format("la-terraform-%d", random_id.tf_bucket_id.dec)
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
terraform12 apply -auto-approve
Destroy the S3 bucket:
terraform12 destroy -auto-approve