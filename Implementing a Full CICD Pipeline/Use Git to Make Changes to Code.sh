Instructions
In this exercise, you are one of a team of developers. Your team uses feature branches to manage changes. You have been asked to make a change to the train-schedule app. Instead of the app's main page header reading "Train Schedule," the customer wants it to read “Find your train!” This text can be found in the project file views/index.jade, and you're going to have to change it.
Prerequisites:
A GitHub.com account
In order to push a change to the code, you will need to:
Install git
Configure git for ssh authentication with GitHub.com
Create a personal fork of the sample repository https://github.com/linuxacademy/cicd-pipeline-train-schedule-git
Clone your personal fork from GitHub
Create a feature branch to contain the change
Change the header text in views/index.jade from “Train Schedule” to “Find your train!”
Add the change in views/index.jade to the next commit
Commit the change
Push the change to the remote scm repository
Create a pull request to merge the feature branch into the master branch
Merge the pull request
Some useful links:
Full git documentation - https://git-scm.com/docs
Installation instructions for any system - https://git-scm.com/downloads
Setting up an ssh key on your system - https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
Adding an ssh key to your GitHub.com account - https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/
Objectives
help
Get Git installed successfully
Git has to be installed successfully on the cloud server.
You can install git like this:
 sudo yum -y install git
help
Get your personal fork of the git repository cloned to the cloud server
You need to clone your personal fork of the sample git repository to the cloud server. Make sure you are in your home directory when performing the clone.
You can do so like this:
 cd ~/
 git clone git@github.com:<your username>/cicd-pipeline-train-schedule-git.git
help
Push your commit to a new remote branch
Create a new branch, make a change in that branch, commit it, and push it to your personal fork on GitHub.com.
You can do this like so:
 git checkout -b myBranch
 <make changes to source files>
 git add .
 git commit -m "<commit message>"
 git push -u origin mybranch