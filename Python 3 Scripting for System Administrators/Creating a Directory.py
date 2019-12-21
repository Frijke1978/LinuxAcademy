Creating a Directory If It Doesn’t Exist
Before we start doing anything with the receipts, we want to have a processed directory to move them to so that we don’t try to process the same receipt twice. Our script can be smart enough to create this directory for us if it doesn’t exist when we first run the script. We’ll use the os.mkdir function; if the directory already exists we can catch the OSError that is thrown:
~/receipts/process_receipts.py
import os

try:
    os.mkdir("./processed")
except OSError:
    print("'processed' directory already exists")
Collecting the Receipts to Process
From the shell, we’re able to collect files based on patterns, and that’s useful. For our purposes, we want to get every receipt from the new directory that matches this pattern:
receipt-[0-9]*.json
That pattern translates to receipt-, followed by any number of digits, and ending with a .json file extension. We can achieve this exact result using the glob.glob function.
~/receipts/process_receipts.py (partial)
receipts = glob.glob('./new/receipt-[0-9]*.json')
subtotal = 0.0
Part of processing the receipts will entail adding up all of the values, so we’re going to start our script with a subtotal of 0.0.
Reading JSON, Totaling Values, and Moving Files
The remainder of our script is going to require us to do the following:
Iterate over the receipts
Reading each receipt’s JSON
Totaling the value of the receipts
Moving each receipt file to the processed directory after we’re finished with it
We used the json.dump function to write out a JSON file, and we can use the opposite function json.load to read a JSON file. The contents of the file will be turned into a dictionary that we can us to access its keys. We’ll add the value to the subtotal before finally moving the file using shutil.move. Here’s our final script:
~/receipts/process_receipts.py
import glob
import os
import shutil
import json

try:
    os.mkdir("./processed")
except OSError:
    print("'processed' directory already exists")

# Get a list of receipts
receipts = glob.glob('./new/receipt-[0-9]*.json')
subtotal = 0.0

for path in receipts:
    with open(path) as f:
        content = json.load(f)
        subtotal += float(content['value'])
    name = path.split('/')[-1]
    destination = f"./processed/{name}"
    shutil.move(path, destination)
    print(f"moved '{path}' to '{destination}'")

print("Receipt subtotal: $%.2f" % subtotal)
Let’s add some files that don’t match our pattern to the new directory before running our script:
touch new/receipt-other.json new/receipt-14.txt new/random.txt
Finally, let’s run our script twice and see what we get:
$ python3.6 process_receipts.py
moved './new/receipt-0.json' to './processed/receipt-0.json'
moved './new/receipt-1.json' to './processed/receipt-1.json'
moved './new/receipt-2.json' to './processed/receipt-2.json'
moved './new/receipt-3.json' to './processed/receipt-3.json'
moved './new/receipt-4.json' to './processed/receipt-4.json'
moved './new/receipt-5.json' to './processed/receipt-5.json'
moved './new/receipt-6.json' to './processed/receipt-6.json'
moved './new/receipt-7.json' to './processed/receipt-7.json'
moved './new/receipt-8.json' to './processed/receipt-8.json'
moved './new/receipt-9.json' to './processed/receipt-9.json'
Receipt subtotal: $6932.04
$ python3.6 process_receipts.py
'processed' directory already exists
Receipt subtotal: $0.00
Note: The subtotal that is printed for you will be different since our receipts are all randomly generated.