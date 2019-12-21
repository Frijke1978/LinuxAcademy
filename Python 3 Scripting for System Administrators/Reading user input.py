Accepting User Input Using input
We’re going to build a script that requests three pieces of information from the user after the script runs. Let’s collect this data:
name - The user’s name as a string
birthdate - The user’s birthdate as a string
age - The user’s age as an integer (we’ll need to convert it)
~/bin/age
#!/usr/bin/env python3.6

name = input("What is your name? ")
birthdate = input("What is your birthdate? ")
age = int(input("How old are you? "))

print(f"{name} was born on {birthdate}")
print(f"Half of your age is {age / 2}")