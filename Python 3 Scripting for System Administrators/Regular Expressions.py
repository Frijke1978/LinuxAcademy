More Specific Patterns Using Regular Expressions (The re Module)
Occasionally, we need to be very specific about string patterns that we use, and sometimes those are just not doable with basic globbing. As an exercise in this, let’s change our process_receipts.py file to only return even numbered files (regardless of length). Let’s generate some more receipts and try to accomplish this from the REPL:
$ FILE_COUNT=20 python3.6 gen_receipts.py
$ python3.6
>>> import glob
>>> receipts = glob.glob('./new/receipt-[0-9]*[24680].json')
>>> receipts.sort()
>>> receipts
['./new/receipt-10.json', './new/receipt-12.json', './new/receipt-14.json', './new/receipt-16.json', './new/receipt-18.json']
That glob was pretty close, but it didn’t give us the single-digit even numbers. Let’s try now using the re (Regular Expression) module’s match function, the glob.iglob function, and a list comprehension:
>>> import re
>>> receipts = [f for f in glob.iglob('./new/receipt-[0-9]*.json') if re.match('./new/receipt-[0-9]*[02468].json', f)]
>>> receipts
['./new/receipt-0.json', './new/receipt-2.json', './new/receipt-4.json', './new/receipt-6.json', './new/receipt-8.json', './new/receipt-10.json', './new/receipt-12.json', './new/receipt-14.json', './new/receipt-16.json', './new/receipt-18.json']
We’re using the glob.iglob function instead of the standard glob function because we knew we were going to iterate through it and make modifications at the same time. This iterator allows us to avoid fitting the whole expanded glob.glob list into memory at one time.
Regular Expressions are a pretty big topic, but once you’ve learned them, they are incredibly useful in scripts and also when working with tools like grep. The re module gives us quite a few powerful ways to use regular expressions in our python code.
Improved String Replacement
One actual improvement that we can make to our process_receipts.py file is that we can use a single function call to go from our path variable to the destination that we want. This section:
~/receipts/process_receipts.py (partial)
    name = path.split('/')[-1]
    destination = f"./processed/{name}"
Becomes this using the str.replace method:
    destination = path.replace('new', 'processed')
This is a useful refactoring to make because it makes the intention of our code more clear.
Working With Numbers Using math
Depending on how we want to process the values of our receipts, we might want to manipulate the numbers that we are working with by rounding; going to the next highest integer, or the next lowest integer. These sort of “rounding” actions are pretty common, and some of them require the math module:
>>> import math
>>> math.ceil(1.1)
2
>>> math.floor(1.1)
1
>>> round(1.1111111111, 2)
1.11
We can utilize the built-in round function to clean up the printing of the subtotal at the end of the script. Here’s the final version of process_receipts.py:
~/receipts/process_receipts.py
import glob
import os
import shutil
import json

try:
    os.mkdir("./processed")
except OSError:
    print("'processed' directory already exists")

subtotal = 0.0

for path in glob.iglob('./new/receipt-[0-9]*.json'):
    with open(path) as f:
        content = json.load(f)
        subtotal += float(content['value'])
    destination = path.replace('new', 'processed')
    shutil.move(path, destination)
    print(f"moved '{path}' to '{destination}'")

print(f"Receipt subtotal: ${round(subtotal, 2)}")
BONUS: Truncate Float Without Rounding
I mentioned in the video that you can do some more complicated math to print a number to a specified number of digits without rounding. Here’s an example a function that would do the truncation (for those curious):
>>> import math
>>> def ftruncate(f, ndigits=None):
...     if ndigits and (ndigits > 0):
...         multiplier = 10 ** ndigits
...         num = math.floor(f * multiplier) / multiplier
...     else:
...         num = math.floor(f)
...     return num
>>> num = 1.5441020468646993
>>> ftruncate(num)
1
>>> ftruncate(num, 2)
1.54
>>> ftruncate(num, 8)
1.54410204