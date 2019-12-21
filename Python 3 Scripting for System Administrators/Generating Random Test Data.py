Generating Random Test Data
To write our receipt reconciliation tool, we need to have some receipts to work with as we’re testing out our implementation. We’re expecting receipts to be JSON files that contain some specific data and we’re going to write a script that will create some receipts for us.
We’re working on a system that requires some local paths, so let’s put what we’re doing in a receipts directory:
$ mkdir -p receipts/new
$ cd receipts
The receipts that haven’t been reconciled will go in the new directory, so we’ve already created that. Let’s create a gen_receipts.py file to create some unreconciled receipts when we run it:
~/receipts/gen_receipts.py
import random
import os
import json

count = int(os.getenv("FILE_COUNT") or 100)
words = [word.strip() for word in open('/usr/share/dict/words').readlines()]

for identifier in range(count):
    amount = random.uniform(1.0, 1000)
    content = {
        'topic': random.choice(words),
        'value': "%.2f" % amount
    }
    with open(f'./new/receipt-{identifier}.json', 'w') as f:
        json.dump(content, f)
We’re using the json.dump function to ensure that we’re writing out valid JSON (we’ll read it in later). random.choice allows us to select one item from an iterable (str, tuple, or list). The function random.uniform gives us a float between the two bounds specified. This code does show us how to create a range, which takes a starting number and an ending number and can be iterated through the values between.
Now we can run our script using the python3.6 command:
$ FILE_COUNT=10 python3.6 gen_receipts.py
$ ls new/
receipt-0.json  receipt-2.json  receipt-4.json  receipt-6.json  receipt-8.json
receipt-1.json  receipt-3.json  receipt-5.json  receipt-7.json  receipt-9.json
$ cat new/receipt-0.json
{"topic": "microceratous", "value": "918.67"}