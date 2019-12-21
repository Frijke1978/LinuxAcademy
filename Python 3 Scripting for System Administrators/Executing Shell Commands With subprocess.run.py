Executing Shell Commands With subprocess.run
For working with external processes, we’re going to experiment with the subprocess module from the REPL. The main function that we’re going to work with is the subprocess.run function, and it provides us with a lot of flexibility:
>>> import subprocess
>>> proc = subprocess.run(['ls', '-l'])
total 20
drwxrwxr-x. 2 user user  54 Jan 28 15:36 bin
drwxr-xr-x. 2 user user   6 Jan  7  2015 Desktop
-rw-rw-r--. 1 user user  44 Jan 26 22:16 new_xmen.txt
-rw-rw-r--. 1 user user  98 Jan 26 21:39 read_file.py
-rw-rw-r--. 1 user user 431 Aug  6  2015 VNCHOWTO
-rw-rw-r--. 1 user user  61 Jan 28 14:11 xmen_base.txt
-rw-------. 1 user user  68 Mar 18  2016 xrdp-chansrv.log
>>> proc
CompletedProcess(args=['ls', '-l'], returncode=0)
Our proc variable is a CompletedProcess object, and this provides us with a lot of flexibility. We have access to the returncode attribute on our proc variable to ensure that it succeeded and returned a 0 to us. Notice that the ls command was executed and printed to the screen without us specifying to print anything. We can get around this by capturing STDOUT using a subprocess.PIPE.
>>> proc = subprocess.run(
...     ['ls', '-l'],
...     stdout=subprocess.PIPE,
...     stderr=subprocess.PIPE,
... )
>>> proc
CompletedProcess(args=['ls', '-l'], returncode=0, stdout=b'total 20\ndrwxrwxr-x. 2 user user  54 Jan 28 15:36 bin\ndrwxr-xr-x. 2 user user   6 Jan  7  2015 Desktop\n-rw-rw-r--. 1 user user  44 Jan 26 22:16 new_xmen.txt\n-rw-rw-r--. 1 user user  98 Jan 26 21:39 read_file.py\n-rw-rw-r--. 1 user user 431 Aug  6  2015 VNCHOWTO\n-rw-rw-r--. 1 user user  61 Jan 28 14:11 xmen_base.txt\n-rw-------. 1 user user  68 Mar 18  2016 xrdp-chansrv.log\n', stderr=b'')
>>> proc.stdout
b'total 20\ndrwxrwxr-x. 2 user user  54 Jan 28 15:36 bin\ndrwxr-xr-x. 2 user user   6 Jan  7  2015 Desktop\n-rw-rw-r--. 1 user user  44 Jan 26 22:16 new_xmen.txt\n-rw-rw-r--. 1 user user  98 Jan 26 21:39 read_file.py\n-rw-rw-r--. 1 user user 431 Aug  6  2015 VNCHOWTO\n-rw-rw-r--. 1 user user  61 Jan 28 14:11 xmen_base.txt\n-rw-------. 1 user user  68 Mar 18  2016 xrdp-chansrv.log\n'
Now that we’ve captured the output to attributes on our proc variable, we can work with it from within our script and determine whether or not it should ever be printed. Take a look at this string that is prefixed with a b character. It is because it is a bytes object and not a string. The bytes type can only contain ASCII characters and won’t do anything special with escape sequences when printed. If we want to utilize this value as a string, we need to explicitly convert it using the bytes.decode method.
>>> print(proc.stdout)
b'total 20\ndrwxrwxr-x. 2 user user  54 Jan 28 15:36 bin\ndrwxr-xr-x. 2 user user   6 Jan  7  2015 Desktop\n-rw-rw-r--. 1 user user  44 Jan 26 22:16 new_xmen.txt\n-rw-rw-r--. 1 user user  98 Jan 26 21:39 read_file.py\n-rw-rw-r--. 1 user user 431 Aug  6  2015 VNCHOWTO\n-rw-rw-r--. 1 user user  61 Jan 28 14:11 xmen_base.txt\n-rw-------. 1 user user  68 Mar 18  2016 xrdp-chansrv.log\n'
>>> print(proc.stdout.decode())
total 20
drwxrwxr-x. 2 user user  54 Jan 28 15:36 bin
drwxr-xr-x. 2 user user   6 Jan  7  2015 Desktop
-rw-rw-r--. 1 user user  44 Jan 26 22:16 new_xmen.txt
-rw-rw-r--. 1 user user  98 Jan 26 21:39 read_file.py
-rw-rw-r--. 1 user user 431 Aug  6  2015 VNCHOWTO
-rw-rw-r--. 1 user user  61 Jan 28 14:11 xmen_base.txt
-rw-------. 1 user user  68 Mar 18  2016 xrdp-chansrv.log

>>>
Intentionally Raising Errors
The subprocess.run function will not raise an error by default if you execute something that returns a non-zero exit status. Here’s an example of this:
>>> new_proc = subprocess.run(['cat', 'fake.txt'])
cat: fake.txt: No such file or directory
>>> new_proc
CompletedProcess(args=['cat', 'fake.txt'], returncode=1)
In this situation, we might want to raise an error, and if we pass the check argument to the function, it will raise a subprocess.CalledProcessError if something goes wrong:
>>> error_proc = subprocess.run(['cat', 'fake.txt'], check=True)
cat: fake.txt: No such file or directory
Traceback (most recent call last):
  File "", line 1, in 
  File "/usr/local/lib/python3.6/subprocess.py", line 418, in run
    output=stdout, stderr=stderr)
subprocess.CalledProcessError: Command '['cat', 'fake.txt']' returned non-zero exit status 1.
>>>
Python 2 Compatible Functions
If you’re interested in writing code with the subprocess module that will still work with Python 2, then you cannot use the subprocess.run function because it’s only in Python 3. For this situation, you’ll want to look into using subprocess.call and subprocess.check_output.