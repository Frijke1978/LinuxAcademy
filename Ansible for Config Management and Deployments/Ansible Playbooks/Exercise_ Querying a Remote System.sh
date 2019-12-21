1. On the control server, display the ansible version and status and issue an ansible command to list all configured hosts.
[test@tcox3 ~]$ ansible --version
ansible 1.9.2
  configured module search path = None
[test@tcox3 ~]$ ansible all --list-hosts
    tcox5.mylabserver.com
    localhost
    tcox4.mylabserver.com

2. Choosing ONE of the groups from the displayed list in Step #1 above, query that system for all the 'facts' that can be displayed, while filtering the content for the IP address information.
[test@tcox3 ~]$ ansible apacheweb -m setup -a 'filter=ans*ipv4*'
tcox4.mylabserver.com | success >> {
    "ansible_facts": {
        "ansible_all_ipv4_addresses": [
            "172.31.108.45"
        ],
        "ansible_default_ipv4": {
            "address": "172.31.108.45",
            "alias": "eth0",
            "gateway": "172.31.96.1",
            "interface": "eth0",
            "macaddress": "12:29:fb:d6:9a:af",
            "mtu": 9001,
            "netmask": "255.255.240.0",
            "network": "172.31.96.0",
            "type": "ether"
        }
    },
    "changed": false
}

3. Using the same group from Steps #1 and #2, issue a shell command through ansible that will determine if the 'lynx' package is already installed on that server.
[test@tcox3 ~]$ ansible apacheweb -m shell -a 'yum list installed | grep lynx'
tcox4.mylabserver.com | success | rc=0 >>
lynx.x86_64                           2.8.8-0.3.dev15.el7              @base

4. Using the same group, issue an ansible command (as sudo) that will display the last ten lines of output from the remote system's 'syslog' file.
[test@tcox3 ~]$ ansible apacheweb -m shell -a 'tail -n 10 /var/log/dmesg'
tcox4.mylabserver.com | success | rc=0 >>
[    3.577455] SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
[    3.621406] SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses transition SIDs
[    3.748973] systemd-udevd[504]: starting version 208
[    3.828536] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    3.839265] SELinux: initialized (dev nfsd, type nfsd), uses genfs_contexts
[    3.949670] piix4_smbus 0000:00:01.3: SMBus base address uninitialized - upgrade BIOS or use force_addr=0xaddr
[    4.082323] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    4.191443] type=1305 audit(1443204264.317:4): audit_pid=546 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
[    4.277258] ppdev: user-space parallel port driver
[    4.459507] Adding 2097148k swap on /root/swap.  Priority:-1 extents:2 across:3037200k SSFS
