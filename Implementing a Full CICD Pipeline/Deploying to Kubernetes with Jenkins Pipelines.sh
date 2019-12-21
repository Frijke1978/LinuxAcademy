Instructions   515a6b2b429f7b24d279290b2e73a291f6fe49a7
Your team is working on building out a CI/CD pipeline for their train schedule application. The app has already been Dockerized, and has a Jenkinsfile which is able to build a Docker image of the app and push it to Docker Hub. The team is now ready to begin implementing orchestration with Kubernetes. A basic Kubernetes cluster has already been set up.
You have been asked to implement automated deployment to the Kubernetes cluster in the Jenkins pipeline.
Set up the train-schedule project in Jenkins and successfully build it:
Fork the GitHub repo at: https://github.com/linuxacademy/cicd-pipeline-train-schedule-kubernetes.
Add GitHub Credentials in Jenkins.
Add Docker Hub Credentials in Jenkins.
Add the Kubeconfig from the Kubernetes master as a credential in Jenkins.
Create a Jenkins project called train-schedule and successfully run the build from your GitHub fork.
Successfully deploy the train-schedule app to the Kubernetes cluster via the Jenkins pipeline:
Create a Kubernetes template file defining a Service and Deployment for the app.
Add a stage to the Jenkinsfile to perform the deployment to the Kubernetes cluster.
Run the build and successfully deploy the app to the cluster.
Verify everything is working by accessing the app in your browser at http://<Kubernetes node IP>:8080.
Note: You will need both a Docker Hub account and a GitHub account to complete this activity.
If you are unsure how to proceed, feel free to check out the Solution video as well as the example-solution branch of the GitHub repo.
Objectives
help
Set up the train-schedule project in Jenkins and successfully build it.
Fork the GitHub repo at: https://github.com/linuxacademy/cicd-pipeline-train-schedule-kubernetes.
Add GitHub Credentials in Jenkins.
Add Docker Hub Credentials in Jenkins.
Add the Kubeconfig from the Kubernetes master as a credential in Jenkins. You can find the kubeconfig file on the Kubernetes master at /home/cloud_user/.kube/config.
Create a Jenkins project called train-schedule and successfully run the build from your GitHub fork.
help
Successfully deploy the train-schedule app to the Kubernetes cluster via the Jenkins pipeline.
Create a Kubernetes template file defining a Service and Deployment for the app. Here is an example: https://github.com/linuxacademy/cicd-pipeline-train-schedule-kubernetes/blob/example-solution/train-schedule-kube.yml
Add a stage to the Jenkinsfile to perform the deployment to the Kubernetes cluster. Check out an example here: https://github.com/linuxacademy/cicd-pipeline-train-schedule-kubernetes/blob/example-solution/Jenkinsfile
Run the build and successfully deploy the app to the cluster.
Verify everything is working by accessing the app in your browser at http://<Kubernetes node IP>:8080.