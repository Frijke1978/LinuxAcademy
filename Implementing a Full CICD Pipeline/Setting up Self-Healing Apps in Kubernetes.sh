Instructions  4c5fcb16c8a87f8b9cc248a2bb0736aa5667490a
Your team has built a continuous delivery process for the train schedule app. They are using a Jenkins pipeline to deploy the app to a Kubernetes cluster. However, a few recent deployments have caused problems for the app. App containers are periodically entering an unhealthy state which causes the application to return http 500 errors to users.
The team has asked you to address this problem by implementing some behavior to allow Kubernetes to detect when a container has become unhealthy so that the container can be automatically restarted.
To do this, you will need to do the following:
Set up a Jenkins project for the app and deploy it to the Kubernetes cluster:
Fork the GitHub source code at https://github.com/linuxacademy/cicd-pipeline-train-schedule-selfhealing.
Set up credentials in Jenkins for GitHub, Docker Hub, and the Kubernetes cluster.
Create a project to build from your GitHub fork, run a build, and approve production deployment to deploy the app to the cluster.
Create and deploy a liveness probe to detect error responses from the app and restart unhealthy containers:
Modify the Kubernetes template in your GitHub fork to add a liveness probe.
Deploy the application again by running a build and approving the deployment.
Test the probe by breaking the app and watching Kubernetes automatically restart the container.
Note: The train-schedule app includes an endpoint designed to simulate the app becoming unhealthy so that you can trigger an instance of the app to break at will. Once deployed, if you access that endpoint in your browser at <Kubernetes Node Public IP>:8080/break, all future requests to that container will return 500 error codes until it is restarted. You can use this to test self-healing functionality once you have implemented it.
Objectives
help
Set up a Jenkins project for the app and deploy it to the Kubernetes cluster.
To do this, you will need to do the following:
Fork the GitHub source code at https://github.com/linuxacademy/cicd-pipeline-train-schedule-selfhealing.
Set up credentials in Jenkins for GitHub, Docker Hub, and the Kubernetes cluster.
Create a project to build from your GitHub fork, run a build, and approve production deployment to deploy the app to the cluster.
help
Create and deploy a liveness probe to detect error responses from the app and restart unhealthy containers.
To do this, you will need to do the following:
Modify the Kubernetes template in your GitHub fork to add a liveness probe.
livenessProbe:
httpGet:
  path: /
  port: 8080
initialDelaySeconds: 15
timeoutSeconds: 1
periodSeconds: 10
Check the example-solution branch of the GitHub repo for an example of how this code can be used: https://github.com/linuxacademy/cicd-pipeline-train-schedule-selfhealing/blob/example-solution/train-schedule-kube.yml.
Deploy the application again by running a build and approving the deployment.
Test the probe by breaking the app and watching Kubernetes automatically restart the container.