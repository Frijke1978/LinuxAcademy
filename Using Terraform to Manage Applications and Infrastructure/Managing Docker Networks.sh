In this lesson we will build on our knowledge of Terraform and Docker by learning about the docker_network resource.
Set up the environment:
mkdir -p ~/terraform/docker/networks
cd terraform/docker/networks
Create the files:
touch {variables.tf,image.tf,network.tf,main.tf}
Edit variables.tf:
vi variables.tf
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
  description = "Public port for Ghost"
  default     = "8080"
}
Edit image.tf:
vi image.tf
image.tf contents:
resource "docker_image" "ghost_image" {
  name = "ghost:alpine"
}

resource "docker_image" "mysql_image" {
  name = "mysql:5.7"
}
Edit network.tf:
vi network.tf
network.tf contents:
resource "docker_network" "public_bridge_network" {
  name   = "public_ghost_network"
  driver = "bridge"
}

resource "docker_network" "private_bridge_network" {
  name     = "ghost_mysql_internal"
  driver   = "bridge"
  internal = true
}
Edit main.tf:
vi main.tf
main.tf contents:
resource "docker_container" "blog_container" {
  name  = "ghost_blog"
  image = "${docker_image.ghost_image.name}"
  env   = [
    "database__client=mysql",
    "database__connection__host=${var.mysql_network_alias}",
    "database__connection__user=${var.ghost_db_username}",
    "database__connection__password=${var.mysql_root_password}",
    "database__connection__database=${var.ghost_db_name}"
  ]
  ports {
    internal = "2368"
    external = "${var.ext_port}"
  }
  networks_advanced {
    name    = "${docker_network.public_bridge_network.name}"
    aliases = ["${var.ghost_network_alias}"]
  }
  networks_advanced {
    name    = "${docker_network.private_bridge_network.name}"
    aliases = ["${var.ghost_network_alias}"]
  }
}

resource "docker_container" "mysql_container" {
  name  = "ghost_database"
  image = "${docker_image.mysql_image.name}"
  env   = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}"
  ]
  networks_advanced {
    name    = "${docker_network.private_bridge_network.name}"
    aliases = ["${var.mysql_network_alias}"]
  }
}
Initialize Terraform:
terraform init
Validate the files:
terraform validate
Build a plan:
terraform plan -out=tfplan -var 'ext_port=8082'
Apply the plan:
terraform apply tfplan
Destroy the environment:
terraform destroy -auto-approve -var 'ext_port=8082'
Fixing main.tf
main.tf contents:
resource "docker_container" "mysql_container" {
  name  = "ghost_database"
  image = "${docker_image.mysql_image.name}"
  env   = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}"
  ]
  networks_advanced {
    name    = "${docker_network.private_bridge_network.name}"
    aliases = ["${var.mysql_network_alias}"]
  }
}

resource "null_resource" "sleep" {
  depends_on = ["docker_container.mysql_container"]
  provisioner "local-exec" {
    command = "sleep 15s"
  }
}

resource "docker_container" "blog_container" {
  name  = "ghost_blog"
  image = "${docker_image.ghost_image.name}"
  depends_on = ["null_resource.sleep", "docker_container.mysql_container"]
  env   = [
    "database__client=mysql",
    "database__connection__host=${var.mysql_network_alias}",
    "database__connection__user=${var.ghost_db_username}",
    "database__connection__password=${var.mysql_root_password}",
    "database__connection__database=${var.ghost_db_name}"
  ]
  ports {
    internal = "2368"
    external = "${var.ext_port}"
  }
  networks_advanced {
    name    = "${docker_network.public_bridge_network.name}"
    aliases = ["${var.ghost_network_alias}"]
  }
  networks_advanced {
    name    = "${docker_network.private_bridge_network.name}"
    aliases = ["${var.ghost_network_alias}"]
  }
}
Build a plan:
terraform plan -out=tfplan -var 'ext_port=8082'
Apply the plan:
terraform apply tfplan