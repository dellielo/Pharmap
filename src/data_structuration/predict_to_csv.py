import json
import os
import pprint
import sys
import argparse
import numpy as np
import pandas as pd

def json_to_array(file_path):
    with open(file_path) as f:
        lines = f.readlines()
        for line in lines:
            v = json.loads(line)
            if "array" not in locals(): #if first line
                array = np.array(list(v.values()))
                print(sum(list(v.values())[0]))
            else:
                print(sum(list(v.values())[0]))
                array = np.vstack( ( array, np.array(list(v.values())) )) #else lets add this new row
    
    #We remove near zero values, to quickly check if sp is present or not and reduce number of relationship
    nz_filter = np.vectorize(lambda x: x if x<1E-6 else x)
    array = nz_filter(array)
    
    return array

def nn_class_to_columns(file_path):
    with open(file_path) as f:
       columns = []
       lines = f.read().splitlines() #to avoid \n
       for line in lines:
           columns.append(line)
    return columns

def predict_to_csv(predict_path, class_path, out_path):
    array = json_to_array(predict_path)
    col = nn_class_to_columns(class_path)
    df = pd.DataFrame(array, columns=col)
    df.to_csv(out_path)

def main():
    parser = argparse.ArgumentParser(description='make google ML engine output readable for neo4j and/or raster integration')
    parser.add_argument('--path_predict', default="predict")
    parser.add_argument('--path_class', default="classes.txt")
    parser.add_argument('--output', default="default_out")
    
    args = parser.parse_args()
    
    predict_to_csv(args.path_predict, args.path_class, args.output)

if __name__=="__main__":
    main()  
    #predict_to_csv("/home/idiot_cr0w/micro.json", "/home/idiot_cr0w/Pharmap/data/bestModel/model3/classes.txt", "test.csv")
