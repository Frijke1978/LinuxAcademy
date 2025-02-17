Here’s an example main function that was added to the cli module:
src/hr/cli.py
import argparse

def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('path', help='the path to the inventory file (JSON)')
    parser.add_argument('--export', action='store_true', help='export current settings to inventory file')
    return parser

def main():
    from hr import inventory, users

    args = create_parser().parse_args()

    if args.export:
        inventory.dump(args.path)
    else:
        users_info = inventory.load(args.path)
        users.sync(users_info)
Here are the modifications for the setup.py file necessary to create a console script:
setup.py
from setuptools import setup, find_packages

with open('README.rst', encoding='UTF-8') as f:
    readme = f.read()

setup(
    name='hr',
    version='0.1.0',
    description='Commandline user management utility',
    long_description=readme,
    author='Your Name',
    author_email='person@example.com',
    packages=find_packages('src'),
    package_dir={'': 'src'},
    install_requires=[],
    entry_points={
        'console_scripts': 'hr=hr.cli:main',
    },
)
Since you need sudo to run the script you’ll want to install it using sudo pip3.6:
$ sudo pip3.6 install -e .
$ sudo hr --help
usage: hr [-h] [--export] path

positional arguments:
  path        the path to the inventory file (JSON)

optional arguments:
  -h, --help  show this help message and exit
  --export    export current settings to inventory file