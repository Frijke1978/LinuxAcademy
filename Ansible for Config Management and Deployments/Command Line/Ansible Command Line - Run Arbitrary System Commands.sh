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
- Displays the contents of each server(s) remote /etc/fstab file locally using ONLY the command line (no module)
[test@tcox3 ~]$ ansible all -u test -a "cat /etc/fstab"
 
 
4. Display the results.
localhost | success | rc=0 >>
 
#
# /etc/fstab
# Created by anaconda on Mon Sep 29 21:48:54 2014
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
UUID=0f790447-ebef-4ca0-b229-d0aa1985d57f /                       xfs     defaults        1 1
/root/swap swap swap sw 0 0
 
tcox4.mylabserver.com | success | rc=0 >>
 
#
# /etc/fstab
# Created by anaconda on Mon Sep 29 21:48:54 2014
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
UUID=0f790447-ebef-4ca0-b229-d0aa1985d57f /                       xfs     defaults        1 1
/root/swap swap swap sw 0 0
 
tcox5.mylabserver.com | success | rc=0 >>
 
#
# /etc/fstab
# Created by anaconda on Mon Sep 29 21:48:54 2014
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
UUID=0f790447-ebef-4ca0-b229-d0aa1985d57f /                       xfs     defaults        1 1
/root/swap swap swap sw 0 0
/dev/xvdf1 /mnt/data ext3 rw 0 0
 
tcox1.mylabserver.com | success | rc=0 >>
LABEL=cloudimg-rootfs   /        ext4   defaults,discard        0 0