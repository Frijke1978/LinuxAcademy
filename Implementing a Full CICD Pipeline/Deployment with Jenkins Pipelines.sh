



00:15




21:51
1.75x

In order to succeed with continuous delivery and continuous deployment, deployment automation is essential. In this lesson, we will be implementing automated deployments within a Jenkins pipeline. We will create pipeline stages to automatically deploy to a staging server and a production server. After completing this lesson, you will have some familiarity with how automated deployment can be implementing using Jenkins Pipelines.

Check out the pipeline steps reference for the Publish Over SSH plugin used in the demo: https://jenkins.io/doc/pipeline/steps/publish-over-ssh/

Here is the sample source code used in the demo. Check the example-solution branch for the complete Jenkinsfile: https://github.com/linuxacademy/cicd-pipeline-train-schedule-cd

In order to set up automated deployment, you need to prepare the production and staging servers by: 
Creating a deploy user with the necessary permissions to deploy
Configuring the train-schedule app as a systemd service
Here is an example of how you can accomplish this: 

adduser deploy
echo "deploy:jenkins" | chpasswd
groupadd train-schedule
usermod -a -G train-schedule deploy
echo "deploy ALL=(ALL) NOPASSWD: /usr/bin/systemctl stop train-schedule" >> /etc/sudoers
echo "deploy ALL=(ALL) NOPASSWD: /usr/bin/systemctl start train-schedule" >> /etc/sudoers
echo -e "[Unit]\\nDescription=Train Schedule\\nAfter=network.target\\n\\n[Service]\\n\\nType=simple\\nWorkingDirectory=/opt/train-schedule\\nExecStart=/usr/bin/node bin/www\\nStandardOutput=syslog\\nStandardError=syslog\\nRestart=on-failure\\n\\n[Install]\\nWantedBy=multi-user.target" > /etc/systemd/system/train-schedule.service
/usr/bin/systemctl daemon-reload
mkdir -p /opt/train-schedule
chown root:train-schedule /opt/train-schedule
chmod 775 /opt/train-schedule/
yum -y install nodejs unzip