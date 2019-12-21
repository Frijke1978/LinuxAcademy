1. Verify that your ansible installation is available by displaying the version of ansible while logged in as the 'user' user.
[test@tcox3 ~]$ ansible --version
ansible 1.9.2
  configured module search path = None
 
2. Run the ansible command that lists all of the hosts configured in your control server 'hosts' file for the system.
[test@tcox3 ~]$ ansible all --list-hosts
    tcox5.mylabserver.com
    localhost
    tcox4.mylabserver.com
 
3. Using the 'ansible' command line utility, execute a ONE LINE ansible command that does the following:
- Runs against the server/group chosen in Step #2
- Uses the 'test' user to run the command
- Executes the command with 'sudo' privileges
- Adds a root cron job with a name (you assign it) that runs a list of the /var directory on the system and logs to the root home directory in a file called 'var.log', every day of week/month at the same time
[test@tcox3 ~]$ ansible redhat -u test -s -m cron -a "name='crontest' minute='0' hour='12' job='ls -al /var > /root/var.log'"
 
 
4. Display the results and the resulting CRON entry
tcox4.mylabserver.com | success >> {
    "changed": true,
    "jobs": [
        "crontest"
    ]
}
 
localhost | success >> {
    "changed": true,
    "jobs": [
        "crontest"
    ]
}
 
tcox5.mylabserver.com | success >> {
    "changed": true,
    "jobs": [
        "crontest"
    ]
}
 
[test@tcox3 ~]$ sudo crontab -l
#Ansible: crontest
0 12 * * * ls -al /var > /root/var.log