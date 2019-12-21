Instructions 600c5b6b899add064e954dbf856310a87caad303
Your team is transitioning from a traditional static deployment model to using containers. They hope to eventually implement container orchestration, but right now they want to take the step of running the train-schedule app in production as a Docker container. The team also wants to maintain an automated CI/CD process through this transition. A Dockerfile has already been created for the app which can be used to build Docker images for it, and a production server has been set up with Docker installed.
The team has asked you to modify the Jenkins Pipeline and configure Jenkins so that the Docker image can be built and deployed as part of the Jenkins CD Pipeline. You will need to do the following:
Configure Jenkins credentials for the production server.
Configure Jenkins credentials for the Docker image registry (Docker Hub).
Configure a global property in Jenkins to store the production server IP.
Create a multibranch pipeline project in Jenkins called train-schedule.
Configure the Jenkins project to pull from your fork of the source code.
Stages to the Jenkins Pipeline (Jenkinsfile) to do the following:
Build a Docker image with the code inside it.
Push the image to Docker Hub.
Deploy the new image to production: stop and remove any older containers, pull and run the newly built image.
You will need a Docker hub account in order to use Docker Hub as an image registry. You will need to enter your credentials into the lab environment Jenkins instance, so feel free to create a fresh Docker Hub account and cancel it after you are done.
You will need to create a personal fork of the source code here: https://github.com/linuxacademy/cicd-pipeline-train-schedule-dockerdeploy
Check out the Jenkinsfile on the example-solution branch for an example of how this pipeline can be implemented. If you use that code, however, be sure to change all references to the willbla/train-schedule Docker image name to a name that is unique to your Docker Hub account, such as <your Docker Hub username>/train-schedule.
Objectives
help
Configure Jenkins to run the new dockerized train-schedule pipeline.
To accomplish this, you will need to do the following setup in Jenkins:
Configure Jenkins credentials for the production server:
Create a Jenkins credential called webserver_login. For credentials, use deploy as a username and jenkins as a password.
Configure Jenkins credentials for the Docker image registry (Docker Hub).
Create a Jenkins credential called docker_hub_login. You will need a docker hub account in order to perform this step.
Configure a global property in Jenkins to store the production server IP.
Create a global property in Jenkins called prod_ip and set it to the Production Server Public IP that appears on the learning activity page once the servers are started up.
Create a multibranch pipeline project in Jenkins called train-schedule.
Configure the Jenkins project to pull from your fork of the source code.
Make a fork of the git repo at: https://github.com/linuxacademy/cicd-pipeline-train-schedule-dockerdeploy
help
Successfully deploy the train-schedule app to production as a Docker container using the Jenkins Pipeline.
Implement the following new stages in the Jenkinsfile:
Build Docker Image - Build a Docker image with the runnable code inside it.
Push Docker Image - Push the image to Docker Hub.
DeployToProduction - Deploy the new image to production:
stop and remove any older containers
pull and run the newly built image
After implementing these stages, run the build in Jenkins to deploy the application to production!