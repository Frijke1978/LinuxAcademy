 


In order to use Jenkins as part of a CI/CD solution, you must first know how to install it. This lesson will take you through the steps necessary in order to install Jenkins and prepare it for use in a CI process. It provides a demonstration of installing Jenkins on a CentOS environment using yum. After completing this lesson, you should be able to perform a Jenkins installation yourself.



Jenkins installation docs: https://jenkins.io/doc/book/installing/



Jenkins wiki on installing Jenkins in a CentOS environment: https://wiki.jenkins.io/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions



Here are the commands used to install Jenkins in the demonstration:

sudo yum -y remove java
sudo yum -y install java-1.8.0-openjdk
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum -y install jenkins-2.121.1
sudo systemctl enable jenkins
sudo systemctl start jenkins