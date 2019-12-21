In this lesson, we are going to take a look at how to force a redeploy of your resources using tainting. This is an extremely useful skill for when parts of a deployment need to be modified.
# Download the latest Ghost image
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