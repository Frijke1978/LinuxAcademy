1. Display the current version and status of the Ansible application.
[test@tcox3 ~]$ ansible --version
ansible 1.9.2
  configured module search path = None

2. Using the appropriate module, from your control server, list all the hosts configured in your environment. Using ansible, run a ping command against all hosts in the environment.
[test@tcox3 ~]$ ansible all --list-hosts
    tcox5.mylabserver.com
    localhost
    tcox4.mylabserver.com
[test@tcox3 ~]$ ansible all -m ping
localhost | success >> {
    "changed": false,
    "ping": "pong"
}

tcox5.mylabserver.com | success >> {
    "changed": false,
    "ping": "pong"
}

tcox4.mylabserver.com | success >> {
    "changed": false,
    "ping": "pong"
}

3. List the contents of your ansible 'hosts' file. Using only ONE of the groups in the file, attempt to install the 'lynx' package on that server.
[test@tcox3 ~]$ cat /etc/ansible/hosts
[local]
localhost

[apacheweb]
tcox4.mylabserver.com

[appserver]
tcox5.mylabserver.com

[test@tcox3 ~]$ ansible apacheweb -s -m shell -a 'yum -y install lynx'
tcox4.mylabserver.com | success | rc=0 >>
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: distro.ibiblio.org
 * epel: mirror.symnds.com
 * extras: mirror.cogentco.com
 * updates: mirror.cogentco.com
Package lynx-2.8.8-0.3.dev15.el7.x86_64 already installed and latest version
Nothing to do

4. Using the same group as Step #3, attempt to install the 'telnet' package on that server using the more 'playbook friendly' module and syntax.
[test@tcox3 ~]$ ansible apacheweb -s -m yum -a 'pkg=telnet state=installed update_cache=true'
tcox4.mylabserver.com | success >> {
    "changed": false,
    "msg": "",
    "rc": 0,
    "results": [
        "telnet-0.17-59.el7.x86_64 providing telnet is already installed"
    ]
}
