from os import listdir
from os.path import join
import config
import geopandas

def load(dataDir):
    data = {}
    for f in listdir(dataDir):
        extension = f.split('.')[-1]
        if extension not in config.extension:
            continue
        path = join(dataDir, f)
        try:
            d = geopandas.read_file(path)
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