# -*- coding: utf-8 -*-
"""
Created on Mon Jun 11 21:58:06 2018

@author: Frijke
"""

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

infile = open(infile)
outfile = open(outfile, 'w')

for line in infile:
    line = line.strip("\n")
    outfile.write(str(len(line)) + "\n")

infile.close()
outfile.close()