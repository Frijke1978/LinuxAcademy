In order to use Kubernetes, you need to create a Kubernetes cluster. This lesson discusses how to do this and demonstrates setting up a simple cluster with one master and one node using kubeadm. After completing this lesson, you will be able to create a simple Kubernetes cluster that you can deploy applications to.

You can find instructions on various ways of installing Kubernetes here: https://kubernetes.io/docs/setup/

Installation instructions specific to kubeadm can he found here: https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

You can initialize the master node in kubeadm by creating a config file called kube-config.yml with these contents: 

apiVersion: kubeadm.k8s.io/v1alpha3
kind: ClusterConfiguration
networking:
  podSubnet: 10.244.0.0/16
apiServerExtraArgs:
  service-node-port-range: 8000-31274
Then run this command referencing that file: 
kubeadm init --config kube-config.yml

Use this command to set up a pod network after initializing the master with kubeadm init: 
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml