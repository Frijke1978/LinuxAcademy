1. Verify that Ansible is running by displaying the version and module path. Change to the Ansible configuration directory and list the contents.
[root@tcox3 ~]# ansible --version
ansible 1.9.2
  configured module search path = None
[root@tcox3 ~]# cd /etc/ansible
[root@tcox3 ansible]# ll
total 20
-rw-r--r--. 1 root root 8629 Jun 25 21:11 ansible.cfg
-rw-r--r--. 1 root root   88 Sep 21 14:43 hosts
drwxr-xr-x. 2 root root    6 Jun 25 21:11 roles

2. Move the original Ansible Hosts file to another file in the same directory called 'hosts.original'. Create a new empty 'hosts' file in the default configuration directory location.
[root@tcox3 ansible]# mv hosts hosts.original && touch hosts && ll
total 20
-rw-r--r--. 1 root root 8629 Jun 25 21:11 ansible.cfg
-rw-r--r--. 1 root root   0 Sep 21 14:43 hosts
-rw-r--r--. 1 root root  965 Jun 25 21:11 hosts.original
drwxr-xr-x. 2 root root    6 Jun 25 21:11 roles

3. Create a section in the new 'hosts' file called 'local'. Make sure it contains:
  * Localhost
  * Localhost.Localdomain
  * 127.0.0.1
[root@tcox3 ansible]# vim hosts
[root@tcox3 ansible]# cat hosts
[local]
127.0.0.1
localhost
localhost.localdomain

4. Create a second section called 'web hosts' with the NAME of the second Linux Academy lab server in your environment (see previous lab for setting up the two host environment). Display the contents of the file.
[root@tcox3 ansible]# vim hosts
[root@tcox3 ansible]# cat hosts
[local]
127.0.0.1
localhost
localhost.localdomain

[web hosts]
tcox4.mylabserver.com
