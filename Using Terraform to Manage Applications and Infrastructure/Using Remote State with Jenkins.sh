In this lesson, we will and update our CI/CD process to use remote state with our Jenkins Pipelines. This will allow us to create two separate Jenkins Pipelines: one for deploying the infrastructure and one for destroying it.
Create S3 Bucket
Search for S3 in Find Services.
Click Create Bucket.
Enter a Bucket name. The bucket name must be unique.
Make sure the Region is US East (N. Virginia) Click Next.
Click Next again on the Configure options page.
Click Next again on the Set permissions page.
Click Create bucket on the Review page. 
Add the Terraform Folder to the Bucket
Click on the bucket name.
Click Create folder.
Enter terraform-aws for the folder name.
Click Save.
Create the Jenkins Deploy Job
Enter an item name and call it DeployDockerService. Select Pipeline. Click Ok.
Click Add Parameter and select String Parameter. For the name enter access_key_id. Set the Default Value to your Access Key Id.
Click Add Parameter and select String Parameter. For the name enter secret_access_key. Set the Default Value to your Secret Access Key.
CClick Add Parameter and select String Parameter. For the name enter bucket_name. Set the Default Value to the name of your S3 Bucket.
Click Add Parameter and select Choice Parameter. For the name enter image_name. For choices enter ghost:latest and ghost:alpine. Make sure they are on separate lines.
Click Add Parameter and select String Parameter. For the name enter ghost_ext_port. Set the Default Value to 80.
In the Pipeline section add the following to Script:
env.AWS_ACCESS_KEY_ID = "${access_key_id}"
env.AWS_SECRET_ACCESS_KEY = "${secret_access_key}"
env.AWS_DEFAULT_REGION = 'us-east-1'

node {
  git (
    url: 'https://github.com/linuxacademy/content-terraform-docker-service.git',
    branch: 'remote-state'
  )
  stage('init') {
    sh label: 'terraform init', script: "terraform init -backend-config \"bucket=${bucket_name}\""
  }
  stage('plan') {
    sh label: 'terraform plan', script: "terraform plan -out=tfplan -input=false -var image_name=${image_name} -var ghost_ext_port=${ghost_ext_port}"
  }
  stage('apply') {
    sh label: 'terraform apply', script: "terraform apply -lock=false -input=false tfplan"
  }
}
Create the Jenkins Destroy Job
Enter an item name and call it DestroyDockerService.
In Copy from enter DeployDockerService. Click Ok.
Change Pipeline section to the following:
env.AWS_ACCESS_KEY_ID = "${access_key_id}"
env.AWS_SECRET_ACCESS_KEY = "${secret_access_key}"
env.AWS_DEFAULT_REGION = 'us-east-1'

node {
  git (
    url: 'https://github.com/linuxacademy/content-terraform-docker-service.git',
    branch: 'remote-state'
  )
  stage('init') {
    sh label: 'terraform init', script: "terraform init -backend-config \"bucket=${bucket_name}\""
  }
  stage('plan_destroy') {
    sh label: 'terraform plan', script: "terraform plan -destroy -out=tfdestroyplan -input=false -var image_name=${image_name} -var ghost_ext_port=${ghost_ext_port}"
  }
  stage('destroy') {
    sh label: 'terraform apply', script: "terraform apply -lock=false -input=false tfdestroyplan"
  }
}
Once Jenkins is running:
docker container ls
docker exec -it 73575a9ee4ac /bin/bash