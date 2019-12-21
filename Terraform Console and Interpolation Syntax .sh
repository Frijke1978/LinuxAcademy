Additional Information and Resources

Ensure you are in the US-East-1 region.
Learning Objectives
check_circle
Download the GitHub Repository
keyboard_arrow_up

We've got to grab all of the scripts that need attention, and they're sitting up in a GitHub repository:

git clone https://github.com/linuxacademy/content-terraform

check_circle
Install Terraform
keyboard_arrow_up

Within content-terraform are several other directories. One, install-scripts, contains scripts that will install various things. Let's get in there and run the script that installs Terraform:

cd install-scripts
./terraform.sh

check_circle
Edit main.tf
keyboard_arrow_up

In the command line, get into the same directory as our main.tf file:

cd ../labs/console-and-syntax

Comment out everything below the brace after the name = "ghost:latest" line.
check_circle
Initialize and Apply Terraform, Then Add Interpolation Syntax
keyboard_arrow_up

Down in the command line, we need to both initialize and apply Terraform with these commands:

terraform init
terraform apply

Edit main.tf so that the imgae line (in our currently commented out section) reads:

  image = "${docker_image.image_id.latest}"

Then uncomment the whole section, and run the terraform commands again (init and apply) like we did before the edits.
check_circle
Change the Port and View the Live Blog
keyboard_arrow_up

Edit main.tf one more time, changing the external port from 80 to 8080, then run terraform apply again.

Up near the top of the screen, there's a Preview menu. Click on that, then select Preview Running Application. We're going to see, in the lower-right section of the screen, a preview of our Ghost blog.

To see it in an actual web browser though, fire another tab up. Navigate (in the AWS web console) and find the IP address of our EC2 instance. In our new browser tab, head over to http://[IP_ADDRESS]:8080/ and we should see that Ghost blog there.
