#!/usr/bin/env python3.6

user = { 'admin': True, 'active': True, 'name': 'Kevin' }
prefix = ""

if user['admin'] and user['active']:
    prefix = "ACTIVE - (ADMIN) "
elif user['admin']:
    prefix = "(ADMIN) "
elif user['active']:
    prefix = "ACTIVE - "

print(prefix + user['name'])