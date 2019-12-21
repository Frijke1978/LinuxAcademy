# -*- coding: utf-8 -*-
"""
Created on Sun Jun 10 15:27:19 2018

@author: Frijke
"""

alist = ["a","e","i","o","u","y"]
blist = ["alpha", "beta", "gamma", "delta", "epsilon", "eta", "theta"] 

def problem2_2(my_list):
    print(my_list)
    print(my_list[0])
    print(my_list[len(my_list)-1])
    print(my_list[3:5])
    print(my_list[0:3])
    print(my_list[3:len(my_list)])
    print(len(my_list))
    my_list.append('z')
    print(my_list)
