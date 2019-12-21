Function Basics
We can create functions in Python using the following:
The def keyword
The function name - lowercase starting with a letter or underscore (_)
Left parenthesis (()
0 or more argument names
Right parenthesis ())
A colon :
An indented function body
Here’s an example without an argument:
>>> def hello_world():
...     print("Hello, World!")
...
>>> hello_world()
Hello, World!
>>>
If we want to define an argument we will put the variable name we want it to have within the parentheses:
>>> def print_name(name):
...     print(f"Name is {name}")
...
>>> print_name("Keith")
Name is Keith
Let’s try to assign the value from print_name to a variable:
>>> output = print_name("Keith")
Name is Keith
>>> output
>>>
Neither of these examples has a return value, but we will usually want to have a return value unless the function is our “main” function or carries out a “side-effect” like printing. If we don’t explicitly declare a return value, then the result will be None.
We can declare what we’re returning from a function using the return keyword:
>>> def add_two(num):
...     return num + 2
...
>>> result = add_two(2)
>>> result
4