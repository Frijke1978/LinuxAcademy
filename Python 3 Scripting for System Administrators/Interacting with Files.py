Interacting with Files
It’s pretty common to need to read the contents of a file in a script and Python makes that pretty easy for us. Before we get started, let’s create a text file that we can read from called xmen_base.txt:
~/xmen_base.txt
Storm
Wolverine
Cyclops
Bishop
Nightcrawler
Now that we have a file to work with, let’s experiment from the REPL before writing scripts that utilize files.
Opening and Reading a File
Before we can read a file, we need to open a connection to the file. Let’s open the xmen_base.txt file to see what a file object can do:
>>> xmen_file = open('xmen_base.txt', 'r')
>>> xmen_file
<_io.TextIOWrapper name='xmen_base.txt' mode='r' encoding='UTF-8'>
The open function allows us to connect to our file by specifying the path and the mode. We can see that our xmen_file object is an _io.TextIOWrapper so we can look at the documentation to see what we can do with that type of object.
There is a read function so let’s try to use that:
>>> xmen_file.read()
'Storm\nWolverine\nCyclops\nBishop\nNightcrawler\n'
>>> xmen_file.read()
''
read gives us all of the content as a single string, but notice that it gave us an empty string when we called the function as second time. That happens because the file maintains a cursor position and when we first called read the cursor was moved to the very end of the file’s contents. If we want to reread the file we’ll need to move the beginning of the file using the seek function like so:
>>> xmen_file.seek(0)
0
>>> xmen_file.read()
'Storm\nWolverine\nCyclops\nBishop\nNightcrawler\n'
>>> xmen_file.seek(6)
6
>>> xmen_file.read()
'Wolverine\nCyclops\nBishop\nNightcrawler\n'
By seeking to a specific point of the file, we are able to get a string that only contains what is after our cursor’s location.
Another way that we can read through content is by using a for loop:
>>> xmen_file.seek(0)
0
>>> for line in xmen_file:
...     print(line, end="")
...
Storm
Wolverine
Cyclops
Bishop
Nightcrawler
>>>
Notice that we added a custom end to our printing because we knew that there were already newline characters (\n) in each line.
Once we’re finished working with a file, it is import that we close our connection to the file using the close function:
>>> xmen_file.close()
>>> xmen_file.read()
Traceback (most recent call last):
  File "", line 1, in 
ValueError: I/O operation on closed file.
>>>
Creating a New File and Writing to It
We now know the basics of reading a file, but we’re also going to need to know how to write content to files. Let’s create a copy of our xmen file that we can add additional content to:
>>> xmen_base = open('xmen_base.txt')
>>> new_xmen = open('new_xmen.txt', 'w')
We have to reopen our previous connection to the xmen_base.txt so that we can read it again. We then create a connection to a file that doesn't exist yet and set the mode to w, which stands for “write”. The opposite of the read function is the write function, and we can use both of those to populate our new file:
>>> new_xmen.write(xmen_base.read())
>>> new_xmen.close()
>>> new_xmen = open(new_xmen.name, 'r+')
>>> new_xmen.read()
'Storm\nWolverine\nCyclops\nBishop\nNightcrawler\n'
We did quite a bit there, let’s break that down:
We read from the base file and used the return value as the argument to write for our new file.
We closed the new file.
We reopened the new file, using the r+ mode which will allow us to read and write content to the file.
We read the content from the new file to ensure that it wrote properly.
Now that we have a file that we can read and write from let’s add some more names:
>>> new_xmen.seek(0)
>>> new_xmen.write("Beast\n")
6
>>> new_xmen.write("Phoenix\n")
8
>>> new_xmen.seek(0)
0
>>> new_xmen.read()
'Beast\nPhoenix\ne\nCyclops\nBishop\nNightcrawler\n'
What happened there? Since we are using the r+ we are overwriting the file on a per character basis since we used seek to go back to the beginning of the file. If we reopen the file in the w mode, the pre-existing contents will be truncated.
Appending to a File
A fairly common thing to want to do is to append to a file without reading its current contents. This can be done with the a mode. Let’s close the xmen_base.txt file and reopen it in the a mode to add another name without worrying about losing our original content. This time, we’re going to use the with statement to temporarily open the file and have it automatically closed after our code block has executed:
>>> xmen_file.close()
>>> with open('xmen_base.txt', 'a') as f:
...     f.write('Professor Xavier\n')
...
17
>>> f = open('xmen_base.txt', 'a')
>>> with f:
...     f.write("Something\n")
...
10
>>> exit()
To test what we just did, let’s cat out the contents of this file:
$ cat xmen_base.txt
Storm
Wolverine
Cyclops
Bishop
Nightcrawler
Professor Xavier
Something