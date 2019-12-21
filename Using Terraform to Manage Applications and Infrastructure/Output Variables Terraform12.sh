In this lesson, we will finish off refactoring the storage module by adding outputs of the S3 bucket name as well as the project_name variable.
Create outputs.tf:
vi outputs.tf
outputs.tf contents:
output "bucketname" {
  value = aws_s3_bucket.tf_code.id
}

output "project_name" {
  value = var.project_name
}
Initialize Terraform:
terraform12 init
Deploy the S3 bucket:
terraform12 apply -var project_name=la-terraform -auto-approve
Destroy the S3 bucket:
terraform destroy -var project_name=la-terraform -auto-approve