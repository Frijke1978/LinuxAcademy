Here are some example tests:
tests/test_cli.py
import pytest

from hr import cli

@pytest.fixture()
def parser():
    return cli.create_parser()

def test_parser_fails_without_arguments(parser):
    """
    Without a path, the parser should exit with an error.
    """
    with pytest.raises(SystemExit):
        parser.parse_args([])

def test_parser_succeeds_with_a_path(parser):
    """
    With a path, the parser should exit with an error.
    """
    args = parser.parse_args(['/some/path'])
    assert args.path == '/some/path'

def test_parser_export_flag(parser):
    """
    The `export` value should default to False, but set
    to True when passed to the parser.
    """
    args = parser.parse_args(['/some/path'])
    assert args.export == False

    args = parser.parse_args(['--export', '/some/path'])
    assert args.export == True
Here’s an example implementation for this cli module:
src/hr/cli.py
import argparse

def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('path', help='the path to the inventory file (JSON)')
    parser.add_argument('--export', action='store_true', help='export current settings to inventory file')
    return parser