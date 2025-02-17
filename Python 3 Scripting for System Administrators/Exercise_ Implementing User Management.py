Here’s an example of how you could implement this module. These are the tests that I used to drive my implementation:
tests/test_users.py
import pytest
import subprocess

from hr import users

# encrypted version of 'password'
password = '$6$HXdlMJqcV8LZ1DIF$LCXVxmaI/ySqNtLI6b64LszjM0V5AfD.ABaUcf4j9aJWse2t3Jr2AoB1zZxUfCr8SOG0XiMODVj2ajcQbZ4H4/'

user_dict = {
    'name': 'kevin',
    'groups': ['wheel', 'dev'],
    'password': password
}

def test_users_add(mocker):
    """
    Given a user dictionary. `users.add(...)` should
    utilize `useradd` to create a user with the password
    and groups.
    """
    mocker.patch('subprocess.call')
    users.add(user_dict)
    subprocess.call.assert_called_with([
        'useradd',
        '-p',
        password,
        '-G',
        'wheel,dev',
        'kevin',
    ])

def test_users_remove(mocker):
    """
    Given a user dictionary, `users.remove(...)` should
    utilize `userdel` to delete the user.
    """
    mocker.patch('subprocess.call')
    users.remove(user_dict)
    subprocess.call.assert_called_with([
        'userdel',
        '-r',
        'kevin',
    ])

def test_users_update(mocker):
    """
    Given a user dictionary, `users.update(...)` should
    utilize `usermod` to set the groups and password for the
    user.
    """
    mocker.patch('subprocess.call')
    users.update(user_dict)
    subprocess.call.assert_called_with([
        'usermod',
        '-p',
        password,
        '-G',
        'wheel,dev',
        'kevin',
    ])

def test_users_sync(mocker):
    """
    Given a list of user dictionaries, `users.sync(...)` should
    create missing users, remove extra non-system users, and update
    existing users. A list of existing usernames can be passed in
    or default users will be used.
    """
    existing_user_names = ['kevin', 'bob']
    users_info = [
        user_dict,
        {
            'name': 'jose',
            'groups': ['wheel'],
            'password': password
        }
    ]
    mocker.patch('subprocess.call')
    users.sync(users_info, existing_user_names)

    subprocess.call.assert_has_calls([
        mocker.call([
            'usermod',
            '-p',
            password,
            '-G',
            'wheel,dev',
            'kevin',
        ]),
        mocker.call([
            'useradd',
            '-p',
            password,
            '-G',
            'wheel',
            'jose',
        ]),
        mocker.call([
            'userdel',
            '-r',
            'bob',
        ]),
    ])
Notice: Since there were multiple calls made to subprocess.call within the sync test we used a different assertion method called assert_has_calls which takes a list of mocker.call objects. The mocker.call method wraps the content we would otherwise have put in an assert_called_with assertion.
Here is my implementation of this module (with a few helper functions prefixed with underscores):
src/hr/users.py
import pwd
import subprocess
import sys

def add(user_info):
    print(f"Adding user '{user_info['name']}'")
    try:
        subprocess.call([
            'useradd',
            '-p',
            user_info['password'],
            '-G',
            _groups_str(user_info),
            user_info['name'],
        ])
    except:
        print(f"Failed to add user '{user_info['name']}'")
        sys.exit(1)

def remove(user_info):
    print(f"Removing user '{user_info['name']}'")
    try:
        subprocess.call([
            'userdel',
            '-r',
            user_info['name']
        ])
    except:
        print(f"Failed to remove user '{user_info['name']}'")
        sys.exit(1)

def update(user_info):
    print(f"Updating user '{user_info['name']}'")
    try:
        subprocess.call([
            'usermod',
            '-p',
            user_info['password'],
            '-G',
            _groups_str(user_info),
            user_info['name'],
        ])
    except:
        print(f"Failed to update user '{user_info['name']}'")
        sys.exit(1)

def sync(users, existing_user_names=None):
    existing_user_names = (existing_user_names or _user_names())
    user_names = [user['name'] for user in users]
    for user in users:
        if user['name'] not in existing_user_names:
            add(user)
        elif user['name'] in existing_user_names:
            update(user)
    for user_name in existing_user_names:
        if not user_name in user_names:
            remove({ 'name': user_name })

def _groups_str(user_info):
    return ','.join(user_info['groups'] or [])

def _user_names():
    return [user.pw_name for user in pwd.getpwall()
            if user.pw_uid >= 1000 and 'home' in user.pw_dir]
I utilized the pwd module to get a list of all of the users on the system and determined which ones weren’t system users by looking for UIDs over 999 and ensuring that the user’s directory was under home. Additionally, the join method on str was used to combine a list of values into a single string separated by commas. This action is roughly equivalent to:
index = 0
group_str = ""
for group in groups:
    if index == 0:
        group_str += group
    else:
        group_str += ",%s" % group
    index+=1
To manually test this you’ll need to (temporarily) run the following from within your project’s directory:
sudo pip3.6 install -e .
Then you will be able to run the following to be able to use your module in a REPL without getting permissions errors for calling out to usermod, userdel, and useradd:
sudo python3.6
>>> from hr import users
>>> password = '$6$HXdlMJqcV8LZ1DIF$LCXVxmaI/ySqNtLI6b64LszjM0V5AfD.ABaUcf4j9aJWse2t3Jr2AoB1zZxUfCr8SOG0XiMODVj2ajcQbZ4H4/'
>>> user_dict = {
...     'name': 'kevin',
...     'groups': ['wheel'],
...     'password': password
... }
>>> users.add(user_dict)
Adding user 'kevin'
>>> user_dict['groups'] = []
>>> users.update(user_dict)
Updating user 'kevin'
>>> users.remove(user_dict)
Removing user 'kevin'
>>>