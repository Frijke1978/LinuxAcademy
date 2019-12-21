# -*- coding: utf-8 -*-
"""
Created on Sun Jun 10 15:27:19 2018

@author: Frijke
"""

import random

def problem2_5():
    """ Simulates rolling a die 10 times."""
    # Setting the seed makes the random numbers always the same
    # This is to make the auto-grader's job easier.
    random.seed(171)  # don't remove when you submit for grading
    for die in range(0,10):
        print(random.randint(1,6))