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
- Uses one of the modules for installing packages
- Install the package 'lynx' on the remote server(s)
[test@tcox3 roles]$ ansible apacheweb -u test -s -m yum -a "pkg=lynx state=latest"
 
 
4. Display the results.
tcox4.mylabserver.com | success >> {
    "changed": true,
    "msg": "",
    "rc": 0,
    "results": [
        "Loaded plugins: fastestmirror\nLoading mirror speeds from cached hostfile\n * base: mirror.symnds.com\n * extras: mirror.cogentco.com\n * updates: mirrors.advancedhosters.com\nResolving Dependencies\n--> Running transaction check\n---> Package lynx.x86_64 0:2.8.8-0.3.dev15.el7 will be installed\n--> Finished Dependency Resolution\n\nDependencies Resolved\n\n================================================================================\n Package       Arch            Version                      Repository     Size\n================================================================================\nInstalling:\n lynx          x86_64          2.8.8-0.3.dev15.el7          base          1.4 M\n\nTransaction Summary\n================================================================================\nInstall  1 Package\n\nTotal download size: 1.4 M\nInstalled size: 5.4 M\nDownloading packages:\nRunning transaction check\nRunning transaction test\nTransaction test succeeded\nRunning transaction\n  Installing : lynx-2.8.8-0.3.dev15.el7.x86_64                              1/1 \n  Verifying  : lynx-2.8.8-0.3.dev15.el7.x86_64                              1/1 \n\nInstalled:\n  lynx.x86_64 0:2.8.8-0.3.dev15.el7                                             \n\nComplete!\n"
    ]
}