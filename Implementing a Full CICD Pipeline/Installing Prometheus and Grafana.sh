The first step toward using Prometheus and Grafana to gather metrics within Kubernetes is to install them. This video walks you through the process of installing Prometheus and Grafana in your Kubernetes cluster. After completing this lesson, you will know how to quickly install Prometheus and Grafana using Helm.


Since there are quite a few commands involved in this installation, here is a reference guide for the commands used to perform the installation in this lesson:

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > /tmp/get_helm.sh
chmod 700 /tmp/get_helm.sh
DESIRED_VERSION=v2.8.2 /tmp/get_helm.sh
helm init --wait
kubectl --namespace=kube-system create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default
helm ls
cd ~/
git clone https://github.com/kubernetes/charts
cd charts
git checkout efdcffe0b6973111ec6e5e83136ea74cdbe6527d
cd ../
vi prometheus-values.yml
prometheus-values.yml:
alertmanager:
    persistentVolume:
        enabled: false
server:
    persistentVolume:
        enabled: false
Then run:
helm install -f prometheus-values.yml charts/stable/prometheus --name prometheus --namespace prometheus
vi grafana-values.yml
grafana-values.yml:
adminPassword: password
Then run:
helm install -f grafana-values.yml charts/stable/grafana/ --name grafana --namespace grafana
vi grafana-ext.yml
grafana-ext.yml:
kind: Service
apiVersion: v1
metadata:
  namespace: grafana
  name: grafana-ext
spec:
  type: NodePort
  selector:
    app: grafana
  ports:
  - protocol: TCP
    port: 3000
    nodePort: 8080
Then run:
kubectl apply -f grafana-ext.yml
You can check on the status of the prometheus and grafana pods with these commands:
kubectl get pods -n prometheus
kubectl get pods -n grafana
When setting up your dastasource in grafana, use this url:
http://prometheus-server.prometheus.svc.cluster.local