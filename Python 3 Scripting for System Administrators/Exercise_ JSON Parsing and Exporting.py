Here are the tests used to drive the example implementation:
tests/test_inventory.py
import tempfile

from hr import inventory

def test_inventory_load():
    """
    `inventory.load` takes a path to a file and parses it as JSON
    """
    inv_file = tempfile.NamedTemporaryFile(delete=False)
    inv_file.write(b"""
    [
      {
        "name": "kevin",
        "groups": ["wheel", "dev"],
        "password": "password_one"
      },
      {
        "name": "lisa",
        "groups": ["wheel"],
        "password": "password_two"
      },
      {
        "name": "jim",
        "groups": [],
        "password": "password_three"
      }
    ]
    """)
    inv_file.close()
    users_list = inventory.load(inv_file.name)
    assert users_list[0] == {
        'name': 'kevin',
        'groups': ['wheel', 'dev'],
        'password': 'password_one'
    }
    assert users_list[1] == {
        'name': 'lisa',
        'groups': ['wheel'],
        'password': 'password_two'
    }
    assert users_list[2] == {
        'name': 'jim',
        'groups': [],
        'password': 'password_three'
    }

def test_inventory_dump(mocker):
    """
    `inventory.dump` takes a destination path and optional list of users to export then exports the existing user information.
    """
    dest_file = tempfile.NamedTemporaryFile(delete=False)
    dest_file.close()

    # spwd.getspnam can't be used by non-root user normally.
    # Mock the implemntation so that we can test.
    mocker.patch('spwd.getspnam', return_value=mocker.Mock(sp_pwd='password'))

    # grp.getgrall will return the values from the test machine.
    # To get consistent results we need to mock this.
    mocker.patch('grp.getgrall', return_value=[
        mocker.Mock(gr_name='super', gr_mem=['bob']),
        mocker.Mock(gr_name='other', gr_mem=[]),
        mocker.Mock(gr_name='wheel', gr_mem=['bob', 'kevin']),
    ])

    inventory.dump(dest_file.name, ['kevin', 'bob'])

    with open(dest_file.name) as f:
        assert f.read() == """[{"name": "kevin", "groups": ["wheel"], "password": "password"}, {"name": "bob", "groups": ["super", "wheel"], "password": "password"}]"""
Notice that we had to jump through quite a few hoops to get the tests to work consistently for the dump function. The test_inventory_dump required so much mocking that it is debatable as to whether or not it’s worth the effort to test. Here’s the implementation of the module:
src/hr/inventory.py
import grp
import json
import spwd

from .helpers import user_names

def load(path):
    with open(path) as f:
        return json.load(f)

def dump(path, user_names=user_names()):
    users = []
    for user_name in user_names:
        password = spwd.getspnam(user_name).sp_pwd
        groups = _groups_for_user(user_name)
        users.append({
            'name': user_name,
            'groups': groups,
            'password': password
        })
    with open(path, 'w') as f:
        json.dump(users, f)

def _groups_for_user(user_name):
    return [g.gr_name for g in grp.getgrall() if user_name in g.gr_mem]
The default list of user_names for the dump function used the same code that was used previously in the users module so it was extracted into a new helpers module to be used in both.
src/hr/helpers.py
import pwd

def user_names():
    return [user.pw_name for user in pwd.getpwall()
            if user.pw_uid >= 1000 and 'home' in user.pw_dir]
Here’s the updated users module:
src/hr/users.py
import pwd
import subprocess
import sys

from .helpers import user_names

def add(user_info):
    print("Adding user '%s'" % user_info['name'])
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
        print("Failed to add user '%s'" % user_info['name'])
        sys.exit(1)

def remove(user_info):
    print("Removing user '%s'" % user_info['name'])
    try:
        subprocess.call([
            'userdel',
            '-r',
            user_info['name']
        ])
    except:
        print("Failed to remove user '%s'" % user_info['name'])
        sys.exit(1)

def update(user_info):
    print("Updating user '%s'" % user_info['name'])
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
        print("Failed to update user '%s'" % user_info['name'])
        sys.exit(1)

def sync(users, existing_user_names=user_names()):
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
Manually Test the Module
Load the Python3.6 REPL as root to interact with the new inventory module:
$ sudo python3.6
>>> from hr import inventory
>>> inventory.dump('./inventory.json')
>>> exit()
Now you can look at the new inventory.json file to see that it dumped the users properly.
$ cat inventory.json
[{"name": "kevin", "groups": ["wheel"], "password": "$6$HXdlMJqcV8LZ1DIF$LCXVxmaI/ySqNtLI6b64LszjM0V5AfD.ABaUcf4j9aJWse2t3Jr2AoB1zZxUfCr8SOG0XiMODVj2ajcQbZ4H4/"}]