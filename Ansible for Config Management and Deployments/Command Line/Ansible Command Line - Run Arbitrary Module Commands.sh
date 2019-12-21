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
- Uses one of the modules for executing shell commands
- List all the files in the remote system(s) /var directory
    [test@tcox3 Outline]$ ansible apacheweb -u test -s -m command -a "ls -al /var"
4. Display the results.
tcox4.mylabserver.com | success | rc=0 >>
total 16
drwxr-xr-x. 20 root root 4096 Nov  2 23:57 .
drwxr-xr-x. 17 root root 4096 Aug  6 19:28 ..
drwxr-xr-x.  2 root root    6 Jun 10  2014 adm
drwxr-xr-x.  9 root root   91 Nov  2 23:57 cache
drwxr-xr-x.  2 root root    6 May 12 20:18 crash
drwxr-xr-x.  3 root root   32 Aug  6 19:40 db
drwxr-xr-x.  3 root root   17 Sep 29  2014 empty
drwxr-xr-x.  2 root root    6 Jun 10  2014 games
drwxr-xr-x.  2 root root    6 Jun 10  2014 gopher
drwxr-xr-x.  3 root root   17 Sep 15 13:33 kerberos
drwxr-xr-x. 42 root root 4096 Nov  2 23:57 lib
drwxr-xr-x.  2 root root    6 Jun 10  2014 local
lrwxrwxrwx.  1 root root   11 Sep 29  2014 lock -> ../run/lock
drwxr-xr-x. 12 root root 4096 Nov  2 23:20 log
lrwxrwxrwx.  1 root root   10 Sep 29  2014 mail -> spool/mail
drwxr-xr-x.  2 root root    6 Jun 10  2014 nis
drwxr-xr-x.  2 root root    6 Jun 10  2014 opt
drwxr-xr-x.  2 root root    6 Jun 10  2014 preserve
lrwxrwxrwx.  1 root root    6 Sep 29  2014 run -> ../run
drwxr-xr-x. 10 root root  102 Oct  6 22:47 spool
drwxrwxrwt.  4 root root   64 Nov  2 23:57 tmp
drwxr-xr-x.  3 root root   16 Sep 29  2014 var
drwxr-xr-x.  2 root root    6 Jun 10  2014 yp