# -*- coding: utf-8 -*-
"""
Created on Mon Jun 11 21:58:06 2018

@author: Frijke
"""

import csv
def problem3_7(csv_pricefile, flower):
    infile = open(csv_pricefile)
    reader = csv.reader(infile)
    for row in reader:
        if row[0] == flower:
            print(row[1])