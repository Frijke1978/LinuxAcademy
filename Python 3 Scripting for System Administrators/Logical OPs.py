The not Operation
Sometimes we want to know the opposite boolean value for something. This might not sound intuitive, but sometimes we want to execute an if statement when a value is False, but that’s not how the if statement works. Here’s an example of how we can use not to make this work:
>>> name = ""
>>> not name
True
>>> if not name:
...     print("No name given")
...
>>>
We know that an empty string is a “falsy” value, so not "" will always return True. not will return the opposite boolean value for whatever it’s operating on.
The or Operation
Occasionally, we want to carry out a branch in our logic if one condition OR the other condition is True. Here is where we’ll use the or operation. Let’s see or in action with an if statement:
>>> first = ""
>>> last = "Thompson"
>>> if first or last:
...     print("The user has a first or last name")
...
The user has a first or last name
>>>
If both first and last were “falsy” then the print would never happen:
>>> first = ""
>>> last = ""
>>> if first or last:
...     print("The user has a first or last name")
...
>>>
Another feature of or that we should know is that we can use it to set default values for variables:
>>> last = ""
>>> last_name = last or "Doe"
>>> last_name
'Doe'
>>>
The or operation will return the first value that is “truthy” or the last value in the chain:
>>> 0 or 1
1
>>> 1 or 2
1
The and Operation
The opposite of or is the and operation, which requires both conditions to be True. Continuing with our first and last name example, let’s conditionally print based on what we know:
>>> first = "Keith"
>>> last = ""
>>> if first and last:
...     print(f"Full name: {first} {last}")
... elif first:
...     print(f"First name: {first}")
... elif last:
...     print(f"Last name: {last}")
...
First name: Keith
>>>
Now let’s try the same thing with both first and last:
>>> first = "Keith"
>>> last = "Thompson"
>>> if first and last:
...     print(f"Full name: {first} {last}")
... elif first:
...     print(f"First name: {first}")
... elif last:
...     print(f"Last name: {last}")
...
Full name: Keith Thompson
>>>
The and operation will return the first value that is “falsy” or the last value in the chain:
>>> 0 and 1
0
>>> 1 and 2
2
>>> (1 == 1) and print("Something")
Something
>>> (1 == 2) and print("Something")
False