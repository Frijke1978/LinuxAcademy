# -*- coding: utf-8 -*-
"""
Created on Mon Jun 11 21:58:06 2018

@author: Frijke
"""

def problem3_5(name):
    """ Looks up the phone number of the person whose name is name """
    
    phone_numbers = {"abbie":"(860) 123-4535", "beverly":"(901) 454-3241", \
                      "james": "(212) 567-8149", "thomas": "(795) 342-9145"}
    dictionary = (phone_numbers[name])
    print(dictionary)