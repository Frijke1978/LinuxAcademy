Building a CLI to Reverse Files
The tool that we’re going to build in this video will need to do the following:
Require a filename argument, so it knows what file to read.
Print the contents of the file backward (bottom of the script first, each line printed backward)
Provide help text and documentation when it receives the --help flag.
Accept an optional --limit or -l flag to specify how many lines to read from the file.
Accept a --version flag to print out the current version of the tool.
This sounds like quite a bit, but thankfully the argparse module will make doing most of this trivial. We’ll build this script up gradually as we learn what the argparse.ArgumentParser can do. Let’s start by building an ArgumentParser with our required argument:
~/bin/reverse-file
#!/usr/bin/env python3.6

import argparse

parser = argparse.ArgumentParser()
parser.add_argument('filename', help='the file to read')
args = parser.parse_args()
print(args)
Here we've created an instance of ArgumentParser without any arguments. Next, we'll use the add_argument method to specify a positional argument called filename and provide some help text using the help argument. Finally, we tell the parser to parse the arguments from stdin using the parse_args method and stored off the parsed arguments as the variable args.
Let’s make our script executable and try this out without any arguments:
$ chmod u+x ~/bin/reverse-file
$ reverse-file
usage: reverse-file [-h] filename
reverse-file: error: the following arguments are required: filename
Since filename is required and wasn’t given the ArgumentParser object recognized the problem and returned a useful error message. That’s awesome! We can also see that it looks like it takes the -h flag already, let’s try that now:
$ reverse-file -h
usage: reverse-file [-h] filename

positional arguments:
  filename    the file to read

optional arguments:
  -h, --help  show this help message and exit
It looks like we’ve already handled our requirement to provide help text. The last thing we need to test out is what happens when we do provide a parameter for filename:
$ reverse-file testing.txt
Namespace(filename='testing.txt')
We can see here that args in our script is a Namespace object. This is a simple type of object that’s sole purpose is to hold onto named pieces of information from our ArgumentParser as attributes. The only attribute that we've asked it to hold onto is the filename attribute, and we can see that it set the value to 'testing.txt' since that’s what we passed in. To access these values in our code, we will chain off of our args object with a period:
>>> args.filename
'testing.txt'
Adding Optional parameters
We’ve already handled two of the five requirements we set for this script; let’s continue by adding the optional flags to our parser and then we’ll finish by implementing the real script logic. We need to add a --limit flag with a -l alias.
~/bin/reverse-file
#!/usr/bin/env python3.6
import argparse

parser = argparse.ArgumentParser(description='Read a file in reverse')
parser.add_argument('filename', help='the file to read')
parser.add_argument('--limit', '-l', type=int, help='the number of lines to read')

args = parser.parse_args()
print(args)
To specify that an argument is a flag, we need to place two hyphens at the beginning of the flag’s name. We’ve used the type option for add_argument to state that we want the value converted to an integer, and we specified a shorter version of the flag as our second argument.
Here is what args now looks like:
$ reverse-file --limit 5 testing.txt
Namespace(filename='testing.txt', limit=5)
Next, we’ll add a --version flag. This one will be a little different because we’re going to use the action option to specify a string to print out when this flag is received:
~/bin/reverse-file
#!/usr/bin/env python3.6
import argparse

parser = argparse.ArgumentParser(description='Read a file in reverse')
parser.add_argument('filename', help='the file to read')
parser.add_argument('--limit', '-l', type=int, help='the number of lines to read')
parser.add_argument('--version', '-v', action='version', version='%(prog)s 1.0')

args = parser.parse_args()
print(args)
This uses a built-in action type of version which we’ve found in the documentation.
Here’s what we get when we test out the --version flag:
$ reverse-file --version
reverse-file 1.0
Note: Notice that it carried out the version action and didn’t continue going through the script.


Adding Our Business Logic
We finally get a chance to use our file IO knowledge in a script:
~/bin/reverse-file
#!/usr/bin/env python3.6
import argparse

parser = argparse.ArgumentParser(description='Read a file in reverse')
parser.add_argument('filename', help='the file to read')
parser.add_argument('--limit', '-l', type=int, help='the number of lines to read')
parser.add_argument('--version', '-v', action='version', version='%(prog)s 1.0')

args = parser.parse_args()

with open(args.filename) as f:
    lines = f.readlines()
    lines.reverse()

    if args.limit:
        lines = lines[:args.limit]

    for line in lines:
        print(line.strip()[::-1])
Here’s what we get when we test this out on the xmen_base.txt file from our working with files video:
$ reverse-file xmen_base.txt
gnihtemoS
reivaX rosseforP
relwarcthgiN
pohsiB
spolcyC
enirevloW
mrotS
~ $ reverse-file -l 2 xmen_base.txt
gnihtemoS
reivaX rosseforP