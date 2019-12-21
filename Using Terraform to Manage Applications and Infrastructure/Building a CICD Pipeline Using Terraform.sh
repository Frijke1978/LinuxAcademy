Additional Information and Resources
Building a CI/CD Pipeline Using Terraform

Go to http://:8080 and complete the Jenkins setup. From the command line of the Jenkins server, run the following command to get the password:

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Install the default plugins.
Create a Jenkins user account.
Create a Pipeline to deploy for a Docker Service

Click New Item and select Pipeline.
Name the project MyDeployment.
Ensure that the project is parameterized.
Create two choice parameters: image_name and ghost_ext_port.
The choices for image_name should be set to ghost:latest and ghost:alpine.
The choices for ghost_ext_port should be set to 80 and 8081.
The Pipeline

The pipeline should clone the following Git repository:
https://github.com/linuxacademy/content-terraform-docker-service.git

Running the Terraform commands requires supplying the path to the binary: /usr/local/bin/terraform.
Create a three stage pipeline: init, plan, and apply.
For the init stage, use a shell script sh to initialize Terraform. Set the label to Initialize Terraform.

For the plan stage, use a shell script sh to generate a Terraform plan. Set the label to Plan Terraform.
The Terraform plan should do the following:

    Create a plan file called deploy_service to be used with the apply.
    Ensure that the plan is not prompted for inputs.
    Pass in the variables image_name and ghost_ext_port and set them to their corresponding parameters.

Using a script, create a timeout and input.
The timeout should be for 10 minutes.
The input should have an id of Deploy Gate, a message that states Deploy environment? and ok of Deploy.

For the apply stage, use a shell script sh to execute terraform apply.
Set the label to Deploy Infrastructure. The terraform apply should do the following:

    Set locking to false.
    Ensure that the apply is not prompted for inputs.
    Use the deploy_service plan file created during the plan stage.

Test the job

From MyDeployment click Build with Parameters.
Select ghost:alpine for the image_name and 8081 for ghost_ext_port.
Click the Build button. In the Build History click on the job number.
Then click on Console Output.
The job will be paused and you need to either click on Deploy or Abort.
Click Deploy so that the job can resume.
Visit: http://[LAB_IP]:8081 to see if Ghost blog pulls up.
Learning Objectives
check_circle
Setting Up Docker Swarm
keyboard_arrow_up

Complete the Swarm:

docker swarm join-token worker

On the worker node run the join command (pasting the join token in the appropriate spot):

docker swarm join --token [JOIN_TOKEN] [IP]:2377

check_circle
Create the Build Pipeline
keyboard_arrow_up

Pipeline:

node {
  git 'https://github.com/linuxacademy/content-terraform-docker-service.git'
  stage('init') {
    sh label: 'Initialize Terraform', script: "terraform init"
  }
  stage('plan') {
    sh label: 'Plan Terraform', script: "terraform plan -out=tfplan -input=false -var image_name=${image_name} -var ghost_ext_port=${ghost_ext_port}"
    script {
        timeout(time: 10, unit: 'MINUTES') {
          input(id: "Deploy Gate", message: "Deploy environment?", ok: 'Deploy')
        }
    }
  }
  stage('apply') {
    sh label: 'Deploy Infrastructure', script: "terraform apply -lock=false -input=false tfplan"
  }
}

check_circle
Deploy Ghost Blog
keyboard_arrow_up

From MyDeployment click Build with Parameters.
Select ghost:alpine for the image_name and 8081 for ghost_ext_port.
Click the Build button. Visit: http://[LAB_IP]:8081 to see if Ghost blog pulls up.
