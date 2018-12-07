import tensorflow as tf
import grpc
from tensorflow_serving.apis import predict_pb2
from tensorflow_serving.apis import prediction_service_pb2_grpc

# from grpc.beta import implementations
# from tensorflow_serving.apis import predict_pb2
# from tensorflow_serving.apis import prediction_service_pb2
from tensorflow.python.framework import tensor_util

import util
import argparse

import numpy as np 
import os 
import pprint

# pip install tensorflow-serving-api
# launch the following command: >> tensorflow_model_server --port=9000 --model_name=pharmap_model1 --model_base_path=/data/bestModel/model1
# and in other terminal: >> python src/ai/test_serving_tf.py 

VERSION_MODEL = "1"
DIR_EXTRA_INFO = "data/bestModel/model1/"+ VERSION_MODEL 
SERVER = "localhost"
PORT = 9000

def get_n_best_pred_for_one_item(probs, n, idx2label):
    results = {}
    best_n = np.argsort(probs)[-n:][::-1]
    for index, best_id in enumerate(best_n):
        results[index] = {'label_pred':idx2label[str(best_id)], 'prob': probs[best_id]}
    return results


def do_inference(hostport, dir_extra_info):
    idx2label, scaler = util.load_extra_info(dir_extra_info)
    print(type(idx2label), idx2label['0'])
    # channel = implementations.insecure_channel(hostport) 
    channel = grpc.insecure_channel(hostport)
    stub = prediction_service_pb2_grpc.PredictionServiceStub(channel)
    # stub = prediction_service_pb2.beta_create_PredictionService_stub(channel)

    request = predict_pb2.PredictRequest()
    
    request.model_spec.name = "Pharmap"

    # exemples of raw inputs
    inp_1 = [9.62174267, 109, 1.83314993, 3.38175554, 33.7950944, 20.76361192] # Ptilosarcus gurneyi
    inp_2 = [4.655654, 660, 2.946845, 0.520219, 34.254101, 42.145364] # Heteropolypus ritteri
    inp_3 = [4.208168562365363,	914, 3.2018021623, 0.5074285316, 34.414465499, 43.407423898496646] # Heteropolypus ritteri
    
    inputs = [inp_1, inp_2, inp_3]
    inputs = scaler.transform(inputs) # the scaler must be the same as during the training !
    
    request.inputs['input'].CopyFrom(tf.make_tensor_proto(inputs, dtype=np.float32))

    # 60 is the timeout in seconds, but its blazing fast
    result = stub.Predict(request, 60.0) 
    res_np = tensor_util.MakeNdarray(result.outputs['scores'])


    print(res_np.shape)
    for n in range(0, res_np.shape[0]):
        print(" ****** ")
        pprint.pprint(get_n_best_pred_for_one_item(res_np[n,:], 5, idx2label))


def main():
    parser = argparse.ArgumentParser(description='A client that talks to tensorflow_model_server loaded with "pharmap" model')
    parser.add_argument('--hostport', default="localhost:9000")
    parser.add_argument('--dir_extra_info', default=DIR_EXTRA_INFO)
    args = parser.parse_args()
    do_inference(args.hostport, args.dir_extra_info)

if __name__=="__main__":
    main()
