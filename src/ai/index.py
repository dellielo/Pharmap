from __future__ import print_function
import sys
sys.path.insert(0, './src/data_structuration/')
import os

import numpy as np
import pandas as pd

import dataManage


import balanceTool
import conf
import neuralNetwork
import tools
import util
import gridSearch

import argparse


# def prepareData(tab, remove_duplicate, min_sample_size, keyTaxonRk):
#     # tab = data[key]
#     tab = filterTaxonRank(tab, keyTaxonRk)
#     tab = orderColumns(tab)
#     tab = cleanTab(tab, remove_duplicate)
#     tab = removeDuplicate(tab, remove_duplicate)
#     tab = addOutputColumn(tab, min_sample_size)
#     x, y = getInputOutput(tab)

#     return x,y, tab


def save_out_csv(data):
    path_save_out_csv = 'data/out_csv'
    if not os.path.exists(path_save_out_csv):
        os.makedirs(path_save_out_csv)
    new_file = os.path.join(path_save_out_csv, "coraux_geo.csv")
    data.to_csv(new_file, sep=",", encoding = 'utf-8', index=False)


def process(data, args):  
    if args.save_input_csv:
        save_out_csv(data)

    dm = dataManage.ManageData(data)
    dm.prepareData(args.remove_duplicate, args.min_sample_size, args.filter_taxon_rank)
    x_train, x_test, y_train, y_test = dm.split_train_test()
    util.write_data_by_name(dm.tab, dm.y, dm.idx2label) # util.get_idx2label(tab)) /!\ to move!
    # util.write_data(x, y, util.get_idx2label(tab))


    info_run = {'init_tab':len(data),  'x_train':len(x_train), 'x_test':len(x_test), 'nb_classes': dm.nb_labels} #'x':len(x),
    info_run.update(vars(args))
    info_run.update({"inputFields": conf.inputFields, "outputField": conf.selectedField})
    print("Before balance: ")
    dataManage.describe(y_train)

    if args.do_standardization:
        print("Make Standardization")
        x_train, x_test = dataManage.makeStandardization(x_train, x_test)

    if args.do_balance_smote:
        x_train, y_train = balanceTool.smote(x_train, y_train)
        print("After balance: ")
        dataManage.describe(y_train)
        
    # x_train = x_train[:1000]
    # y_train = y_train[:1000]
    x_train_data = dataManage.getInputColumn(x_train)
    if args.run_multiple_config:
        
        msp = gridSearch.MultiSearchParam()
        grid_results, best_params = msp.run_search(x_train_data, y_train, dm.nb_labels)
        # clf = grid_results.best_estimator_
        
        # Evaluate on Test data with the best network
        params = best_params
        best_model = gridSearch.create_best_model(dm.nb_labels, params)

        best_model.fit(x_train_data, y_train, epochs=params['epochs'], batch_size=params['batch_size'])
        best_model.summary()
        pred_best = best_model.predict_classes(dataManage.getInputColumn(x_test))
        util.save_model(best_model)
        #To move 
        from sklearn.metrics import accuracy_score
        print("Test final with the best of the best: %2.4f"%(accuracy_score(y_test, pred_best)))
        
        # Write results
        gridSearch.write_report(info_run, grid_results)
        # for param in ["activation", "epochs", "optimizers", "init_mode"]:
        #     mutipleNetwork.gridSearch_table_plot(grid_results, param)

    else:
        nn = neuralNetwork.NeuralNetwork(dm.nb_labels)
        nn.train(x_train_data, y_train, epochs=args.epochs)
        # scores = nn.evaluate(x_test, y_test)
        results = nn.test(dataManage.getInputColumn(x_test), y_test, dm.idx2label)
        neuralNetwork.write_report_unique(info_run, results)


def main():
    parser = argparse.ArgumentParser(description='Process some networks')
    parser.add_argument('--epochs', '-e', type=int, default=100, help='nb epochs')
    parser.add_argument('--dir_input', default='data/out')
    parser.add_argument('--file_input', default='data/out/coraux_geov2.csv', help='input file')
    parser.add_argument('--save_input_csv', action='store_true')
    parser.add_argument('--do_standardization', '-s,', action='store_true')
    parser.add_argument('--do_balance_smote', '-b,', action='store_true')
    parser.add_argument('--remove_duplicate', '-d,', action='store_true')
    parser.add_argument('--run_multiple_config', '-r,', action='store_true')
    parser.add_argument('--config_multiple', default="config.json")
    parser.add_argument('--min_sample_size', '-n', type=int, default=2000)
    parser.add_argument('--filter_taxon_rank',default=None, type=str, choices=["species", "genus", "order", "family", "class"])
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

