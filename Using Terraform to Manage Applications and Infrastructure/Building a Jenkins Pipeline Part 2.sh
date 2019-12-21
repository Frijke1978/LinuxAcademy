In this lesson, we will create a Jenkins Pipeline to deploy out a Swarm service.

In the Jenkins dashboard, click New Item Enter an item name of PipelinePart2, and select Pipeline. Click Ok.

Check the box for This project is parameterized. Click Add Parameter and select Choice Parameter. Give it a Name of action. For Choices, enter Deploy and Destroy, and make sure they are on separate lines. Enter The action that will be executed as the Description.

Click Add Parameter and select Choice Parameter again. This time, name it image_name. Enter ghost:latest and ghost:alpine in the Choices box, making sure they are on separate lines. Enter The image Ghost Blog will deploy as a Description.

Click Add Parameter a third time, and select String Parameter. Give it a Name of ghost_ext_port. Set the Default Value to 80. Enter The Public Port as the Description.

Down in the Pipeline section, give a Definition of Pipeline script, and add the following to the Script:

node {
  git 'https://github.com/linuxacademy/content-terraform-docker-service.git'
  if(action == 'Deploy') {
    stage('init') {
      sh label: 'terraform init', script: "terraform init"
    }
    stage('plan') {
      sh label: 'terraform plan', script: "terraform plan -out=tfplan -input=false -var image_name=${image_name} -var ghost_ext_port=${ghost_ext_port}"
      script {
          timeout(time: 10, unit: 'MINUTES') {
            input(id: "Deploy Gate", message: "Deploy environment?", ok: 'Deploy')
          }
      }
    }
    stage('apply') {
      sh label: 'terraform apply', script: "terraform apply -lock=false -input=false tfplan"
    }
  }

  if(action == 'Destroy') {
    stage('plan_destroy') {
      sh label: 'terraform plan', script: "terraform plan -destroy -out=tfdestroyplan -input=false -var image_name=${image_name} -var ghost_ext_port=${ghost_ext_port}"
    }
    stage('destroy') {
      script {
          timeout(time: 10, unit: 'MINUTES') {
              input(id: "Destroy Gate", message: "Destroy environment?", ok: 'Destroy')
          }
      }
      sh label: 'terraform apply', script: "terraform apply -lock=false -input=false tfdestroyplan"
    }
    stage('cleanup') {
      sh label: 'cleanup', script: "rm -rf terraform.tfstat"
    }
  }
}