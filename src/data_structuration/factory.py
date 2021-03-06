import time
import config
import tools
import numpy as np
import pandas as pd
import math
import gdal
import affine
import multiprocessing
from functools import partial
import rasterTools 

'''
CSV and df functions
'''
def formatNoaaTab(tab):
    newTab = tab.rename(columns=removeTrailingSpaces)
    newTab = newTab.rename(columns={'#COMMA SEPARATED LATITUDE':'latitude', "LONGITUDE":'longitude', 'AND VALUES AT DEPTHS (M):0':'0'})
    newTab = newTab.rename(columns=toNumber)
    return newTab


def formatCorailTab(tab):
    return tab.rename(columns={"ScientificName": 'species'})

def apply_environment_values(df, dir_path):   
    raster_files = tools.select_rasters(dir_path)
    raster_files.sort()
    for file in raster_files:
        print("Importing raster : " + file)
        filename = tools.getname(file)
        filemeta = tools.getmeta(file)

        raster = rasterTools.multi_band_raster(file, filemeta)
        if filemeta: #if it has depth metadata, search at given depth
            df[filename] = df.apply(lambda row: raster.get_coord_value((row.longitude, row.latitude, abs(row.a_depth))), axis=1)
        else: #if it is a monoband or without metadata, stick with first band
            df[filename] = df.apply(lambda row: raster.get_coord_value((row.longitude, row.latitude)), axis=1)
    csv_files = tools.select_csv(dir_path)
    for file in csv_files:
        print("Importing csv : " + file)
        filename = tools.getname(file)
        df_csv = pd.read_csv(file, skiprows=1)
        df_csv = formatNoaaTab(df_csv)
        df[filename] = df.apply(lambda row: compute_val(row.longitude, row.latitude, abs(row.a_depth), df_csv), axis=1)
    return df

def build_environment_dataframe(origin, extent, res, dir_path):
    '''
    origin is (longitude, latitude)
    extent is (x_lenght, y_length), beware, positive y goes up, negative goes down
    '''
    origin = np.array(origin)
    extent = np.array(extent)
    x_size,y_size = abs(extent)
    xo, yo = origin #origin coordinate
    xe, ye = origin+extent*res #endpoint coordinate
    half_res = res/2
    
    df = pd.DataFrame()
    
    df["px"] = np.repeat(np.arange(0,y_size), x_size) #adds pixel x position 
    df["py"] = np.tile(np.arange(0,x_size), y_size)   #adds pixel y position
    df["longitude"] = np.repeat(np.linspace(xo+half_res, xe-half_res, num=x_size), y_size) # get longitude at center of pixel
    df["latitude"] = np.tile(np.linspace(yo-half_res, ye+half_res, num=x_size), y_size)
    
    number_of_proc = tools.divide_by_proc(len(df))
    df_list = df_slices(df, number_of_proc)
    
    pool = multiprocessing.Pool(number_of_proc)
    total_tasks = number_of_proc
    apply_values = partial(apply_environment_values, dir_path=dir_path)
    results = pool.map_async(apply_values, df_list)
    pool.close()
    pool.join()
    results = results.get()
    result_df = pd.concat(results)
    return result_df
     
def computeRow(row, dataTab):
    tab = cropData(dataTab, row['latitude'], row['longitude'], row['DepthInMeters'])
    if (not tab.empty):
        if (config.method == "offset"):
            return meanTab(tab)
        elif (config.method == "nearest"):
            return nearestNeightborValue(tab, row["latitude"], row["longitude"], row['DepthInMeters'])
        elif config.method == "meanNearest":
            return meanNeightbor(tab, row['latitude'], row['longitude'], row['DepthInMeters'])
        else:
            print('Unknow method', config.method)
    else:
        return float('NaN')
       

def addColumn(mainTab, newColumnName, otherTab, computeRowFct=computeRow):
    print('Adding ', newColumnName)
    newTab = []
    start_time = time.time()
    startBcp = start_time
    notFound = 0
    for index, row in mainTab.iterrows():
        newRow = computeRowFct(row, otherTab)
        if math.isnan(newRow):
            notFound += 1
        newTab.append(newRow)
        if ((index + 1) % 9999 == 0):
            print("Adding: ", newColumnName, "\n", index , "\nNot found: ", notFound, "\ntime for 10000: ", time.time() - start_time, "s\nNew row sample:", newRow, "\n----")
            start_time = time.time()
    mainTab[newColumnName] = newTab
    print('Added', mainTab[newColumnName].count(), "row of", newColumnName,
    "\nTime: ", time.time() - startBcp,
    "\nTotal not found: ", notFound,
    "\nTotal unique: ", len(mainTab.groupby(newColumnName).count()))
    return mainTab


'''
Math functions
'''
def closestDepth(row, depth):
    depthLvl = np.array([x for x in row.axes[0].tolist() if isinstance(x, int) and not math.isnan(row[x])])
    if (not len(depthLvl)):
        return float('NaN')
    i = closestValue(depthLvl, depth)
    return row[i]
    

def nearestNeightborValue(df, lat, lon, depth):
    allDist = getDist(df, lat, lon, depth)
    bestDistIndex = allDist.argmin()
    bestRow = df.iloc[bestDistIndex]
    return closestDepth(bestRow, depth)

def meanNeightbor(df, lat, lon, depth):
    allDist = getDist(df, lat, lon, depth)
    maxDist = allDist.max()
    weights = np.apply_along_axis(lambda x: maxDist / x, 0, allDist)
    values = []
    weights[weights > 100000] = 100000 #We ceil huge values in case of divide by 0 or near-0 weight
    for index, row in df.iterrows():
        values.append(closestDepth(row, depth))
    values = np.array(values)

    indices = np.where(np.logical_not(np.isnan(values)))[0] # all indice that's not "NaN"

    if (not len(values[indices])): # all values are NaN
        return float('NaN')

    return np.average(values[indices], weights=weights[indices])

def calc_dist(lat1, lon1, lat2, lon2, **kwargs):
    '''
    calculates distance between 2 points (degree coordinates) on a wgs84 sphere
    
    use squaredist = True for "speed", approx 10% faster, but you get squaredist     
    '''
    to_rad = np.deg2rad
    
    d1 = kwargs.get("d1",0)
    d2 = kwargs.get("d2", 0)
    squaredist = kwargs.get("squaredist", False) 
    
    R =  6378137 - d1 
    p1 = to_rad(lat1)
    p2 = to_rad(lat2)
    dp = to_rad(lat2-lat1)
    dlon = to_rad(lon2-lon1)
    
    a = np.sin(dp/2.0)**2 + np.cos(p1)*np.cos(p2) * np.sin(dlon/2.0)**2
    c = 2.0*np.arctan2(np.sqrt(a), np.sqrt(1-a))
    
    return np.sqrt( (R*c)**2 + abs(d1-d2)**2 ) if not squaredist else (R*c)**2 + abs(d1-d2)**2 

def justDepth(t):
    nb = [x for x in t.columns if isinstance(x, int)]
    return t.loc[:,nb]

def getDist(df, lat, lon, depth):
    allDist = []
    for index, row in df.iterrows(): #we iterate through each row
        allDist.append(calc_dist(row['latitude'], row['longitude'], lat, lon, squaredist=True))
    return np.array(allDist)

def closestValue(array, value):
    idx = np.nanargmin(np.abs(array - value))
    return array[idx]


def meanTab(t):
    return np.nanmean(justDepth(t).values)

def cropData(t, lat, lon, depth):
    offset = config.offset[config.method]
    t = t[
        (t.latitude <= (lat + offset['lat'])) &
        (t.latitude >= (lat - offset['lat'])) &
        (t.longitude <= (lon + offset['lon'])) &
        (t.longitude >= (lon - offset['lon']))
    ]
    nb = [x for x in t.columns \
    if (
        (
        isinstance(x, int)
        and
            (
                x <= (depth + offset['depth'])
                and
                x >= (depth - offset['depth'])
            )
        )
        or
        (
            not isinstance(x, int) # to keep other column
        )
    )
    ]
    t = t.loc[:,nb]
    return t

def compute_val(longitude, latitude, depth, dataTab, debug=False):
    crop = cropData(t=dataTab, lon=longitude, lat=latitude, depth=depth)
    if not crop.empty:
         value = meanNeightbor(crop, lon=longitude, lat=latitude, depth=depth)
    else:
         value = 0
    return value


    
'''
MISC
'''
def toNumber(s):
    if (s.isnumeric()):
        return int(s)
    else:
        return s

def removeTrailingSpaces(s):
    while (s[0] == ' '):
        s = s[1:]
    while (s[-1] == ' '):
        s = s[:-1]
    return s

def df_split(df, size):
    print(len(df))
    df1 = df.head(size) if len(df) > size else df
    df2 = df.tail(len(df)-size) if len(df) > size else None
    return df1, df2

def df_slices(df, n):
    
    chunk_size = int(len(df)/n)
    df_list = []
    for i in range(n):
        head, df = df_split(df, chunk_size)
        df_list.append(head) if not head.empty else None
    return df_list


