In this lesson, we will cover the basics of the Terraform configuration language, as well as explore providers and resources. Continuing what we started in Terraform Commands, we will modify main.tf so we can deploy a Ghost container to Docker.

The syntax of Terraform configurations is called HashiCorp Configuration Language (HCL). It is meant to strike a balance between being human-readable and editable, and being machine-friendly. For machine-friendliness, Terraform can also read JSON configurations. For general Terraform configurations, however, we recommend using the HCL Terraform syntax.
Terraform code files

The Terraform language uses configuration files that are named with the .tf file extension. There is also a JSON-based variant of the language that is named with the .tf.json file extension.
Terraform Syntax

Here is an example of Terraform's HCL syntax:

resource "aws_instance" "example" {
  ami = "abc123"

  network_interface {
    # ...
  }
}

Syntax reference:

    Single line comments start with #.
    Multi-line comments are wrapped with /* and */.
    Values are assigned with the syntax of key = value.
    Strings are in double-quotes.
    Strings can interpolate other values using syntax wrapped in ${}, for example ${var.foo}.
    Numbers are assumed to be base 10.
    Boolean values: true, false
    Lists of primitive types can be made with square brackets ([]), for example ["foo", "bar", "baz"].
    Maps can be made with braces ({}) and colons (:), for example { "foo": "bar", "bar": "baz" }.

Style Conventions:

    Indent two spaces for each nesting level.
    With multiple arguments, align their equals signs.

Setup the environment:

cd terraform/basics

Deploying a container using Terraform

Redeploy the Ghost image:

terraform apply

Confirm the apply by typing yes. The apply will take a bit to complete.

Open main.tf:

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

Validate main.tf:

terraform validate

Terraform Plan:

terraform plan

Apply the changes to main.tf:

terraform apply

Confirm the apply by typing yes.

List the Docker containers:

docker container ls

Access the Ghost blog by opening a browser and go to:

http:://[SWAM_MANAGER_IP]

Cleaning up the environment

Reset the environment:

terraform destroy

Confirm the destroy by typing yes.
More Reading

Terraform Configuration Language
Configuration Syntax
Docker Container Resource