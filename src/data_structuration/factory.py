import time
import config
import numpy as np
import math
import gdal


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


def select_pixel_coord(raster, lat, lon, extent):
    """
    Given a numpy array representing the raster band, returns pixel(array) value at lat/long coordinate, extent is degree system (usually 360*180)
    """
    width, height = raster_array.shape
    x_pixel_size = extent[0]/width
    y_pixel_size = extent[1]/height
    
    x_row = max(0, math.floor((180+lon)/x_pixel_size))
    y_col = max(0, math.floor((90-lat)/y_pixel_size))
    
    return x_row, y_row

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

def formatNoaaTab(tab):
    print('formating')
    newTab = tab.rename(columns=removeTrailingSpaces)
    newTab = newTab.rename(columns={'#COMMA SEPARATED LATITUDE':'latitude', "LONGITUDE":'longitude', 'AND VALUES AT DEPTHS (M):0':'0'})
    newTab = newTab.rename(columns=toNumber)
    print('done formating')
    return newTab

def formatCorailTab(tab):
    return tab.rename(columns={"ScientificName": 'species'})

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
    for index, row in df.iterrows():
        values.append(closestDepth(row, depth))
    values = np.array(values)

    indices = np.where(np.logical_not(np.isnan(values)))[0] # all indice that's not "NaN"

    if (not len(values[indices])): # all values are NaN
        return float('NaN')

    return np.average(values[indices], weights=weights[indices])

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
                x < (depth + offset['depth'])
                and
                x > (depth - offset['depth'])
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
