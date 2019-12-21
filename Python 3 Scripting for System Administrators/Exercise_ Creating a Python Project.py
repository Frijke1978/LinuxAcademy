There’s more than one way to set up a project, but here’s one way that you could. First, set up the project’s folder structure:
$ mkdir hr
$ cd hr
$ mkdir -p src/hr tests
$ touch src/hr/__init__.py tests/.keep README.rst
With the folders setup, you can then utilize pipenv to add dependency management:
Note: Ensure that which has been installed and is in your $PATH
$ pipenv --python python3.6 install --dev pytest pytest-mock
Here’s a good starting point for a setup.py:
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
    install_requires=[]
)
Lastly, initialize the git repository:
$ git init
$ curl https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore -o .gitignore
$ git add --all .
$ git commit -m 'Initial commit.'