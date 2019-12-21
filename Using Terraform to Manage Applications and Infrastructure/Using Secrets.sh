In this lesson, we'll explore using Terraform to store sensitive data, by using Docker Secrets.

Setup the environment:

mkdir secrets
cd secrets

Encode the password with Base64:

echo 'p4sSWoRd0!' | base64

Create variables.tf:

vi variables.tf

variables.tf contents:

variable "mysql_root_password" {
  default     = "cDRzU1dvUmQwIQo="
}

variable "mysql_db_password" {
  default     = "cDRzU1dvUmQwIQo="
}

Create image.tf:

vi image.tf

image.tf contents:

resource "docker_image" "mysql_image" {
  name = "mysql:5.7"
}

Create secrets.tf:

vi secrets.tf

secrets.tf contents:

resource "docker_secret" "mysql_root_password" {
  name = "root_password"
  data = "${var.mysql_root_password}"
}

resource "docker_secret" "mysql_db_password" {
  name = "db_password"
  data = "${var.mysql_db_password}"
}

Create networks.tf:

vi networks.tf

networks.tf contents:

resource "docker_network" "private_overlay_network" {
  name     = "mysql_internal"
  driver   = "overlay"
  internal = true
}

Create volumes.tf:

vi volumes.tf

volumes.tf contents:

resource "docker_volume" "mysql_data_volume" {
  name = "mysql_data"
}

Create main.tf:

vi main.tf

main.tf contents:

resource "docker_service" "mysql-service" {
  name = "mysql_db"

  task_spec {
    container_spec {
      image = "${docker_image.mysql_image.name}"

      secrets = [
        {
          secret_id   = "${docker_secret.mysql_root_password.id}"
          secret_name = "${docker_secret.mysql_root_password.name}"
          file_name   = "/run/secrets/${docker_secret.mysql_root_password.name}"
        },
        {
          secret_id   = "${docker_secret.mysql_db_password.id}"
          secret_name = "${docker_secret.mysql_db_password.name}"
          file_name   = "/run/secrets/${docker_secret.mysql_db_password.name}"
        }
      ]

      env {
        MYSQL_ROOT_PASSWORD_FILE = "/run/secrets/${docker_secret.mysql_root_password.name}"
        MYSQL_DATABASE           = "mydb"
        MYSQL_PASSWORD_FILE      = "/run/secrets/${docker_secret.mysql_db_password.name}"
      }

      mounts = [
        {
          target = "/var/lib/mysql"
          source = "${docker_volume.mysql_data_volume.name}"
          type   = "volume"
        }
      ]
    }
    networks = [
      "${docker_network.private_overlay_network.name}"
    ]
  }
}

Initialize Terraform:

terraform init

Validate the files:

terraform validate

Build a plan:

terraform plan -out=tfplan

Apply the plan:

terraform apply tfplan

Find the MySQL container:

docker container ls

Use the exec command to log into the MySQL container:

docker container exec -it [CONTAINER_ID] /bin/bash

Access MySQL:

mysql -u root -p

Destroy the environment:

terraform destroy -auto-approve
