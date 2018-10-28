#import tensorflow as tf
#from tensorflow import keras
import sys
sys.path.insert(0, './src/data_structuration/')
import tools
import conf
import neuralNetwork
from sklearn.model_selection import train_test_split
from keras_pandas.Automater import Automater

def orderColumns(tab):
    cols = tab.columns.tolist()
    for field in conf.inputFileds:
        if not field in cols:
            raise ("Can t find column ", field, " in tab")
    cols = conf.inputFileds + [x for x in cols if x not in conf.inputFileds]
    return tab[cols]

def cleanTab(tab):
    return tab.dropna(subset=conf.inputFileds)

def addOutputColumn(tab):
    print('adding output column')
    minSampleSize = 2000
    tab['counts'] = tab.groupby('ScientificName')['ScientificName'].transform('count') #add coulumn counts
    tab = tab[tab.counts > minSampleSize] # select all element that have at least $minSampleSize element
    print('have', len(tab.groupby('counts').size()), 'type with more than', minSampleSize, 'sample')
    tab = tab.assign(output=(tab['ScientificName']).astype('category').cat.codes) #add unique id to each scientific name
    return tab

def getInputOutput(tab):

    x = tab.loc[:,conf.inputFileds].values
    y = tab.loc[:,conf.outputField].values

    return (x, y)

if __name__=="__main__":
    data = tools.load('./data/out/')
    for key in data:
        tab = data[key]
        tab = orderColumns(tab)
        tab = cleanTab(tab)
        tab = addOutputColumn(tab)
        x, y = getInputOutput(tab)
        x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.1)
        outputNb = tab[conf.outputField].max() + 1 # +1 beacuase index start at 0
        nn = neuralNetwork.NeuralNetwork(outputNb)
        nn.train(x_train, y_train)
        nn.evaluate(x_test, y_test)