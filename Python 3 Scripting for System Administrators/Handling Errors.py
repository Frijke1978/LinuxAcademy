Handling Errors with try/except/else/finally
In our reverse-file script, what happens if the filename doesn’t exist? Let’s give it a shot:
$ reverse-file fake.txt
Traceback (most recent call last):
  File "/home/user/bin/reverse-file", line 11, in 
    with open(args.filename) as f:
FileNotFoundError: [Errno 2] No such file or directory: 'fake.txt'
This FileNotFoundError is something that we can expect to happen quite often and our script should handle this situation. Our parser isn’t going to catch this because we’re technically using the CLI properly, so we need to handle this ourselves. To handle these errors we’re going to utilize the keywords try, except, and else.
~/bin/reverse-file
#!/usr/bin/env python3.6
import argparse

parser = argparse.ArgumentParser(description='Read a file in reverse')
parser.add_argument('filename', help='the file to read')
parser.add_argument('--limit', '-l', type=int, help='the number of lines to read')
parser.add_argument('--version', '-v', action='version', version='%(prog)s verison 1.0')

args = parser.parse_args()

try:
    f = open(args.filename)
    limit = args.limit
except FileNotFoundError as err:
    print(f"Error: {err}")
else:
    with f:
        lines = f.readlines()
        lines.reverse()

        if limit:
            lines = lines[:limit]

        for line in lines:
            print(line.strip()[::-1])
We utilize the try statement to denote that it’s quite possible for an error to happen within it. From there we can handle specific types of errors using the except keyword (we can have more than one). In the event that there isn’t an error, then we want to carry out the code that is in the else block. If we want to execute some code regardless of there being an error or not, we can put that in a finally block at the very end of our t, except for workflow.
Now when we try our script with a fake file, we get a much better response:
$ reverse-file fake.txt
Error: [Errno 2] No such file or directory: 'fake.txt'