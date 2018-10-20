from os import listdir
from os.path import join
import config
import geopandas as gpd
import pandas as pd

def load(dataDir, header=0):
    data = {}
    for f in listdir(dataDir):
        extension = f.split('.')[-1]
        path = join(dataDir, f)
        try:
            if extension in config.extension["geo"]:
                d = gpd.read_file(path)
            elif extension in config.extension["tab"]:
                d = pd.read_csv(path, low_memory=False, header=header)
            else:
                continue
            data[f] = d
            print("Succesfuly loaded " + path)
        except Exception as e:
            print("An error occured while loading " + path, e)
    return (data)

def save(tab, dirName, filename):
    tab.to_file(join(dirName, filename), driver='GeoJSON')

def multipleTabSave(tabs, dirName):
    for name, tab in tabs.items():
        save(tab, dirName, name)

notFound = 0