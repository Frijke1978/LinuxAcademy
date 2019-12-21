In this lesson, we will use the Terraform Console to view various outputs that we can use for our scripts. The Terraform Console is extremely useful for troubleshooting and planning deployments.

Terraform commands:
console: Interactive console for Terraform interpolations

Set up the environment:

cd terraform/basics

Working with the Terraform console

Redeploy the Ghost image and container:

terraform apply

Show the Terraform resources:

terraform show

Start the Terraform console:

terraform console

Type the following in the console to get the container's name:

docker_container.container_id.name

Type the following in the console to get the container's IP:

docker_container.container_id.ip_address

Break out of the Terraform console by using Ctrl+C.

Destroy the environment:

terraform destroy

Output the name and IP of the Ghost blog container

Edit main.tf:

vi main.tf

main.tf contents:

# Download the latest Ghost Image
resource "docker_image" "image_id" {
  name = "ghost:latest"
}

# Start the Container
resource "docker_container" "container_id" {
  name  = "blog"
  image = "${docker_image.image_id.latest}"
  ports {
    internal = "2368"
    external = "80"
  }
}

#Output the IP Address of the Container
output "ip_address" {
  value       = "${docker_container.container_id.ip_address}"
  description = "The IP for the container."
}

#Output the Name of the Container
output "container_name" {
  value       = "${docker_container.container_id.name}"
  description = "The name of the container."
}

Validate changes:

terraform validate

Apply changes to get output:

terraform apply

Cleaning up the environment

Reset the environment:

terraform destroy

Read more

Console
Outputs

How do you feel about this video?
