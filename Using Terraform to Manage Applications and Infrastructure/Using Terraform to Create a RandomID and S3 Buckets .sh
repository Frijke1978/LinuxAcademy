Additional Information and Resources
Create the Main file
Create the main.tf Terraform file.
Add a provider, aws.
Set the region to use a variable called aws_region.
Add a random_id resource and name it tf_bucket_id.
Set the byte_length to 2. 
Add a resource, aws_s3_bucket, and name it tf_code.
The bucket name will be set using a variable called project_name, followed by a -, and will use the dec attribute from tf_bucket_id.
Set the acl to private.
Set force_destroy to true.
Create a tag with a name to tf_bucket. 
Create the Variables File
Create the variables.tf Terraform file.
Add a variable called aws_region.
Set the default to us-east-1. Add a variable called project_name.
Set the default to la-terraform. 
Create the outputs file
Create the outputs.tf Terraform file.
Add a output called bucketname.
The value should be set to id, coming from tf_code. 
Deploy the infrastructure
Initialize Terraform. 
Validate the files. 
Deploy the S3 bucket. 
Learning Objectives
check_circle
Create the Terraform Files
keyboard_arrow_up
Create main.tf:
vi main.tf
main.tf contents:
provider "aws" {
  region = "${var.aws_region}"
}

resource "random_id" "tf_bucket_id" {
  byte_length = 2
}

resource "aws_s3_bucket" "tf_code" {
    bucket        = "${var.project_name}-${random_id.tf_bucket_id.dec}"
    acl           = "private"

    force_destroy =  true

    tags {
      Name = "tf_bucket"
    }
}
Create variables.tf:
vi variables.tf
variables.tf contents:
variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "la-terraform"
}
Create outputs.tf:
vi outputs.tf
outputs.tf contents:
output "bucketname" {
  value = "${aws_s3_bucket.tf_code.id}"
}
check_circle
Deploy the S3 Bucket
keyboard_arrow_up
Initialize Terraform:
terraform init
Validate the files:
terraform validate
Deploy the S3 bucket:
terraform apply -auto-approve