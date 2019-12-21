Additional Information and Resources
Create the variables file

    Create variables.tf and add four variables with these default values:
        container_name: mysql.
        mysql_root_password: P4sSw0rd0!.
        mysql_network_name: mysql_internal_network.
        mysql_volume_name: mysql_data.

Create the images file

    Create images.tf.
        Add the docker_image resource and call it mysql_image.
        Set the name to mysql:5.7.

Create the networks file

    Create networks.tf.
        Add the docker_network resource and call it private_bridge_network.
        Set the name to use the mysql_network_name variable.
        Set the driver to bridge.
        Set internal to true.

Create the volumes file

    In volumes.tf add the docker_volume resource and call it mysql_data_volume.
    Set the name to use the mysql_volume_name variable.

Create the main file

    In main.tf add the docker_container resource and call it mysql_container.
    Set the name to use the container_name variable.
    Set the image to use the name of the image coming from docker_image.
    Create an environment variable for MYSQL_ROOT_PASSWORD and set it to the mysql_root_password variable.
    Configure the container volume to use the volume created by docker_volume, and make sure the container_path is set to /var/lib/mysql.
    The container needs to use the network created by docker_network.

Deploy the infrastructure

    Initialize Terraform.
    Validate the files.
    Generate a Terraform plan.
    Deploy the infrastructure using the plan file.

Learning Objectives
check_circle
Create the Variables File
keyboard_arrow_up

Create variables.tf:

vi variables.tf

with these contents:

variable "container_name" {
  description = "The MySQL container name."
  default     = "mysql"
}

variable "mysql_root_password" {
  description = "The MySQL root password."
  default     = "P4sSw0rd0!"
}

variable "mysql_network_name" {
  description = "The MySQL's network'."
  default     = "mysql_internal_network"
}

variable "mysql_volume_name" {
  description = "The MySQL's Volume'."
  default     = "mysql_data"
}

check_circle
Create the Image File
keyboard_arrow_up

Create image.tf:

vi image.tf

Add the docker_image resource and call it mysql_image, then set the name to mysql:5.7:

resource "docker_image" "mysql_image" {
name = "mysql:5.7"
}

check_circle
Create the Network File
keyboard_arrow_up

Create networks.tf:

vi networks.tf

networks.tf contents:

resource "docker_network" "private_bridge_network" {
  name     = "${var.mysql_network_name}"
  driver   = "bridge"
  internal = true
}

check_circle
Create the Volume File
keyboard_arrow_up

Create volumes.tf:

vi volumes.tf

with these contents:

resource "docker_volume" "mysql_data_volume" {
  name = "${var.mysql_volume_name}"
}

check_circle
Create the Main File
keyboard_arrow_up

Create main.tf:

vi main.tf

with these contents:

resource "docker_container" "mysql_container" {
  name  = "${var.container_name}"
  image = "${docker_image.mysql_image.name}"
  env   = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}"
  ]
  volumes {
    volume_name    = "${docker_volume.mysql_data_volume.name}"
    container_path = "/var/lib/mysql"
  }
  networks_advanced {
    name    = "${docker_network.private_bridge_network.name}"
  }
}

check_circle
Deploy the Infrastructure
keyboard_arrow_up

Initialize Terraform:

terraform init

Validate the files:

terraform validate

Generate a Terraform plan:

terraform plan -out=tfplan

Deploy the infrastructure using the plan file:

terraform apply tfplan


check is all is ok:

docker volume inspect mysql_data

sudo ls /var/lib/docker/volumes/mysql_data/_data

