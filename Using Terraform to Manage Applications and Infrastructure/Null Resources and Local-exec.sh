In this lesson, we will utilize a Null Resource in order to perform local commands on our machine without having to deploy extra resources.


Setup the environment:

cd terraform/basics

main.tf contents:

# Download the latest Ghost Image
resource "docker_image" "image_id" {
  name = "${lookup(var.image_name, var.env)}"
}

# Start the Container
resource "docker_container" "container_id" {
  name  = "${lookup(var.container_name, var.env)}"
  image = "${docker_image.image_id.latest}"
  ports {
    internal = "${var.int_port}"
    external = "${lookup(var.ext_port, var.env)}"
  }
}

resource "null_resource" "null_id" {
  provisioner "local-exec" {
    command = "echo ${docker_container.container_id.name}:${docker_container.container_id.ip_address} >> container.txt"
  }
}

Reinitialize Terraform:

terraform init

Validate the changes:

terraform validate

Plan the changes:

terraform plan -out=tfplan -var env=dev

Apply the changes:

terraform apply tfplan

View the contents of container.txt:

cat container.txt

Destroy the deployment:

terraform destroy -auto-approve -var env=dev
