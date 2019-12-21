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
- Uses the 'service' module, start the HTTPD service installed during an earlier exercise
[test@tcox3 roles]$ ansible apacheweb -u test -s -m service -a "name=httpd state=started"
 
 
4. Display the results.
tcox4.mylabserver.com | success >> {
    "changed": true,
    "name": "httpd",
    "state": "started"
}
 