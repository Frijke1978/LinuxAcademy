Instructions
https://github.com/YuconCorp/cicd-pipeline-train-schedule-docker

Your team is building the train-schedule app. They want to transition to using containers to run the app in production. But first they need the app to be built into a docker image. The team has asked you to write a Dockerfile for the train-schedule app, and verify that it can be used to build an image and run in a container.
Create a Dockerfile for the application:
Fork the sample source code on GitHub: https://github.com/linuxacademy/cicd-pipeline-train-schedule-docker.
Clone the fork to your home directory in the learning activity environment.
Create a Dockerfile and commit it.
Build a Docker image using the Dockerfile and run it:
Use docker build to build the docker image.
Use docker run to run a container using the image.
Verify that the app is running by accessing the train schedule app at http://<activity environment public ip>:8080.
Feel free to look at the example-solution branch of the git repo for an example of the source code changes needed for the solution.
Objectives
help
Create a Dockerfile for the application.
The first step in dockerizing the train-schedule app is to create a Dockerfile.
Fork the source code repository on GitHub: https://github.com/linuxacademy/cicd-pipeline-train-schedule-docker
You can clone the repo somewhere and create the Dockerfile yourself, just be sure you commit and push it to your fork. You can also simply create the file in GitHub itself using the create new file button when viewing the GitHub repo.
Here is a sample Dockerfile:
FROM node:carbon
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD [ "npm", "start" ]
Once you have a docker file, log in to the learning activity environment and clone your fork inside of the cloud_user home directory:
 cd /home/cloud_user
 git clone <GitHub url of your fork>
help
Build a Docker image using the Dockerfile and run it.
Get into your source code directory:
cd /home/cloud_user/cicd-pipeline-train-schedule-docker
Then, build a docker image using your Dockerfile:
sudo docker build -t /train-schedule .
Finally, run the app in a container using the image. Be sure to use port 8080:
sudo docker run -p 8080:8080 -d /train-schedule
Once the container is running, you should be able to access the train schediule app in a browser at: http://<your learning activity environment public IP>:8080