In this lesson, we will start working with Jenkins by creating a simple build job. This job will deploy a Docker container using Terraform, list the container, and then destroy it.

In the Jenkins dashboard, Click New Item.
Select Freestyle Project, and enter an item name of DeployGhost. Click Ok.

Under Source Code Management, select Git. Enter a Repository URL of https://github.com/linuxacademy/content-terraform-docker.git

In the Build section, click Add build step and select Execute shell from the dropdown.

Add the following in the Command area:

terraform init
terraform plan -out=tfplan
terraform apply tfplan
docker container ls
terraform destroy -auto-approve

Click Save.

Now, if we click Build Now in the left-hand menu, our project will start building. Clicking the little dropdown arrow next to #1 will give us a menu. Select Console Output to watch things build. Once we get a Finished: SUCCESS message, we're done.