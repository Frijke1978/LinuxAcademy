Dictionaries
Dictionaries are the main mapping type that we’ll use in Python. This object is comparable to a Hash or “associative array” in other languages.
Things to note about dictionaries: 
Unlike Python 2 dictionaries, as of Python 3.6, keys are ordered in dictionaries. You'll need OrderedDict if you want this to work on another version of Python.
You can set the key to any IMMUTABLE TYPE (no lists).
Avoid using things other than simple objects as keys.
Each key can only have one value (so don’t have duplicates when creating a dict). 
We create dictionary literals by using curly braces ({ and }), separating keys from values using colons (:), and separating key/value pairs using commas (,). Here’s an example dictionary: 
>>> ages = { 'kevin': 59, 'alex': 29, 'bob': 40 }
>>> ages
{'kevin': 59, 'alex': 29, 'bob': 40}
We can read a value from a dictionary by subscripting using the key: 
>>> ages['kevin']
59
>>> ages['billy']
Traceback (most recent call last):
  File "", line 1, in 
KeyError: 'billy'
Keys can be added or changed using subscripting and assignment: 
>>> ages['kayla'] = 21
>>> ages
{'kevin': 59, 'alex': 29, 'bob': 40, 'kayla': 21}
Items can be removed from a dictionary using the del statement or by using the pop method: 
>>> del ages['kevin']
>>> ages
{'alex': 29, 'bob': 40, 'kayla': 21}
>>> del ages
>>> ages
Traceback (most recent call last):
  File "", line 1, in 
NameError: name 'ages' is not defined
>>> ages = { 'kevin': 59, 'alex': 29, 'bob': 40 }
>>> ages.pop('alex')
29
>>> ages
{'kevin': 59, 'bob': 40}
It’s not uncommon to want to know what keys or values we have without caring about the pairings. For that situation we have the values and keys methods: 
>>> ages = {'kevin': 59, 'bob': 40}
>>> ages.keys()
dict_keys(['kevin', 'bob'])
>>> list(ages.keys())
['kevin', 'bob']
>>> ages.values()
dict_values([59, 40])
>>> list(ages.values())
[59, 40]
Alternative Ways to Create a dict Using Keyword Arguments
There are a few other ways to create dictionaries that we might see, those being those that use the dict constructor with key/value arguments and a list of tuples:
>>> weights = dict(kevin=160, bob=240, kayla=135)
>>> weights
{'kevin': 160, 'bob': 240, 'kayla': 135}
>>> colors = dict([('kevin', 'blue'), ('bob', 'green'), ('kayla', 'red')])
>>> colors
{'kevin': 'blue', 'bob': 'green', 'kayla': 'red'}