[ansible@frijke2c root]$ cat /etc/ansible/hosts
[local]
localhost

[RedHats7]
frijke3c.mylabserver.com


commands:

[ansible@frijke2c root]$ ansible all -m ping

[ansible@frijke2c root]$ ansible all -a "ls -al /home/ansible"

[ansible@frijke2c root]$ ansible all -s -a "cat /var/log/messages"

[ansible@frijke2c ansible]$ ansible RedHats7 -m copy -a "src=test dest=/tmp/test"

[ansible@frijke2c ansible]$ ansible RedHats7 -s -m yum -a "name=elinks state=latest"

[ansible@frijke2c ansible]$ ansible RedHats7 -s -m yum -a "name=elinks state=absent"

