#import tensorflow as tf
#from tensorflow import keras
import sys
sys.path.insert(0, './src/data_structuration/')
import tools
# https://imbalanced-learn.readthedocs.io/en/stable/over_sampling.html
from imblearn.over_sampling import SMOTE, ADASYN, BorderlineSMOTE
import numpy as np
import conf
import neuralNetwork
from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn import preprocessing
from keras_pandas.Automater import Automater
import balanceTool

def orderColumns(tab):
    cols = tab.columns.tolist()
    for field in conf.inputFileds:
        if not field in cols:
            raise ("Can t find column ", field, " in tab")
    cols = conf.inputFileds + [x for x in cols if x not in conf.inputFileds]
    return tab[cols]

def cleanTab(tab):
    print("Len Tab with Nan {}".format(len(tab)))
    tab = tab.dropna(subset=conf.inputFileds)
    print("Len Tab without Nan {}".format(len(tab)))
    column_dupli =["longitude", "latitude", "phosphate.csv" , "oxygen.csv", "salinity.csv", "temperature.csv","nitrate.csv"]
    tab_1 = tab.drop_duplicates(subset=column_dupli)
    print("Len Tab without duplicate {}".format(len(tab_1)))
    return tab_1 

def addOutputColumn(tab):
    print('adding output column')
    minSampleSize = 2000 
    tab['counts'] = tab.groupby('ScientificName')['ScientificName'].transform('count') #add coulumn counts
    tab = tab[tab.counts > minSampleSize] # select all element that have at least $minSampleSize element
    print('have', len(tab.groupby('ScientificName').size()), 'type with more than', minSampleSize, 'sample')
    tab = tab.assign(output=(tab['ScientificName']).astype('category').cat.codes) #add unique id to each scientific name
    return tab

def describe(x, y):
    unique, counts = np.unique(y, return_counts=True)
    print(unique, counts)
    print('Mean output: ', np.mean(counts), "\nRange: ", np.ptp(counts), "\nMax: ", np.amax(counts), "\nMin: ", np.amin(counts))

def getInputOutput(tab):
    x = tab.loc[:,conf.inputFileds].values
    y = tab.loc[:,conf.outputField].values
    return (x, y)

def makeOverSamples(X,y):
    sm = SMOTE()
    X, y = sm.fit_resample(X, y)
    return X,y

def makeStandardization(x_train, x_test):
    scaler = preprocessing.StandardScaler().fit(x_train)
    x_train = scaler.transform(x_train)
    x_test = scaler.transform(x_test)
    return x_train, x_test

if __name__=="__main__":
    data = tools.load('./data/out/')
    for key in data:
        tab = data[key]
        tab = orderColumns(tab)
        tab = cleanTab(tab)
        tab = addOutputColumn(tab)
        df = tab.reset_index(inplace=True)
        x, y = getInputOutput(tab)
        
        x_train, x_test, y_train, y_test = train_test_split(x, y, random_state=42, test_size=0.25)
        # x_train, X_val, y_train, y_val = train_test_split(x_train, y_train, test_size=0.2, random_state=1)


        # Standardization 
        x_test_ori = x_test
        x_train_ori = x_train

        from imblearn.under_sampling import NearMiss
        nm1 = NearMiss(version=1)
        
        x_train, y_train = balanceTool.smote(x_train, y_train)
        print("After balance: ")
        describe(x_train, y_train)

        x_train, x_test = makeStandardization(x_train, x_test)
        # x_train, y_train = nm1.fit_resample(x_train, y_train)
        print("## info data : train {}, unique {}, test:{}".format(len(x_train), len(x_train_ori), len(x_test)))
        #x_train, y_train = makeOverSamples(x_train, y_train)
        outputNb = len(tab[conf.outputField].unique()) 
        
        nn = neuralNetwork.NeuralNetwork(outputNb)
        nn.train(x_train, y_train, epochs=10)
        nn.evaluate(x_test, y_test)



        y_pred = nn.predict_classes(x_test)
        prob = nn.predict(x_test)



        labels = sorted(tab['ScientificName'].unique())
        idx2label = dict((v,k) for k,v in zip(labels, range(0,outputNb)))
        errors = np.where(y_pred != y_test)[0]
        print("No of errors = {}/{}".format(len(errors),len(y_test)))

        for i, t in enumerate(set(y_test)):
            idx = np.where(y_test == t)[0]
            coraux = idx2label[t]
            
            with open("{}_res.csv".format(coraux), 'w') as fic:
                fic.write("true; pred; sanction; carac\n")
                
                for index, item in enumerate(idx):
                    pred_class = np.argmax(prob[item])
                    true_label = idx2label[y_test[item]]
                    pred_label = idx2label[pred_class]
                    sanction = "OK" if true_label == pred_label else "ERROR"

                    lat = tab['longitude'][item]
                    long = tab['latitude'][item]
                    str_data = ",".join("{:.2f}".format(x) for x in x_test_ori[item])
                    fic.write("position[{}] {}, {},{}\n".format(index, true_label, lat, long))
                    fic.write("detection {},{}, {},{}\n".format(true_label, pred_label,sanction, str_data)) # x_test[item],

            idx_train = np.where(y_train == t)[0]
            nb_data_train_ori = len(x_train[idx_train])
            nb_data_train_ori_uni = len(np.unique(x_train[idx_train], axis=0))
            nb_data_test_ori = len(x_test_ori[idx])
            nb_data_test_ori_uni = len(np.unique(x_test_ori[idx], axis=0))
            p_train = (nb_data_train_ori_uni/float(nb_data_train_ori)) *100
            p_test = (nb_data_test_ori_uni/float(nb_data_test_ori)) *100
            print("{}:{}/{} {:.2f}/%;{}/{} {:.2f}/%\n".format(coraux, nb_data_train_ori, nb_data_train_ori_uni, 
                    p_train, nb_data_test_ori, nb_data_test_ori_uni, p_test))
    
        for i in range(len(errors[:5])):
            pred_class = np.argmax(prob[errors[i]])
            pred_label = idx2label[pred_class]
            true_label = idx2label[y_test[errors[i]]]

            print('Original label: [{}], Prediction :[{}], confidence : {:.3f}'.format(
                true_label,
                pred_label,
                prob[errors[i]][pred_class]))
            
        print (metrics.classification_report(y_test, y_pred, target_names=labels))

        