1. While logged into your control server, create a directory called 'Playbooks' and create an empty file in it called 'deploy_DATE.yml'. Replace DATE with today's date.
[test@tcox3 ~]$ mkdir Playbooks
[test@tcox3 ~]$ cd Playbooks
[test@tcox3 ~]$ touch deploy_09242015.yml

2. Edit the 'deploy_DATE.yml' file and create a structure that will run the following against ONE of the groups in your host configuration:
  - Using the package installation module, install lynx package
  - Using the package installation module, determine if the telnet package is installed
CONTENT SHOULD LOOK SOMETHING LIKE:
- hosts: appserver
  tasks:
  - name: Install Lynx on App Servers
    yum: pkg=lynx state=installed update_cache=true
  - name: Querying for Telnet Install
    yum: pkg=telnet state=present update_cache=true

3. Run the playbook and display the results.
[test@tcox3 Playbooks]$ ansible-playbook -s deploy_09242015.yml

PLAY [appserver] **************************************************************

GATHERING FACTS ***************************************************************
ok: [tcox5.mylabserver.com]

TASK: [Install Lynx on App Servers] *******************************************
ok: [tcox5.mylabserver.com]

TASK: [Querying for Telnet Install] *******************************************
ok: [tcox5.mylabserver.com]

PLAY RECAP ********************************************************************
tcox5.mylabserver.com      : ok=3    changed=0    unreachable=0    failed=0

4. Edit the playbook in Step #2 and create a new section for a DIFFERENT group in your host configuration as follows:
  - Using the package installation module, install the telnet package
  - Using the package installation module, determine if the lynx package is installed
FULL FILE SHOULD NOW LOOK SOMETHING LIKE:
- hosts: appserver
  tasks:
  - name: Install Lynx on App Servers
    yum: pkg=lynx state=installed update_cache=true
  - name: Querying for Telnet Install
    yum: pkg=telnet state=present update_cache=true

- hosts: apacheweb
  tasks:
  - name: Install Lynx on Web Servers
    yum: pkg=telnet state=installed update_cache=true
  - name: Querying for Lynx Install
    yum: pkg=lynx state=present update_cache=true

5. Run the full playbook and display the results.
[test@tcox3 Playbooks]$ ansible-playbook -s deploy_09242015.yml

PLAY [appserver] **************************************************************

GATHERING FACTS ***************************************************************
ok: [tcox5.mylabserver.com]

TASK: [Install Lynx on App Servers] *******************************************
ok: [tcox5.mylabserver.com]

TASK: [Querying for Telnet Install] *******************************************
ok: [tcox5.mylabserver.com]

PLAY [apacheweb] **************************************************************

GATHERING FACTS ***************************************************************
ok: [tcox4.mylabserver.com]

TASK: [Install Lynx on Web Servers] *******************************************
ok: [tcox4.mylabserver.com]

TASK: [Querying for Lynx Install] *********************************************
ok: [tcox4.mylabserver.com]

PLAY RECAP ********************************************************************
tcox4.mylabserver.com      : ok=3    changed=0    unreachable=0    failed=0
tcox5.mylabserver.com      : ok=3    changed=0    unreachable=0    failed=0

6. Tail the last lines of the ansible log file and compare to the results in Step #5.
[test@tcox3 Playbooks]$ tail /var/log/ansible.log
2015-09-25 18:25:43,538 p=1682 u=test |
2015-09-25 18:25:43,569 p=1682 u=test |  PLAY [appserver] **************************************************************
2015-09-25 18:25:43,569 p=1682 u=test |  GATHERING FACTS ***************************************************************
2015-09-25 18:25:43,782 p=1682 u=test |  ok: [tcox5.mylabserver.com]
2015-09-25 18:25:43,783 p=1682 u=test |  TASK: [Install Lynx on App Servers] *******************************************
2015-09-25 18:25:47,166 p=1682 u=test |  ok: [tcox5.mylabserver.com]
2015-09-25 18:25:47,166 p=1682 u=test |  TASK: [Querying for Telnet Install] *******************************************
2015-09-25 18:25:51,595 p=1682 u=test |  ok: [tcox5.mylabserver.com]
2015-09-25 18:25:51,596 p=1682 u=test |  PLAY RECAP ********************************************************************
2015-09-25 18:25:51,596 p=1682 u=test |  tcox5.mylabserver.com      : ok=3    changed=0    unreachable=0    failed=0
