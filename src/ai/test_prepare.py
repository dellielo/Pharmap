
import tensorflow as tf
from tensorflow.python.framework import tensor_util


VERSION_MODEL = "1"
DIR_EXTRA_INFO = "Pharmap/data/bestModel/model1/"+ VERSION_MODEL 

import util
import argparse

import numpy as np 
import os 
import pprint

def do_inference(dir_extra_info):
    idx2label, scaler = util.load_extra_info(dir_extra_info)
    print(type(idx2label), idx2label['0'])
    inp_1 = [9.62174267, 109, 1.83314993, 3.38175554, 33.7950944, 20.76361192] # Ptilosarcus gurneyi
    inp_2 = [4.655654, 660, 2.946845, 0.520219, 34.254101, 42.145364] # Heteropolypus ritteri
    inp_3 = [4.208168562365363, 914, 3.2018021623, 0.5074285316, 34.414465499, 43.407423898496646] # Heteropoly$
    
    inputs = [inp_1]
    inputs = scaler.transform(inputs) # the scaler must be the same as during the training !
    #print(tf.make_tensor_proto(inputs, dtype=np.float32))
    print(inputs)

do_inference(DIR_EXTRA_INFO)
