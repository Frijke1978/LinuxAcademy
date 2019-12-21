Adding Error Exit Status to reverse-file
When our reverse-file script receives a file that doesn’t exist, we show an error message, but we don’t set the exit status to 1 to be indicative of an error.
$ reverse-file -l 2 fake.txt
Error: [Errno 2] No such file or directory: 'fake.txt'
~ $ echo $?
0
Let’s use the sys.exit function to accomplish this:
~/bin/reverse-file
#!/usr/bin/env python3.6

import argparse
import sys

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
    sys.exit(1)
else:
    with f:
        lines = f.readlines()
        lines.reverse()

        if limit:
            lines = lines[:limit]

        for line in lines:
            print(line.strip()[::-1])
Now, if we try our script with a missing file, we will exit with the proper code:
$ reverse-file -l 2 fake.txt
Error: [Errno 2] No such file or directory: 'fake.txt'
$ echo $?
1