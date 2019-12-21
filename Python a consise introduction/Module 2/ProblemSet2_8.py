# -*- coding: utf-8 -*-
"""
Created on Sun Jun 10 15:27:19 2018

@author: Frijke
"""

def problem2_8(temp_list):
    sum = 0
    for temp in temp_list:
        sum += temp
    avg = sum/len(temp_list)
    max_temp = max(temp_list)
    min_temp = min(temp_list)
    print("Average:", avg)
    print("High:", max_temp)
    print("Low:", min_temp)