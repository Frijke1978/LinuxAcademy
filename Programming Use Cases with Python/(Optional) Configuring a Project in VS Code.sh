VS Code has great options for customizing how it runs based on the project that we're working in. In this lesson, we'll set up VS Code with some customizations for our assault project.
Documentation for This Video
Black
Pylint
The Project Workspace
To focus on what we're doing, we're first going to close any open windows that we have and open a new remote development session. With the new window open, we'll open the ~/code/assault directory so we only see files that are part of our project. From here, we can set which Python interpreter to use by opening the command palette with Shift + Ctrl + P and then running the "Python: Select Interpreter" command. In the list that is displayed, we should see an option for our project's virtualenv—we'll select that.
Now we should have a .vscode directory with a settings.json file in it. This file is where we'll be putting our project's configuration. Let's modify this file a little more so that it looks like this:
Note: Your pythonPath value will be different.
assault/.vscode/settings.json
{
    "python.pythonPath": "/home/cloud_user/.local/share/virtualenvs/assault-F3hjvTUZ/bin/python",
    "python.linting.enabled": true,
    "editor.formatOnSave": true,
    "python.formatting.provider": "black"
}
Next we need to open the setup.py file, and when we save it, we should be prompted to install Black and Pylint. Select Yes for both, and VS Code will install them by adding them to our Pipfile as development dependencies. Now when we save files that we're working in, Black will automatically adjust the formatting, and Pylint will let us know if we're breaking any of its linting rules.