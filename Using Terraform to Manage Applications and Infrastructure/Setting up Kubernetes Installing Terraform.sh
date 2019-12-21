In this lesson we will setup a Kuberentes master and install Terraform.
Add the following to kube-config.yml:
apiVersion: kubeadm.k8s.io/v1beta1
kind: ClusterConfiguration
kubernetesVersion: "v1.13.5"
networking:
  podSubnet: 10.244.0.0/16
apiServer:
  extraArgs:
    service-node-port-range: 8000-31274
Initialize Kubernetes:
sudo kubeadm init --config kube-config.yml
Copy adimin.conf to your home directory:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
Install Flannel:
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
Untaint the Kubernetes Master:
kubectl taint nodes --all node-role.kubernetes.io/master-
Install Terraform
Terraform will be installed on the Swarm manager.
Install Terraform 0.11.13:
sudo curl -O https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
sudo unzip terraform_0.11.13_linux_amd64.zip -d /usr/local/bin/
Test the Terraform installation:
terraform version