Comparisons
There are some standard comparison operators that we’ll use that match pretty closely to those used in mathematical equations. Let’s take a look at them:
>>> 1 < 2
True
>>> 0 > 2
False
>>> 2 == 1
False
>>> 2 != 1
True
>>> 3.0 >= 3.0
True
>>> 3.1 <= 3.0
False
If we try to make comparisons of types that don’t match up, we will run into errors:
>>> 3.1 <= "this"
Traceback (most recent call last):
  File "", line 1, in 
TypeError: '<=' not supported between instances of 'float' and 'str'
>>> 3 <= 3.1
True
>>> 1.1 == "1.1"
False
>>> 1.1 == float("1.1")
True
We can compare more than just numbers. Here’s what it looks like when we compare strings:
>>> "this" == "this"
True
>>> "this" == "This"
False
>>> "b" > "a"
True
>>> "abc" < "b"
True
Notice that the string 'b' is considered greater than the strings 'a' and 'abc'. The characters are compared one at a time alphabetically to determine which is greater. This concept is used to sort strings alphabetically.
The in Check
We often get lists of information that we need to ensure contains (or doesn’t contain) a specific item. To make this check in Python, we’ll use the in and not in operations.
>>> 2 in [1, 2, 3]
True
>>> 4 in [1, 2, 3]
False
>>> 2 not in [1, 2, 3]
False
>>> 4 not in [1, 2, 3]
True
if/elif/else
With a grasp on comparisons, we can now look at how we can run different pieces of logic based on the values that we’re working with using conditionals. The keywords for conditionals in Python are if, elif, and else. Conditionals are the first language feature that we’re using that requires us to utilize whitespace to separate our code blocks. We will always use indentation of 4 spaces. The basic shape of an if statement is this:
if CONDITION:
    pass
The CONDITION portion can be anything that evaluates to True or False, and if the value isn’t explicitly a boolean, then it will be converted to determine how to carry out proceed past the conditional (basically using the bool constructor).
>>> if True:
...     print("Was True")
...
Was True
>>> if False:
...     print("Was True")
...
>>>
To add an alternative code path, we’ll use the else keyword, followed by a colon (:), and indenting the code underneath:
>>> if False:
...     print("Was True")
... else:
...     print("Was False")
...
Was False
In the even that we want to check multiple potential conditions we can use the elif CONDITION: statement. Here’s a more robust example:
>>> name = "Kevin"
>>> if len(name) >= 6:
...     print("name is long")
... elif len(name) == 5:
...     print("name is 5 characters")
... elif len(name) >= 4:
...     print("name is 4 or more")
... else:
...     print("name is short")
...
name is 5 characters
Notice that we fell into the first elif statement’s block and then the second elif block was never executed even though it was true. We can only exercise one branch in an if statement.