# -*- coding: utf-8 -*-
"""
Created on Sun Jun 10 15:27:19 2018

@author: Frijke
"""

import random

def problem2_6():
    """ Simulates rolling 2 dice 100 times """
    # Setting the seed makes the random numbers always the same
    # This is to make the auto-grader's job easier.
    random.seed(431)  # don't remove when you submit for grading
    for outcome in range(0,100):
        die_1 = random.randint(1,6)
        die_2 = random.randint(1,6)
        print(die_1+die_2)