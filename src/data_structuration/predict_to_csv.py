import json
import os
import pprint
import sys
import numpy as np

def json_to_array(file_path):
    with open(file_path) as f:
        lines = f.readlines()
        for line in lines:
            v = json.loads(line)
	    if "array" not in locals():
                array = np.array(list(v.values()))
            else:
                array = np.vstack( ( array, np.array(list(v.values())) ))
    return array

def nn_class_to_columns(file_path):
    with open(file_path) as f:
       columns = []
       lines = f.read().splitlines()
       for line in lines:
           columns.append(line)
    return columns

def predict_to_csv(predict_path, class_path, out_path):
    array = json_to_array(predict_path)
    col - nn_class_to_columns(class_path)
    df = pd.DataFrame(array, columns=col)
    df.to_csv(out_path)
