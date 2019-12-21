Working with Variables
We can assign a value to a variable by using a single = and we don’t need to (nor can we) specify the type of the variable. 
>>> my_str = "This is a simple string"
Now we can print the value of that string by using my_var later on: 
>>> print(my_str)
This is a simple string
Before, we talked about how we can’t change a string because it’s immutable. This is easier to see now that we have variables. 
>>> my_str += " testing"
>>> my_str
'This is a simple string testing'
That didn’t change the string; it reassigned the variable. The original string of "This is a simple string" was unchanged.
An important thing to realize is that the contents of a variable can be changed and we don’t need to maintain the same type: 
>>> my_str = 1
>>> print(my_str)
1
Ideally, we wouldn’t change the contents of a variable called my_str to be an int, but it is something that python would let use do. 
One last thing to remember is that if we assign a variable with another variable, it will be assigned to the result of the variable and not whatever that variable points to later. 
>>> my_str = 1
>>> my_int = my_str
>>> my_str = "testing"
>>> print(my_int)
1
>>> print(my_str)
testing