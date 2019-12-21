Instructions 5d9f202829e3121d37b810fe17ce41505f8e2172
Your team has been working hard on their train-schedule application. However, some recent deployments introduced bugs that did not become visible until after the changes were in the hands of real users. To mitigate these kinds of issues, the team has asked you to implement a canary deployment as part of the larger deployment pipeline.
The application runs on Kubernetes cluster, and the team is using a Jenkins pipeline to perform CI and deployments. You will need to add logic to this existing pipeline in order to implement the canary deployment.
You will need to create a fork of the sample course code here: https://github.com/linuxacademy/cicd-pipeline-train-schedule-canary
Be sure to check out the example-solution branch for an example of the code changes needed to implement the canary deployment.
Setup the project and Jenkins and run an initial deployment:
Fork the sample source code repo.
Change the DOCKER_IMAGE_NAME at the top of the Jenkinsfile to use your docker hub username instead of willbla.
Log in to the Jenkins server.
Setup credentials in Jenkins.
Create a project and build it from your fork.
Add a canary stage to the pipeline and run a successful deployment:
Create a deployment template for the canary deployment with a "canary" track.
Add a canary stage to the Jenkinsfile to perform the canary deployment.
Modify the production deploy stage to clean up the canary deployment after production deployment is approved.
Execute the deploymemt in Jenkins.
Objectives
help
Setup the project and Jenkins and run an initial deployment.
To this, you will need to perform the following steps:
Fork the sample source code repo: https://github.com/linuxacademy/cicd-pipeline-train-schedule-canary.
Change the DOCKER_IMAGE_NAME at the top of the Jenkinsfile to use your docker hub username instead of willbla.
Log in to the Jenkins server.
Setup credentials in Jenkins (GitHub access token, Docker Hub, and Kubeconfig).
Create a project and build it from your fork.
help
Add a canary stage to the pipeline and run a successful deployment.
To complete this, you will need to do the following:
Create a deployment template for the canary deployment with a "canary" track.
Add a canary stage to the Jenkinsfile to perform the canary deployment.
Modify the production deploy stage to clean up the canary deployment after production deployment is approved.
Execute the deploymemt in Jenkins.
Don't hesitate to Refer to the example-solution branch of the sample source code repo for an example of how to do this!