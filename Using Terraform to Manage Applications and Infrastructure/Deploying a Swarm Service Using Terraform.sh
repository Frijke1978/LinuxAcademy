Finish Docker Swarm

Complete the setup of the Docker swarm by getting the worker token:

docker swarm join-token worker

Create the Terraform files on the Swarm Manager

Create the following files: variables.tf, images.tf, network.tf, volumes.tf and main.tf.
variables.tf

In variables.tf create the following variables:

    mysql_root_password
        Give it a default value of P4sSw0rd0! with a description of The MySQL root password.
    ghost_db_username
        Give it a default value of root with a description of Ghost blog database username.
    ghost_db_name
        This will have a default value of ghost with a description of Ghost blog database name.
    mysql_network_alias
        Set this with a default value of db and a description of The network alias for MySQL.
    ghost_network_alias
        Give this a default value of ghost with a description of The network alias for Ghost.
    ext_port
        Set this default value to 80, and give it a description of The public port for Ghost.

images.tf

In images.tf create two docker image resources. The first resources will be called ghost_image and the name will be set to ghost:alpine.
The second resource will be called mysql_image and the name will be set to mysql:5.7.
networks.tf

In networks.tf, create two overlay docker networks resources:

    public_overlay_network will be name of public_network.
    private_overlay_network will be name of mysql_internal.

volumes.tf

In volumes.tf create a single docker volume resources called mysql_data_volume. The volume will be named mysql_data.
main.tf

In main.tf create two docker service resource called ghost-service and mysql-service.
ghost-service resource

The service will be called ghost.
Create a task_spec that will contain a container_spec and a endpoint_spec.

    The container_spec will be responsible for creating a container. The image will use the ghost image coming from ghost_image resource using the name attribute. Create the following environment variables:
        database__client set to mysql
        database__connection__host set to the mysql_network_alias variable
        database__connection__user set to the ghost_db_username variable
        database__connection__user set to the mysql_root_password variable
        database__connection__database set to the ghost_db_name variable
        The container will be connected to bothpublic_network and mysql_internal
    The endpoint_spec will have a target_port of 2368, and set published_port to use the ext_port variable.

mysql-service resource

The service name will use the mysql_network_alias variable.
Create a task_spec that will contain a container_spec.
The container_spec will be responsible for creating a container. The image will use the ghost image, which will be coming from the mysql_image resource using the name attribute.

Create the environment variable MYSQL_ROOT_PASSWORD and set to be the mysql_root_password variable.
Create a mount that will be the volume type.
The target on the container will be set to /var/lib/mysql. Use mysql_data for the source.
The container will be attached to the mysql_internal network.
Deploy the infrastructure

Initialize Terraform.
Generate a Terraform plan and output a plan file.
Deploy the infrastructure using the plan file.
Learning Objectives
check_circle
Complete the Setup of Docker Swarm
keyboard_arrow_up

On the manager node get the join token:

docker swarm join-token worker

On the worker node run the join command:

docker swarm join --token [JOIN_TOKEN] [IP]:2377

check_circle
Create the `variables.tf` File
keyboard_arrow_up

Create variable.tf:

vi variable.tf

variables.tf contents:

variable "mysql_root_password" {
  description = "The MySQL root password."
  default     = "P4sSw0rd0!"
}

variable "ghost_db_username" {
  description = "Ghost blog database username."
  default     = "root"
}

variable "ghost_db_name" {
  description = "Ghost blog database name."
  default     = "ghost"
}

variable "mysql_network_alias" {
  description = "The network alias for MySQL."
  default     = "db"
}

variable "ghost_network_alias" {
  description = "The network alias for Ghost"
  default     = "ghost"
}

variable "ext_port" {
  description = "The public port for Ghost"
  default     = "80"
}

check_circle
Create the `images.tf` File
keyboard_arrow_up

Create image.tf:

vi images.tf

images.tf contents:

resource "docker_image" "ghost_image" {
  name = "ghost:alpine"
}

resource "docker_image" "mysql_image" {
  name = "mysql:5.7"
}

check_circle
Create the `network.tf` File
keyboard_arrow_up

Create network.tf:

vi network.tf

network.tf contents:

resource "docker_network" "public_overlay_network" {
  name   = "public_network"
  driver = "overlay"
}

resource "docker_network" "private_overlay_network" {
  name     = "mysql_internal"
  driver   = "overlay"
  internal = true
}

check_circle
Create the `volume.tf` File
keyboard_arrow_up

Create volume.tf:

vi volume.tf

volume.tf contents:

resource "docker_volume" "mysql_data_volume" {
  name = "mysql_data"
}

check_circle
Create the `main.tf` File
keyboard_arrow_up

Create main.tf:

vi main.tf

main.tf contents:

resource "docker_service" "ghost-service" {
  name = "ghost"

  task_spec {
    container_spec {
      image = "${docker_image.ghost_image.name}"

      env {
         database__client               = "mysql"
         database__connection__host     = "${var.mysql_network_alias}"
         database__connection__user     = "${var.ghost_db_username}"
         database__connection__password = "${var.mysql_root_password}"
         database__connection__database = "${var.ghost_db_name}"
      }
    }
    networks = ["${docker_network.public_overlay_network.name}", "${docker_network.private_overlay_network.name}"]
  }

  endpoint_spec {
    ports {
      target_port    = "2368"
      published_port = "${var.ext_port}"
    }
  }
}

resource "docker_service" "mysql-service" {
  name = "${var.mysql_network_alias}"

  task_spec {
    container_spec {
      image = "${docker_image.mysql_image.name}"

      env {
        MYSQL_ROOT_PASSWORD = "${var.mysql_root_password}"
      }

      mounts = [
        {
          target = "/var/lib/mysql"
          source = "${docker_volume.mysql_data_volume.name}"
          type   = "volume"
        }
      ]
    }
    networks = ["${docker_network.private_overlay_network.name}"]
  }
}

check_circle
Deploy the Infrastructure
keyboard_arrow_up

Initialize Terraform:

terraform init

Validate the files:

terraform validate

Build a plan:

terraform plan -out=tfplan -var 'ext_port=8080'

Apply the plan:

terraform apply tfplan