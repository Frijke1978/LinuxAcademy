Utilizing Packages
Up to this point, we’ve only used functions and types that are always globally available, but there are a lot of functions that we can use if we import them from the standard library. Importing packages can be done in a few different ways, but the simplest is using the import statement. Here’s how we can import the time package for use:
>>> import time
>>>
Importing the package allows us to access functions and classes that it defines. We can do that by chaining off of the package name. Let’s call the localtime function provided by the time package:
>>> now = time.localtime()
>>> now
time.struct_time(tm_year=2018, tm_mon=1, tm_mday=26, tm_hour=15, tm_min=32, tm_sec=43, tm_wday=4, tm_yday=26, tm_isdst=0)
Calling this function returns a time.struct_time to use that has some attributes that we can interact with using a period (.):
>>> now.tm_hour
15
Here is our first time interaction with an attribute on an object that isn’t a function. Sometimes we need to access the data from an object, and for that, we don’t need to use parentheses.
Building a Stopwatch Script
To put our knowledge of the standard library to use, we’re going to read through the time package’s documentation and utilize some of its functions and types to build a stopwatch. We’ll be using the following functions:
localtime - gives us the time_struct for the current moment
strftime - allows us to specify how to represent the time_struct as a string.
mktime - converts a time_struct into a numeric value so we can calculate the time difference.
~/bin/timer
#!/usr/bin/env python3.6

import time

start_time = time.localtime()
print(f"Timer started at {time.strftime('%X', start_time)}")

# Wait for user to stop timer
input("Press any key to stop timer ")

stop_time = time.localtime()
difference = time.mktime(stop_time) - time.mktime(start_time)

print(f"Timer stopped at {time.strftime('%X', stop_time)}")
print(f"Total time: {difference} seconds")
Importing Specifics From a Module
We’re only using a subset of the functions from the time package, and it’s a good practice to only import what we need. We can import a subset of a module using the from statement combined with our import. The usage will look like this:
from MODULE import FUNC1, FUNC2, etc...
Let’s convert our script over to only import the functions that we need using the from statement:
~/bin/timer
#!/usr/bin/env python3.6

from time import localtime, mktime, strftime

start_time = localtime()
print(f"Timer started at {strftime('%X', start_time)}")

# Wait for user to stop timer
input("Press any key to stop timer ")

stop_time = localtime()
difference = mktime(stop_time) - mktime(start_time)

print(f"Timer stopped at {strftime('%X', stop_time)}")
print(f"Total time: {difference} seconds")