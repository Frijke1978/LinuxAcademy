Instructions
In this exercise, the team has asked you to configure a Jenkins project to build the train-schedule app. The source code for the application is hosted in the GitHub repository at https://github.com/linuxacademy/cicd-pipeline-train-schedule-jenkins. The app already has build automation set up using gradle wrapper, and can be built with ./gradlew build. The team wants Jenkins to execute this automated build every time changes are pushed to the GitHub repo.
You will need to:
Configure Jenkins to authenticate with GitHub
Create a freestyle project in Jenkins
Configure the project to build the train schedule app
Set up a webhook to trigger the build whenever changes are made to the repo in GitHub
Configure the build to archive trainSchedule.zip as a build artifact
Objectives
help
Create a new Jenkins freestyle project called train-schedule.
In Jenkins, click on New Item. For the item name, type train-schedule, and select freestyle project. Then click the OK button.
help
Trigger a successful train-schedule build with a change in GitHub.
Once the train-schedule project is fully configured, make a change to the source code in your fork in GitHub. This should trigger a successful build of the train-schedule project.