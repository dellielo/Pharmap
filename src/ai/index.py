from __future__ import print_function
import sys
sys.path.insert(0, './src/data_structuration/')
import os

import numpy as np
import pandas as pd
from sklearn import preprocessing
from sklearn.model_selection import train_test_split


import balanceTool
import conf
import neuralNetwork
import tools
import util
import mutipleNetwork

import argparse

def orderColumns(tab):
    cols = tab.columns.tolist()
    for field in conf.inputFileds:
        if not field in cols:
            raise ("Can t find column ", field, " in tab")
    cols = conf.inputFileds + [x for x in cols if x not in conf.inputFileds]
    return tab[cols]

def cleanTab(tab, remove_duplicate):
    print("Len Tab with Nan {}".format(len(tab)))
    #
    if remove_duplicate :
        column_dupli = ["ScientificName", "longitude", "latitude", "phosphate.csv" , "oxygen.csv", "salinity.csv", "temperature.csv","nitrate.csv"] 
        tab = tab.drop_duplicates(subset=column_dupli, keep="first")
        print("Len Tab without duplicate {}".format(len(tab)))

    tab = tab.dropna(subset=conf.inputFileds)
    print("Len Tab without Nan {}".format(len(tab)))
    
    return tab 

def addOutputColumn(tab):
    print('adding output column')
    minSampleSize = 2000 
    print(tab.keys())

    if 'ScientificName' not in tab.keys() : # to be compatible with old file
        tab['ScientificName'] = tab['species_id']

    tab['counts'] = tab.groupby('ScientificName')['ScientificName'].transform('count') #add coulumn counts
    tab = tab[tab.counts > minSampleSize] # select all element that have at least $minSampleSize element
    print('have', len(tab.groupby(conf.selectedField).size()), 'type with more than', minSampleSize, 'sample')
    tab = tab.assign(output=(tab[conf.selectedField]).astype('category').cat.codes) #add unique id to each scientific name
    return tab

def prepareData(data, remove_duplicate):
    # tab = data[key]
    tab = orderColumns(data)
    tab = cleanTab(tab, remove_duplicate)
    tab = addOutputColumn(tab)
    x, y = getInputOutput(tab)

    return x,y, tab

def describe(x, y):
    unique, counts = np.unique(y, return_counts=True)
    print(unique, counts)
    print('Mean output: ', np.mean(counts), "\nRange: ", np.ptp(counts), "\nMax: ", np.amax(counts), "\nMin: ", np.amin(counts))


def makeStandardization(x_train, x_test):
    # Standardization
    scaler = preprocessing.StandardScaler().fit(x_train)
    x_train = scaler.transform(x_train)
    x_test = scaler.transform(x_test)
    return x_train, x_test


def getInputOutput(tab):
    x = tab.loc[:,conf.inputFileds].values
    y = tab.loc[:,conf.outputField].values
    return (x, y)


def save_out_csv(data):
    path_save_out_csv = 'data/out_csv'
    if not os.path.exists(path_save_out_csv):
        os.makedirs(path_save_out_csv)
    data.to_csv(os.path.join(path_save_out_csv, "coraux_geo.csv"), sep=",", encoding = 'utf-8', index=False)


def process(args):  
    data = tools.load(args.dir_input)
    for key in data:
        save_out_csv(data[key])

        x,y, tab = prepareData(data[key], args.remove_duplicate)
        util.write_data_by_name(x,y, util.get_idx2label(tab))
        util.write_data(x, y, util.get_idx2label(tab))
        x_train, x_test, y_train, y_test = train_test_split(x, y, random_state=42, test_size=0.1)

        outputNb = len(tab[conf.outputField].unique())
        labels = sorted(tab[conf.selectedField].unique()) #why sorted ?

        print("Before balance: ")
        describe(x_train, y_train)

        if args.do_standardization:
            print("Make Standardization")
            x_train, x_test = makeStandardization(x_train, x_test)

        if args.do_balance_smote:
            x_train, y_train = balanceTool.smote(x_train, y_train)
            print("After balance: ")
            describe(x_train, y_train)
    
        x_train = x_train[:1000]
        y_train = y_train[:1000]

        if args.run_multiple_config:
            
            msp = mutipleNetwork.MultiSearchParam()
            grid_results = msp.run_search(x_train, y_train, outputNb)
            # clf = grid_results.best_estimator_
            
            # Evaluate on Test data with the best network
            params = grid_results.best_params_
            best_model = mutipleNetwork.create_best_model(outputNb, params)
            best_model.fit(x_train, y_train, epochs=params['epochs'], batch_size=params['batch_size'])
            best_model.summary()
            pred_best = best_model.predict_classes(x_test)
            
            #To move 
            from sklearn.metrics import accuracy_score
            print("Test final with the best of the best: %2.4f"%(accuracy_score(y_test, pred_best)))
            
            # Write results
            msp.write_report(args, grid_results)
            # for param in ["activation", "epochs", "optimizers", "init_mode"]:
            #     mutipleNetwork.gridSearch_table_plot(grid_results, param)

        else:
            nn = neuralNetwork.NeuralNetwork(outputNb)
            nn.train(x_train, y_train, epochs=args.epochs)

            scores = nn.evaluate(x_test, y_test)
            nn.test(x_test, y_test, labels)


def main():
    parser = argparse.ArgumentParser(description='Process some networks')
    parser.add_argument('--epochs', type=int, default=100, help='nb epochs')
    parser.add_argument('--dir_input', default='data/out')
    parser.add_argument('--do_standardization', '-s,', action='store_true')
    parser.add_argument('--do_balance_smote', '-b,', action='store_true')
    parser.add_argument('--remove_duplicate', '-d,', action='store_true')
    parser.add_argument('--run_multiple_config', '-r,', action='store_true')
    parser.add_argument('--config_multiple', default="config.json")
    args = parser.parse_args()
    print(args)
    process(args)

if __name__=="__main__":
    main()    
