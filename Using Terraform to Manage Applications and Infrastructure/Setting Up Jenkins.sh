In this lesson, we will take the Jenkins image we built in the previous lesson, and deploy a Docker container using Terraform.

Edit main.tf:

vi main.tf

main.tf contents:

# Jenkins Volume
resource "docker_volume" "jenkins_volume" {
  name = "jenkins_data"
}

# Start the Jenkins Container
resource "docker_container" "jenkins_container" {
  name  = "jenkins"
  image = "jenkins:terraform"
  ports {
    internal = "8080"
    external = "8080"
  }

  volumes {
    volume_name    = "${docker_volume.jenkins_volume.name}"
    container_path = "/var/jenkins_home"
  }

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }
}

Initialize Terraform:

terraform init

Plan the deployment:

terraform plan -out=tfplan

Deploy Jenkins:

terraform apply tfplan

Get the Admin password:

docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
