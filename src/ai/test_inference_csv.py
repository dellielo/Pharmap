import argparse
import pandas as pd
import util 
import json 
import os 
import pprint
import numpy as np 

VERSION_MODEL = "1"
DIR_EXTRA_INFO = "data/bestModel/{}/"+ VERSION_MODEL 
input_fields = ['temperature', 'a_depth', 'phosphate', 'oxygen', 'salinity', 'nitrate']


def get_n_best_pred_for_one_item(probs, n, idx2label):
    results = {}
    best_n = np.argsort(probs)[-n:][::-1]
    for index, best_id in enumerate(best_n):
        results[index] = {'label_pred':idx2label[str(best_id)], 'prob': probs[best_id]}
    return results

def convert_csv_to_json(path_csv, scaler):
    data_json = {}
    data_json['input'] = []
    df = pd.read_csv(path_csv)
    df = df.dropna(subset=input_fields)
    x = df.loc[:,input_fields].values
    name_json = "input.json"
    x_scaler = scaler.transform(x)

    with open(name_json, 'w') as fic:
        for data in x_scaler:     
            data_json = {}
            data_json = {'input': data.tolist()}
            json.dump(data_json, fic,)
            fic.write('\n')
    return name_json

def launch_command(name_model, name_json, name_output="results_gcloud.txt"):
    cmd = "gcloud ml-engine predict --model pharmap_{name_model} --json-instances {name_json} > {name_output}".format(
        name_model = name_model,
        name_json = name_json,
        name_output = name_output
    )
    #TODO: change , i'm not sure it is the best way, bu it works
    os.system(cmd)

def do_inference(args):
    name_output = "results_gcloud.txt"
    dir_extra_info_local = DIR_EXTRA_INFO.format(args.model)
    idx2label, scaler = util.load_extra_info(dir_extra_info_local)

    name_json = convert_csv_to_json(args.path_csv, scaler)
    launch_command(args.model, name_json, name_output)

    with open(name_output, 'r') as fic:
        #don't work, i don't know this format
        scores = json.load(fic)
       
    for n in range(0, scores.shape[0]):
        print(" ****** ")
        pprint.pprint(get_n_best_pred_for_one_item(scores[n,:], 5, idx2label))

def main():
    parser = argparse.ArgumentParser(description='A client that run inference fom csv file on gcloud with "pharmap" model')
    parser.add_argument('--path_csv', default="file.csv")
    parser.add_argument('--model', default="model1", choices=["model1", "model2", "model3"])
    args = parser.parse_args()
    do_inference(args)

if __name__=="__main__":
    main()