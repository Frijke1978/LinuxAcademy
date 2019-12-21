#!/usr/bin/env python3.6

message = input("message to echo: ")
count = input("Number of times to echo: ").strip()


if count:
    count = int(count)
else:
    count = 1

def multi_echo(message, count):
    while count > 0:
        print(message)
        count -= 1

multi_echo(message, count)
