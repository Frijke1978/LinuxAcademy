The while Loop
The most basic type of loop that we have at our disposal is the while loop. This type of loop repeats itself based on a condition that we pass to it. Here’s the general structure of a while loop:
while CONDITION:
    pass
The CONDITION in this statement works the same way that it does for an if statement. When we demonstrated the if statement, we first tried it by simply passing in True as the condition. Let’s see when we try that same condition with a while loop:
>>> while True:
...     print("looping")
...
looping
looping
looping
looping
That loop will continue forever, we’ve created an infinite loop. To stop the loop, press Ctrl-C. Infinite loops are one of the potential problems with while loops if we don’t use a condition that we can change from within the loop then it will continue forever if initially true. Here’s how we’ll normally approach using a while loop where we modify something about the condition on each iteration:
>>> count = 1
>>> while count <= 4:
...     print("looping")
...     count += 1
...
looping
looping
looping
looping
>>>
We can use other loops or conditions inside of our loops; we need only remember to indent four more spaces for each context. If in a nested context, we want to continue to the next iteration or stop the loop entirely. We also have access to the continue and break keywords:
>>> count = 0
>>> while count < 10:
...     if count % 2 == 0:
...         count += 1
...         continue
...     print(f"We're counting odd numbers: {count}")
...     count += 1
...
We're counting odd numbers: 1
We're counting odd numbers: 3
We're counting odd numbers: 5
We're counting odd numbers: 7
We're counting odd numbers: 9
>>>
In that example, we also show off how to “string interpolation” in Python 3 by prefixing a string literal with an f and then using curly braces to substitute in variables or expressions (in this case the count value).
Here’s an example using the break statement:
>>> count = 1
>>> while count < 10:
...     if count % 2 == 0:
...         break
...     print(f"We're counting odd numbers: {count}")
...     count += 1
...
We're counting odd numbers: 1