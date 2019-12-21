Working with Environment Variables
By importing the os package, we’re able to access a lot of miscellaneous operating system level attributes and functions, not the least of which is the environ object. This object behaves like a dictionary, so we can use the subscript operation to read from it.
Let’s create a simple script that will read a 'STAGE' environment variable and print out what stage we’re currently running in:
~/bin/running
#!/usr/bin/env python3.6

import os

stage = os.environ["STAGE"].upper()

output = f"We're running in {stage}"

if stage.startswith("PROD"):
    output = "DANGER!!! - " + output

print(output)
We can set the environment variable when we run the script to test the differences:
$ STAGE=staging running
We're running in STAGING
$ STAGE=production running
DANGER!!! - We're running in PRODUCTION
What happens if the 'STAGE' environment variable isn’t set though?
$ running
Traceback (most recent call last):
  File "/home/user/bin/running", line 5, in 
    stage = os.environ["STAGE"].upper()
  File "/usr/local/lib/python3.6/os.py", line 669, in __getitem__
    raise KeyError(key) from None
KeyError: 'STAGE'
This potential KeyError is the biggest downfall of using os.environ, and the reason that we will usually use os.getenv.
Handling A Missing Environment Variable
If the 'STAGE' environment variable isn’t set, then we want to default to 'DEV', and we can do that by using the os.getenv function:
~/bin/running
#!/usr/bin/env python3.6

import os

stage = os.getenv("STAGE", "dev").upper()

output = f"We're running in {stage}"

if stage.startswith("PROD"):
    output = "DANGER!!! - " + output

print(output)
Now if we run our script without a 'STAGE' we won’t have an error:
$ running
We're running in DEV