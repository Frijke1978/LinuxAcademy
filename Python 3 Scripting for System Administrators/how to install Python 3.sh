Learn how to install Python 3 from source on a CentOS 7 machine.
Download and Install Python 3 from Source
Here are the commands that we’ll run to build and install Python 3:
$ sudo su -
[root] $ yum groupinstall -y "development tools"
[root] $ yum install -y \
  libffi-devel \
  zlib-devel \
  bzip2-devel \
  openssl-devel \
  ncurses-devel \
  sqlite-devel \
  readline-devel \
  tk-devel \
  gdbm-devel \
  db4-devel \
  libpcap-devel \
  xz-devel \
  expat-devel

[root ] $ cd /usr/src
[root ] $ wget http://python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
[root ] $ tar xf Python-3.6.4.tar.xz
[root ] $ cd Python-3.6.4
[root ] $ ./configure --enable-optimizations
[root ] $ make altinstall
[root ] $ exit
Important: make altinstall causes it to not replace the built in python executable.
Ensure that secure_path in /etc/sudoers file includes /usr/local/bin. The line should look something like this:
Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin
Upgrade Pip (Might not be Necessary)
The version of pip that we have might be up-to-date, but it’s good practice to try to update it after the installation. We need to use the pip3.6 executable because we’re working with Python 3, and we use sudo so that we can write files under the /usr/local directory.
$ sudo pip3.6 install --upgrade pip