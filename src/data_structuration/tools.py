import os
from os import listdir
from os.path import join
import config
import geopandas as gpd
import pandas as pd
from glob import glob

def simpleLoad(path, header=0, separator=','):
    path = join(path)
    extension = path.split('.')[-1]
    if extension in config.extension["geo"]:
        d = gpd.read_file(path)
    elif extension in config.extension["tab"]:
        d = pd.read_csv(join(path), low_memory=False, header=header, sep=separator)
    else:
        raise ValueError('Unknown extension')
    print("Succesfuly loaded " + path)
    return d

def load(dataDir, header=0, separator=','):
    data = {}
    for f in listdir(dataDir):
        path = join(dataDir, f)
        try:
            d = simpleLoad(path, header, separator)
            data[f] = d
        except Exception as e:
            print("An error occured while loading " + path, e)
    return (data)

def save(tab, dirName, filename):
    tab.to_file(join(dirName, filename), driver='GeoJSON')

def save_out_csv(tab, dirname, filename):
    if not os.path.exists(dirname):
        os.makedirs(dirname)
    tab.to_csv(os.path.join(dirname, filename), sep=",", encoding = 'utf-8') #, index=False)

def multipleTabSave(tabs, dirName):
    for name, tab in tabs.items():
        save(tab, dirName, name)

notFound = 0


def select_rasters(path):
    rasters = glob(path+"*.tif")+glob(path+"*.nc")
    return rasters
    
def select_csv(path):
    csv = glob(path+"*.csv")
    return csv
    
def getname(file):
    return os.path.splitext(os.path.basename(file))[0]

def getpath(file):
    name = os.path.basename(file)
    path = file[:-len(name)]
    return path

def getmeta(file):
    """
    return metadata file of given file
    """
    name = getname(file)
    path = getpath(file)
    print(path, name)
    meta = glob(path+name+".csv.metadata")[0] #There should be only one meta.
    return meta

