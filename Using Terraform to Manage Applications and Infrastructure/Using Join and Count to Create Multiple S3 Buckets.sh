Additional Information and Resources
Navigate to the lab directory. In there we will find three files: main.tf,variables.tf and outputs.tf. 
Update the Variables File
Edit variables.tf.
Add a new variable number_of_instances.
Set the the default to 2. 
Update the Main File
Update random_id and add a count.
Set the value count to use the number_of_instances variable.
Update aws_s3_bucket and add a count.
Update random_id.tf_bucket_id.dec so it iterates through the count. Update the Name tag so that tf_bucket is appended with the count index plus one.
Update the Outputs File
Update the bucketname output value to use the join function so that it returns a comma delimited list of bucket names.
Deploy the Infrastructure
Initialize Terraform. 
Validate the files. 
Deploy the S3 buckets. 
Learning Objectives
check_circle
Update the Terraform Files
keyboard_arrow_up
Update main.tf:
vi main.tf
main.tf contents:
provider "aws" {
  region = "${var.aws_region}"
}

resource "random_id" "tf_bucket_id" {
  count       = "${var.number_of_instances}"
  byte_length = 2
}

resource "aws_s3_bucket" "tf_code" {
  count         = "${var.number_of_instances}"
  bucket        = "${var.project_name}-${random_id.tf_bucket_id.*.dec[count.index]}"
  acl           = "private"
  force_destroy =  true

  tags {
    Name = "tf_bucket${count.index+1}"
  }
}
Update variables.tf:
vi variables.tf
variables.tf contents:
variable "aws_region" {
  default = "us-east-1"
}

variable "number_of_instances" {
  default = "2"
}

variable "project_name" {
  default = "la-terraform"
}
Update outputs.tf:
vi outputs.tf
outputs.tf contents:
output "bucketname" {
  value = "${join(", ", aws_s3_bucket.tf_code.*.id)}"
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