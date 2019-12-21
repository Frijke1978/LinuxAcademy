Python Documentation For This Video
List Comprehensions
Note: we need the words file to exist at /usr/share/dict/words for this video. This can be installed via:
$ sudo yum install -y words
Our contains Script
To dig into list comprehensions, we’re going to write a script that takes a word that then returns all of the values in the “words” file on our machine that contain the word. Our first step will be writing the script using standard iteration, and then we’re going to refactor our script to utilize a list comprehension.
~/bin/contains
#!/usr/bin/env python3.6

import argparse

parser = argparse.ArgumentParser(description='Search for words including partial word')
parser.add_argument('snippet', help='partial (or complete) string to search for in words')

args = parser.parse_args()
snippet = args.snippet.lower()

with open('/usr/share/dict/words') as f:
  words = f.readlines()

matches = []

for word in words:
   if snippet in word.lower():
       matches.append(word)

print(matches)
Let’s test out our first draft of the script to make sure that it works:
$ chmod u+x bin/contains
$ contains Keith
['Keith\n', 'Keithley\n', 'Keithsburg\n', 'Keithville\n']
Note: Depending on your system’s words file your results may vary.
Utilizing a List Comprehension
This portion of our script is pretty standard:
~/bin/contains (partial)
words = open('/usr/share/dict/words').readlines()
matches = []

for word in words:
   if snippet in word.lower():
       matches.append(word)

print(matches)
We can rewrite that chunk of our script as one or two lines using a list comprehension:
~/bin/contains (partial)
words = open('/usr/share/dict/words').readlines()
print([word for word in words if snippet in word.lower()])
We can take this even further by removing the '\n' from the end of each “word” we return:
~/bin/contains (partial)
words = open('/usr/share/dict/words').readlines()
print([word.strip() for word in words if snippet in word.lower()])
Final Version
Here’s the final version of our script that works (nearly) the same as our original version:
~/bin/contains
#!/usr/bin/env python3.6

import argparse

parser = argparse.ArgumentParser(description='Search for words including partial word')
parser.add_argument('snippet', help='partial (or complete) string to search for in words')

args = parser.parse_args()
snippet = args.snippet.lower()

words = open('/usr/share/dict/words').readlines()
print([word.strip() for word in words if snippet in word.lower()])
Here’s our output:
$ contains Keith
['Keith', 'Keithley', 'Keithsburg', 'Keithville']