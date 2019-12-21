Instructions
In this scenario, developers have created the first prototype of the train-schedule app. They need you to create a Gradle build for it. The developers need this build to execute some automated tests that they have written. If the automated tests pass, the build needs to produce a packaged archive that includes the application code and its dependencies. The archive should be located in the project folder as dist/trainSchedule.zip.
In short, this automation needs to:
Have a build task that can be called to execute the entire build process
Execute some automated tests (the build should fail if any of the tests fail)
Package the code and its dependencies into a zip archive called dist/trainSchedule.zip
Prerequisites:
A GitHub.com account
In order to accomplish this, you will need to:
Configure git for ssh authentication with GitHub.com
Create a personal fork of the sample repository https://github.com/linuxacademy/cicd-pipeline-train-schedule-gradle
Clone your personal fork from GitHub
Initialize the project with gradle
Create a gradle build task
Include the com.moowork.node plugin in the gradle project
Execute automated tests as part of the build with the npm_test task
Create a task to generate a zip archive (dist/trainSchedule.zip) of the files that need to be deployed to production
Make sure task dependencies are set up so tasks execute in the correct order
Commit and push these changes to your GitHub fork
Some useful links:
Gradle wrapper documentation: https://docs.gradle.org/current/userguide/gradle_wrapper.html
Objectives
help
Your personal fork of the git repository is cloned to the cloud server
You need to clone your personal fork of the sample git repository to the cloud server. Make sure you perform the clone from your home directory.
You can do so like this:
 cd ~/
 git clone git@github.com:<your username>/cicd-pipeline-train-schedule-gradle.git
help
You initialized the project as a gradle project
Once you have cloned the git repo to your home directory, cd into the repo directory and then initialize the gradle build.
 cd ~/cicd-pipeline-train-schedule-gradle
 ./gradlew init
help
Your gradle build generates a zip archive of the application in `dist/trainSchedule.zip`
The gradle build should generate an archive of the application in dist/trainSchedule.zip.
You can do this by adding a task to create this archive to build.gradle and ensuring the build task depends on it.
task zip(type: Zip) {
    from ('.') {
        include "*"
        include "bin/**"
        include "data/**"
        include "node_modules/**"
        include "public/**"
        include "routes/**"
        include "views/**"
    }
    destinationDir(file("dist"))
    baseName "trainSchedule"
}

build.dependsOn zip
zip.dependsOn npm_build
Then, execute the gradle build to generate the archive:
./gradlew build