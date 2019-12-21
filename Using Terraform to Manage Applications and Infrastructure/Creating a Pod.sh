In this video, we will start working with Kubernetes resources by creating a Pod. 
Setup your environment:
mkdir -p ~/terraform/pod
cd ~/terraform/pod
vi main.tf:
resource "kubernetes_pod" "ghost_alpine" {
  metadata {
    name = "ghost-alpine"
  }

  spec {
    host_network = "true"
    container {
      image = "ghost:alpine"
      name  = "ghost-alpine"
    }
  }
}
Initialize Terraform:
terraform init
Validate main.tf:
terraform validate
Plan the deployment:
terraform plan
Deploy the pod:
terraform apply -auto-approve
List the Pods:
kubectl get pods
Reset the environment:
terraform destroy -auto-approve