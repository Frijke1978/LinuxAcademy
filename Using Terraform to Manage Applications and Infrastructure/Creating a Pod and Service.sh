In this lesson, we will create a pod and service using Terraform.
Setup your environment:
mkdir -p ~/terraform/service
cd ~/terraform/service
Create main.tf:
vi main.tf
main.tf contents:
resource "kubernetes_service" "ghost_service" {
  metadata {
    name = "ghost-service"
  }
  spec {
    selector {
      app = "${kubernetes_pod.ghost_alpine.metadata.0.labels.app}"
    }
    port {
      port = "2368"
      target_port = "2368"
      node_port = "8081"
    }
    type = "NodePort"
  }
}

resource "kubernetes_pod" "ghost_alpine" {
  metadata {
    name = "ghost-alpine"
    labels {
      app = "ghost-blog"
    }
  }

  spec {
    container {
      image = "ghost:alpine"
      name  = "ghost-alpine"
      port  {
        container_port = "2368"
      }
    }
  }
}
Initialize Terraform:
terraform init
Validate the files:
terraform validate
Plan the deployment:
terraform plan
Deploy the pod:
terraform apply -auto-approve
List the Pods:
kubectl get pods
List the Services:
kubectl get services
Reset the environment:
terraform destroy -auto-approve