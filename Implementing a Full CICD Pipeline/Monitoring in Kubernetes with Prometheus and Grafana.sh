Instructions
Your team is building the train schedule app. They currently have it running on a Kubernetes cluster, but they need to monitor the performance of the cluster and the applications running on it. You have been tasked with installing and setting up Prometheus to aggregate data and Grafana to display this data. Both can be installed on the Kubernetes cluster itself. To make sure everything is working, you will need to create two dashboards in Grafana:
Import the Kubernetes All Nodes community dashboard to display basic metrics about the Kubernetes cluster.
Create a new Dashboard and add a graph showing requests per minute for the train-schedule app.
To accomplish this, you will need to:
Initialize helm with: helm init --wait
Clone the Kubernetes standard charts git repo and checkout a specific commit: 
git clone https://github.com/kubernetes/charts
cd charts
git checkout efdcffe0b6973111ec6e5e83136ea74cdbe6527d
cd ../
Create a prometheus-values.yml for prometheus to turn off persistent storage:
alertmanager:
  persistentVolume:
    enabled: false
server:
  persistentVolume:
    enabled: false
Use helm to install prometheus in the prometheus namespace:
helm install -f ~/prometheus-values.yml ~/charts/stable/prometheus --name prometheus --namespace prometheus
Create a grafana-values.yml for grafana to set an admin password:
adminPassword: password
Use helm to install grafana in the grafana namespace:
helm install -f ~/grafana-values.yml ~/charts/stable/grafana --name grafana --namespace grafana
Deploy a NodePort service to provide external access to grafana. Make a file called grafana-ext.yml:
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
    nodePort: 8081
And deploy the service:
kubectl apply -f ~/grafana-ext.yml
Log in to grafana at <Kubernetes Node Public IP>:8081.
Add a datasource for prometheus. The type should be set to Prometheus and the url is http://prometheus-server.prometheus.svc.cluster.local.
Add the Kubernetes All Nodes community dashboard with id 3131.
Create a new dashboard and add a requests per minute graph for the train-schedule app. You can use the following query:
sum(rate(http_request_duration_ms_count[2m])) by (service, route, method, code)  * 60
Objectives
help
Install Prometheus in the Kubernetes cluster.
To do this, make sure you have cloned the Kubernetes charts repo:
cd ~/
git clone https://github.com/kubernetes/charts
cd charts
git checkout efdcffe0b6973111ec6e5e83136ea74cdbe6527d
cd ../
Create a prometheus-values.yml with this content:
  alertmanager:
    persistentVolume:
      enabled: false
  server:
    persistentVolume:
      enabled: false
Use helm to install Prometheus with prometheus-values.yml:
helm install -f ~/prometheus-values.yml ~/charts/stable/prometheus --name prometheus --namespace prometheus
help
Install Grafana in the Kubernetes cluster.
To do this, make sure you have cloned the kubernetes charts repo:
cd ~/
git clone https://github.com/kubernetes/charts
Create a grafana-values.yml with this content (you will use this password to log in to Grafana):
adminPassword: somePassword
Use helm to install Grafana with grafana-values.yml:
helm install -f ~/grafana-values.yml ~/charts/stable/grafana --name grafana --namespace grafana