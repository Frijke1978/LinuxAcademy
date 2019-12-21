Numbers
There are two main types of numbers that we’ll use in Python, int and float. For the most part, we won’t be calling methods on number types, and we will instead be using a variety of operators. 
>>> 2 + 2 # Addition
4
>>> 10 - 4 # Subtraction
6
>>> 3 * 9 # Multiplication
27
>>> 5 / 3 # Division
1.66666666666667
>>> 5 // 3 # Floor division, always returns a number without a remainder
1
>>> 8 % 3 # Modulo division, returns the remainder
2
>>> 2 ** 3 # Exponent
8
If either of the numbers in a mathematical operation in Python is a float, then the other will be converted before carrying out the operation, and the result will always be a float.
Converting Strings and Numbers
Conversion is not uncommon since we need to convert from one type to another when writing a script and Python provides built-in functions for doing that with the built-in types. For strings and numbers, we can use the str, int, and float functions to convert from one type to another (within reason). 
>>> str(1.1)
'1.1'
>>> int("10")
10
>>> int(5.99999)
5
>>> float("5.6")
5.6
>>> float(5)
5.0
You’ll run into issues trying to convert strings to other types if they aren’t present in the string 
>>> float("1.1 things")
Traceback (most recent call last):
  File "", line 1, in 
ValueError: could not convert string to float: '1.1 things'