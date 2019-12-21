Installation and Configuration

controlserver;
as root:

yum install epel-release

yum update

yum install git python python-devel python-pip openssl ansible

ansible --version


vim /etc/ansible/ansible.cfg
 uncomment inventory and sudo_user = root
 
mv /etc/ansible/hosts /etc/ansible/hosts.original

vim /etc/ansible/hosts

[local]
localhost

[RedHats7]
frijke3c.mylabserver.com
frijke4c.mylabserver.com

adduser ansible
passwd ansible

visudo 
(underneath root)
ansible ALL=(ALL)    NOPASSWD: ALL


on (all) the other nodes:

adduser ansible
passwd ansible

visudo 
(underneath root)
ansible ALL=(ALL)    NOPASSWD: ALL


su ansible -
ssh-keygen
( all defaults )

from management node:
ssh-copy-id ansible@frijke3c.mylabserver.com
test: ssh frijke3c.mylabserver.com

yum install epel-release

yum update

repeat on all other nodes

also to ourselfes
ssh-copy-id localhost


