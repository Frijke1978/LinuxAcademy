# -*- coding: utf-8 -*-
"""
Created on Mon Jun 18 18:17:04 2018

@author: Frijke
"""

def problem4_1(wordlist):
    """ Takes a word list prints it, sorts it, and prints the sorted list """
    print(wordlist)
    wordlist.sort(key=str.lower)
    print(wordlist)