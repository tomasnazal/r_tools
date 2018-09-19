# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import os
import pandas as pd

data_list = []

for filename in os.listdir(os.getcwd()):
    print(filename)
    print(os.path.getsize(filename))
    if filename.endswith('.py'):
        pass
        print('pass')
    else:
        with open(filename, 'r') as file:
            for line in file:
                row = line.split('\t')
                data_list.append(row)
        
    
progressive  = pd.DataFrame(data_list)
progressive.to_csv('progressive.csv', encoding = 'utf-8')
