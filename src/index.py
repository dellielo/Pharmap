import matplotlib.pyplot as plt
import numpy as np
import geopandas

path = geopandas.datasets.get_path('naturalearth_lowres')
landmap = geopandas.read_file(path)

def display(geomap):
    ax = geomap.plot(color = "grey", linewidth = 0, figsize=(10,10))
    plt.show(ax)

display(landmap)

#print(landmap.head(n=2))
#print(landmap.dtypes)
#print('--------')
#print(landmap.)