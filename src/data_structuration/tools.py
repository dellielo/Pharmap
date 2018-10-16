from os import listdir
from os.path import join
import config
from itertools import itertools
import geopandas as gpd
import pandas as pd

def load(dataDir):
    data = {}
    for f in listdir(dataDir):
        extension = f.split('.')[-1]
        if extension not in list(chain.from_iterable(config.extension.values())):
            continue
        path = join(dataDir, f)
	if extension in config.extension["geo"]:
	    try:
	        d = gpd.read_file(path)
	        data[f] = d
	        print("Succesfuly loaded " + path)
        except Exception as e:
            print("An error occured while loading " + path, e)
    elif extension in config.extension["tab"]:
	    try:
		d = pd.read_csv(path)
                data[f] = d
                print("Succesfuly loaded " + path)
        except Exception as e:
            print("An error occured while loading " + path, e)

	else:
	    raise:
	        print("Failed to read file type")
	
    return (data)

def save(tab, dirName, filename):
    tab.to_file(join(dirName, filename), driver='GeoJSON')

def multipleTabSave(tabs, dirName):
    for name, tab in tabs.items():
        save(tab, dirName, name)
