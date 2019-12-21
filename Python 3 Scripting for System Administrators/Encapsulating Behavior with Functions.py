Encapsulating Behavior with Functions
To dig into functions, we’re going to write a script that prompts the user for some information and calculates the user’s Body Mass Index (BMI). That isn’t a common problem, but it’s something that makes sense as a function and doesn’t require us to use language features that we haven’t learned yet.
Here’s the formula for BMI:
BMI = (weight in kg / height in meters squared )
For Imperial systems, it’s the same formula except you multiply the result by 703.
We want to prompt the user for their information, gather the results, and make the calculations if we can. If we can’t understand the measurement system, then we need to prompt the user again after explaining the error.
Gathering Info
Since we want to be able to prompt a user multiple times we’re going to package up our calls to input within a single function that returns a tuple with the user given information:
def gather_info():
    height = float(input("What is your height? (inches or meters) "))
    weight = float(input("What is your weight? (pounds or kilograms) "))
    system = input("Are your measurements in metric or imperial units? ").lower().strip()
    return (height, weight, system)
We’re converting the height and weight into float values, and we’re okay with a potential error if the user inputs an invalid number. For the system, we’re going to standardize things by calling lower to lowercase the input and then calling strip to remove the whitespace from the beginning and the end.
The most important thing about this function is the return statement that we added to ensure that we can pass the height, weight, and system back to the caller of the function.
Calculating and Printing the BMI
Once we’ve gathered the information, we need to use that information to calculate the BMI. Let’s write a function that can do this:
def calculate_bmi(weight, height, system='metric'):
    """
    Return the Body Mass Index (BMI) for the
    given weight, height, and measurement system.
    """
    if system == 'metric':
        bmi = (weight / (height ** 2))
    else:
        bmi = 703 * (weight / (height ** 2))
    return bmi
This function will return the calculated value, and we can decide what to do with it in the normal flow of our script.
The triple-quoted string we used at the top of our function is known as a “documentation string” or “doc string” and can be used to automatically generated documentation for our code using tools in the Python ecosystem.
Setting Up The Script’s Flow
Our functions don’t do us any good if we don’t call them. Now it’s time for us to set up our scripts flow. We want to be able to re-prompt the user, so we want to utilize an intentional infinite loop that we can break out of. Depending on the system, we’ll determine how we should calculate the BMI or prompt the user again. Here’s our flow:
while True:
    height, weight, system = gather_info()
    if system.startswith('i'):
        bmi = calculate_bmi(weight, system='imperial', height=height)
        print(f"Your BMI is {bmi}")
        break
    elif system.startswith('m'):
        bmi = calculate_bmi(weight, height)
        print(f"Your BMI is {bmi}")
        break
    else:
        print("Error: Unknown measurement system. Please use imperial or metric.")
Full Script
Once we’ve written our script, we’ll need to make it executable (using chmod u+x ~/bin/bmi).
~/bin/bmi
#!/usr/bin/env python3.6

def gather_info():
    height = float(input("What is your height? (inches or meters) "))
    weight = float(input("What is your weight? (pounds or kilograms) "))
    system = input("Are your mearsurements in metric or imperial systems? ").lower().strip()
    return (height, weight, system)

def calculate_bmi(weight, height, system='metric'):
    if system == 'metric':
        bmi = (weight / (height ** 2))
    else:
        bmi = 703 * (weight / (height ** 2))
    return bmi

while True:
    height, weight, system = gather_info()
    if system.startswith('i'):
        bmi = calculate_bmi(weight, system='imperial', height=height)
        print(f"Your BMI is {bmi}")
        break
    elif system.startswith('m'):
        bmi = calculate_bmi(weight, height)
        print(f"Your BMI is {bmi}")
        break
    else:
        print("Error: Unknown measurement system. Please use imperial or metric.")