Instructions 803ad4210c143cb9fbac5c6193f1213d556b15e1
Your team is building the train-schedule app. They have put a lot of work into laying out a robust CI/CD Pipeline for the app. This Pipeline requires a final, manual, approval step before production deployment. However, the team is confident in the automation that they have built, and they want to eliminate this step.
You have been asked to remove the manual approval step and implement a basic smoke test in its place. The pipeline already includes a canary deployment to a Kubernetes cluster, so this smoke test should simply query the canary service to verify that it responds correctly. If the code passes the smoke test, the pipeline should proceed with production deployment.
To do this, you will need to do the following tasks:
Prepare the Jenkins environment and verify your configuration with an initial deploy:
Fork the sample source code at: https://github.com/linuxacademy/cicd-pipeline-train-schedule-autodeploy
Change the DOCKER_IMAGE_NAME at the top of the Jenkinsfile to use your Docker Hub username instead of willbla.
Log in to Jenkins.
Add Jenkins credentials for GitHub, Docker Hub, and the Kubernetes cluster.
Set up automatic GitHub hook management in Jenkins.
Create a train-schedule project to build from your GitHub fork, and configure it to trigger automatically using a webhook.
Successfully run, approve, and deploy a build.
Add a smoke test with automated deployment and remove the human approval step from the pipeline, then deploy:
Create a Jenkins environment variable called KUBE_MASTER_IP and set it to the Kubernetes master public IP.
Add a smoke test to verify that the canary deployment is responsive.
Remove the human input step from the deployment.
Merge the code from the new-code branch into your master branch to initiate an automated deployment.
Objectives
help
Prepare the Jenkins environment and verify your configuration with an initial deploy.
To accomplish this, you will need to do the following steps:
Fork the sample source code at: https://github.com/linuxacademy/cicd-pipeline-train-schedule-autodeploy
Change the DOCKER_IMAGE_NAME at the top of the Jenkinsfile to use your Docker Hub username instead of willbla.
Log in to Jenkins.
Add Jenkins credentials for GitHub, Docker Hub, and the Kubernetes cluster.
Set up automatic GitHub hook management in Jenkins.
Create a train-schedule project to build from your GitHub fork, and configure it to trigger automatically using a webhook.
Successfully run, approve, and deploy a build.
help
Add a smoke test with automated deployment and remove the human approval step from the pipeline, then deploy.
Do these steps to complete this:
Create a Jenkins environment variable called KUBE_MASTER_IP and set it to the Kubernetes master public IP.
Add a smoke test to verify that the canary deployment is responsive.
Remove the human input step from the deployment.
Merge the code from the new-code branch into your master branch to initiate an automated deployment.