In this lesson, we will walk through the configuration of our workstation in order to get it up and running for our Terraform Docker deployments.
pwd

NOTE: The Cloud Playground has changed. Create an Ubuntu 16.04 server and connect using the details provided in the new Cloud Playground. After connecting, change to root with a: sudo -i

https://support.linuxacademy.com/hc/en-us/articles/360018147031-Create-a-New-Cloud-Playground-Server

https://support.linuxacademy.com/hc/en-us/articles/360019096651-Cloud-Playground-FAQ

AFTER you have set up your server, skip to 2:31 in the video.
To install Terraform 0.11.5:

sudo curl -O https://releases.hashicorp.com/terraform/0.11.5/terraform_0.11.5_linux_amd64.zip
sudo apt-get install unzip
sudo mkdir /bin/terraform 
sudo unzip terraform_0.11.5_linux_amd64.zip -d /usr/local/bin/

To install Docker CE:

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \ apt-transport-https
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce=18.06.1~ce~3-0~ubuntu