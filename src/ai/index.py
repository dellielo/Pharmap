#import tensorflow as tf
#from tensorflow import keras
import sys
sys.path.insert(0, './src/data_structuration/')
import tools
import conf

def selectTrainData(mainTab):
    print(mainTab.columns)
    selectedFields = []
    for field in conf.inputFileds:
        if field in mainTab.columns:
            selectedFields.append(field)
        else:
            print("Can t find column ", field, " in mainTab")
    newTab =  mainTab.loc[:,selectedFields]
    return newTab

if __name__=="__main__":
    data = tools.load(conf.aiDataDir)
    mainTable = data['coraux_geo.geojson']
    print(newTab)
    selectTrainData(mainTable)