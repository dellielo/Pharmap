from os import listdir
from os.path import join
import config
import geopandas

def meanTab(tab):
    total = 0
    length = 0
    for c in tab.columns:
        total += tab[c].sum()
        length += tab[c].count()
    return total / length

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

notFound = 0