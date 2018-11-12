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
import gridSearch

import argparse

def orderColumns(tab):
    cols = tab.columns.tolist()
    for field in conf.inputFileds:
        if not field in cols:
            raise ("Can t find column ", field, " in tab")
    cols = conf.inputFileds + [x for x in cols if x not in conf.inputFileds]
    tab =  tab[cols]
    if 'ScientificName' not in tab.keys() : # to be compatible with old file
        tab['ScientificName'] = tab['species']
    return tab

def cleanTab(tab, remove_duplicate):
    print("Len Tab with Nan {}".format(len(tab)))
    tab = tab.dropna(subset=conf.inputFileds)
    print("Len Tab without Nan {}".format(len(tab)))
    return tab 

def removeDuplicate(tab, remove_duplicate):
    if remove_duplicate :
        # conf.selectedField, "longitude", "latitude", "longitude", "latitude",
        column_dupli = [ "phosphate.csv" , "oxygen.csv", "salinity.csv", "temperature.csv","nitrate.csv"] 
        tab = tab.drop_duplicates(subset=column_dupli, keep="first")
        print("Len Tab without duplicate {}".format(len(tab)))
    return tab 

def addOutputColumn(tab, minSampleSize=2000):
    print('adding output column')
    print(tab.keys())

    tab['counts'] = tab.groupby(conf.selectedField)[conf.selectedField].transform('count')  
    tab = tab[tab.counts > minSampleSize] # select all element that have at least $minSampleSize element
    print('have', len(tab.groupby(conf.selectedField).size()), 'type with more than', minSampleSize, 'sample')
    tab = tab.assign(output=(tab[conf.selectedField]).astype('category').cat.codes) #add unique id to each scientific name
    return tab

def prepareData(data, remove_duplicate, min_sample_size):
    # tab = data[key]
    tab = orderColumns(data)
    tab = cleanTab(data, remove_duplicate)
    tab = removeDuplicate(tab, remove_duplicate)
    tab = addOutputColumn(tab, min_sample_size)
    x, y = getInputOutput(tab)

    return x,y, tab

def describe(x, y):
    unique, counts = np.unique(y, return_counts=True)
    print(unique, counts)
    print('Mean output: ', np.mean(counts), "\nRange: ", np.ptp(counts), "\nMax: ", np.amax(counts), "\nMin: ", np.amin(counts))


def makeStandardization(x_train, x_test):
    # Standardization
    scaler = preprocessing.StandardScaler().fit(x_train) # StandardScaler
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
    new_file = os.path.join(path_save_out_csv, "coraux_geo.csv")
    data.to_csv(new_file, sep=",", encoding = 'utf-8', index=False)


def process(data, args):  
    if args.save_input_csv:
        save_out_csv(data)
    
    x,y, tab = prepareData(data, args.remove_duplicate, args.min_sample_size)
    util.write_data_by_name(x,y, util.get_idx2label(tab))
    # util.write_data(x, y, util.get_idx2label(tab))
    outputNb = len(tab[conf.selectedField].unique())
    labels = sorted(tab[conf.selectedField].unique()) #why sorted ? ED:because "astype('category').cat.codes" sorts the values
    print ("%s"%(labels))

    x_train, x_test, y_train, y_test = train_test_split(x, y, random_state=42, test_size=0.1)
    info_run = {'init_tab':len(data), 'x':len(x), 'x_train':len(x_train), 'x_test':len(x_test), 'nb_classes': outputNb}
    info_run.update(vars(args))
    info_run.update({"inputField": conf.inputFileds, "outputField": conf.selectedField})
    print("Before balance: ")
    describe(x_train, y_train)

    if args.do_standardization:
        print("Make Standardization")
        x_train, x_test = makeStandardization(x_train, x_test)

    if args.do_balance_smote:
        x_train, y_train = balanceTool.smote(x_train, y_train)
        print("After balance: ")
        describe(x_train, y_train)
    util.write_data_by_name(x_train, y_train, util.get_idx2label(tab))
    # x_train = x_train[:1000]
    # y_train = y_train[:1000]

    if args.run_multiple_config:
        
        msp = gridSearch.MultiSearchParam()
        grid_results = msp.run_search(x_train, y_train, outputNb)
        # clf = grid_results.best_estimator_
        
        # Evaluate on Test data with the best network
        params = grid_results.best_params_
        best_model = gridSearch.create_best_model(outputNb, params)
        best_model.fit(x_train, y_train, epochs=params['epochs'], batch_size=params['batch_size'])
        best_model.summary()
        pred_best = best_model.predict_classes(x_test)
        
        #To move 
        from sklearn.metrics import accuracy_score
        print("Test final with the best of the best: %2.4f"%(accuracy_score(y_test, pred_best)))
        
        # Write results
        gridSearch.write_report(info_run, grid_results)
        # for param in ["activation", "epochs", "optimizers", "init_mode"]:
        #     mutipleNetwork.gridSearch_table_plot(grid_results, param)

    else:
        nn = neuralNetwork.NeuralNetwork(outputNb)
        nn.train(x_train, y_train, epochs=args.epochs)
        # scores = nn.evaluate(x_test, y_test)
        results = nn.test(x_test, y_test, labels)
        neuralNetwork.write_report_unique(info_run, results)


def main():
    parser = argparse.ArgumentParser(description='Process some networks')
    parser.add_argument('--epochs', '-e', type=int, default=100, help='nb epochs')
    parser.add_argument('--dir_input', default='data/out')
    parser.add_argument('--save_input_csv', action='store_true')
    parser.add_argument('--do_standardization', '-s,', action='store_true')
    parser.add_argument('--do_balance_smote', '-b,', action='store_true')
    parser.add_argument('--remove_duplicate', '-d,', action='store_true')
    parser.add_argument('--run_multiple_config', '-r,', action='store_true')
    parser.add_argument('--config_multiple', default="config.json")
    parser.add_argument('--min_sample_size', '-n', type=int, default=2000)

    args = parser.parse_args()
    print(args)

    if (args.file_input):
        data = tools.simpleLoad(args.file_input)
        process(data, args)
    else:
        data = tools.load(args.dir_input)
        for key in data:
            process(data[key], args)

if __name__=="__main__":
    main()

