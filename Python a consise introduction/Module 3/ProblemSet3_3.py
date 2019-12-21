# -*- coding: utf-8 -*-
"""
Created on Mon Jun 11 21:58:06 2018

@author: Frijke
"""

def problem3_3(month, day, year):
    """ Takes date of form mm/dd/yyyy and writes it in form June 17, 2016 
        Example3_3: problem3_3(6, 17, 2016) gives June 17, 2016 """
    months = ("January", "February", "March", "April", "May", "June", "July", \
              "August", "September", "October", "November", "December")
    monthNum = int(month) - 1
    print(months[monthNum], str(day) + ",", year)