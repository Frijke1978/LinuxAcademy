Required Software Packages, Tools, and Files:

git
wget
which
words (need file at /usr/share/dict/words)
lsof
text editor of your choice
python 3.6.5


Installing Packages
The following commands are used on the cloud server to install the packages and files that we need. 
$ sudo su -
$ yum update
$ yum groupinstall -y "development tools"
$ yum install -y \
  lsof \
  wget \
  vim-enhanced \
  words \
  which
$ exit

Configuring Git
From our user account (instead of root), we'll configure git using our own information and these commands: 
$ git config --global user.name "Your Name"
$ git config --global user.email "your_email@example.com"

Customizing Bash
We'll customize our bash prompt by downloading a bashrc file from our content repository and placing it our $HOME directory. This command will download the file, rename it, and place it in the proper directory:
$ curl https://raw.githubusercontent.com/linuxacademy/content-python3-sysadmin/master/helpers/bashrc -o ~/.bashrc

Customizing Vim
Like we did with the bashrc, we'll customize Vim by downloading a vimrc file with this command: 
$ curl https://raw.githubusercontent.com/linuxacademy/content-python3-sysadmin/master/helpers/vimrc -o ~/.vimrc