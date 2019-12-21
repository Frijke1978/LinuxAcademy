In this lesson, we will complete working with Jenkins by creating a pipeline that will create a MySQL Swarm service that uses Docker Secrets.

In the Jenkins dashboard, click New Item Enter an item name of PipelinePart3, and select Pipeline. Click Ok.

Check the box for This project is parameterized. Click Add Parameter and select Choice Parameter. Give it a Name of action. For Choices, enter Deploy and Destroy, and make sure they are on separate lines. Enter The action that will be executed as the Description.

Click Add Parameter and select String Parameter. This time, name it mysql_root_password. Enter P4ssW0rd0! as a Default Value box, making sure they are on separate lines. Enter MySQL root password. as a Description.

Click Add Parameter and select String Parameter. This time, name it mysql_user_password. Enter paSsw0rd0!

Down in the Pipeline section, give a Definition of Pipeline script, and add the following to the Script:

node {
  git 'https://github.com/linuxacademy/content-terraform-docker-secrets.git'
  if(action == 'Deploy') {
    stage('init') {
      sh label: 'terraform init', script: "terraform init"
    }
    stage('plan') {
      def ROOT_PASSWORD = sh (returnStdout: true, script: """echo ${mysql_root_password} | base64""").trim()
      def USER_PASSWORD = sh (returnStdout: true, script: """echo ${mysql_user_password} | base64""").trim()
      sh label: 'terraform plan', script: "terraform plan -out=tfplan -input=false -var mysql_root_password=${ROOT_PASSWORD} -var mysql_db_password=${USER_PASSWORD}"
      script {
          timeout(time: 10, unit: 'MINUTES') {
              input(id: "Deploy Gate", message: "Deploy ${params.project_name}?", ok: 'Deploy')
          }
      }
    }
    stage('apply') {
      sh label: 'terraform apply', script: "terraform apply -lock=false -input=false tfplan"
    }
  }

  if(action == 'Destroy') {
    stage('plan_destroy') {
      def ROOT_PASSWORD = sh (returnStdout: true, script: """echo ${mysql_root_password} | base64""").trim()
      def USER_PASSWORD = sh (returnStdout: true, script: """echo ${mysql_user_password} | base64""").trim()
      sh label: 'terraform plan', script: "terraform plan -destroy -out=tfdestroyplan -input=false -var mysql_root_password=${ROOT_PASSWORD} -var mysql_db_password=${USER_PASSWORD}"
    }
    stage('destroy') {
      script {
          timeout(time: 10, unit: 'MINUTES') {
              input(id: "Destroy Gate", message: "Destroy ${params.project_name}?", ok: 'Destroy')
          }
      }
      sh label: 'terraform apply', script: "terraform apply -lock=false -input=false tfdestroyplan"
    }
    stage('cleanup') {
      sh label: 'cleanup', script: "rm -rf terraform.tfstat"
    }
  }
}
