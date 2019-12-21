The for Loop
The most common use we have for looping is when we want to execute some code for each item in a sequence. For this type of looping or iteration, we’ll use the for loop. The general structure for a for loop is:
for TEMP_VAR in SEQUENCE:
    pass
The TEMP_VAR will be populated with each item as we iterate through the SEQUENCE and it will be available to us in the context of the loop. After the loop finishes one iteration, then the TEMP_VAR will be populated with the next item in the SEQUENCE, and the loop’s body will execute again. This process continues until we either hit a break statement or we’ve iterated over every item in the SEQUENCE. Here’s an example looping over a list of colors:
>>> colors = ['blue', 'green', 'red', 'purple']
>>> for color in colors:
...     print(color)
...
blue
green
red
purple
>>> color
'purple'
If we didn't want to print out certain colors we could utilize the continue or break statements again. Let’s say we want to skip the string 'blue' and terminate the loop if we see the string 'red':
>>> colors = ['blue', 'green', 'red', 'purple']
>>> for color in colors:
...     if color == 'blue':
...         continue
...     elif color == 'red':
...         break
...     print(color)
...
green
>>>
Other Iterable Types
Lists will be the most common type that we iterate over using a for loop, but we can also iterate over other sequence types. Of the types we already know, we can iterate over strings, dictionaries, and tuples.
Here’s a tuple example:
>>> point = (2.1, 3.2, 7.6)
>>> for value in point:
...     print(value)
...
2.1
3.2
7.6
>>>
A dictionary example:
>>> ages = {'kevin': 59, 'bob': 40, 'kayla': 21}
>>> for key in ages:
...     print(key)
...
kevin
bob
kayla
A string example:
>>> for letter in "my_string":
...     print(letter)
...
m
y
_
s
t
r
i
n
g
>>>
Unpacking Multiple Items in a for Loop
We discussed in the tuples video how you can separate a tuple into multiple variables by “unpacking” the values. Unpacking works in the context of a loop definition, and you’ll need to know this to most effectively iterate over dictionaries because you’ll usually want the key and the value. Let’s iterate of a list of “points” to test this out:
>>> list_of_points = [(1, 2), (2, 3), (3, 4)]
>>> for x, y in list_of_points:
...     print(f"x: {x}, y: {y}")
...
x: 1, y: 2
x: 2, y: 3
x: 3, y: 4
Seeing how this unpacking works, let’s use the items method on our ages dictionary to list out the names and ages:
>>> for name, age in ages.items():
...     print(f"Person Named: {name}")
...     print(f"Age of: {age}")
...
Person Named: kevin
Age of: 59
Person Named: bob
Age of: 40
Person Named: kayla
Age of: 21