Terraform commands:
taint: Manually mark a resource for recreation untaint: Manually unmark a resource as tainted

Tainting a resource:

terraform taint [NAME]

Untainting a resource:

terraform untaint [NAME]

Set up the environment:

cd terraform/basics

Redeploy the Ghost image:

terraform apply

Taint the Ghost blog resource:

terraform taint docker_container.container_id

See what will be changed:

terraform plan

Remove the taint on the Ghost blog resource:

terraform untaint docker_container.container_id

Verity that the Ghost blog resource is untainted:

terraform plan

Updating Resources

Lets edit main.tf and change the image to ghost:alpine.

Open main.tf:

vi main.tf

main.tf contents:

# Download the latest Ghost image
resource "docker_image" "image_id" {
  name = "ghost:alpine"
}

# Start the Container
resource "docker_container" "container_id" {
  name  = "ghost_blog"
  image = "${docker_image.image_id.latest}"
  ports {
    internal = "2368"
    external = "80"
  }
}

Validate changes made to main.tf:

terraform validate

See what changes will be applied:

terraform plan

Apply image changes:

terraform apply

List the Docker containers:

docker container ls

See what image Ghost is using:

docker image ls | grep [IMAGE]

Check again to see what changes will be applied:

terraform plan

Apply container changes:

terraform apply

See what image Ghost is now using:

docker image ls | grep [IMAGE]

Cleaning up the environment

Reset the environment:

terraform destroy

Confirm the destroy by typing yes.

List the Docker images:

docker image ls

Remove the Ghost blog image:

docker image rm ghost:latest

Reset main.tf:

vi main.tf

main.tf contents:

# Download the latest Ghost image
resource "docker_image" "image_id" {
  name = "ghost:latest"
}

# Start the Container
resource "docker_container" "container_id" {
  name  = "ghost_blog"
  image = "${docker_image.image_id.latest}"
  ports {
    internal = "2368"
    external = "80"
  }
}

More Reading