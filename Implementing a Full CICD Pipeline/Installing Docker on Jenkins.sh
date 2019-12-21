In order to deploy a containerized app, Jenkins needs to be able to interact with Docker. This means that Docker needs to be installed locally on the Jenkins server, and the Jenkins user needs to be provided with the permissions necessary to use that Docker installation. This lesson demonstrates how to install Docker on a Jenkins server and configure the Jenkins user to be able to access it.

Here are the commands used in the demo for this lesson: 
sudo yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
sudo systemctl restart docker