import time
import config
import numpy as np
import math

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

def nearestNeightborValue(df, lat, lon, depth):
    dist_min = float('inf') #maximum distance is infinity     
    
    value = 0           #No value
    for row in df.itertuples(index=True, name='Pandas'): #we iterate through each row
        depthdist_min = float('inf')
        d = calc_dist(row.latitude, row.longitude, lat, lon, squaredist==True) #get the distance
        
        if d < dist_min: #if we have a new closer record...
            
            dist_min = d
            
            for depth2 in t.columns: #let's look at the closest by depth
                depthdist = abs(d-depth2) if (isinstance(depth2, int) and isinstance(row[depth2], int)) else float("inf")
                depthdist_min = depthdist if depthdist < depthdist_min else depthdist_min
                value = row[depth2]
    return value
                

def select(t, lat, lon, depth):
    t = t[
        (t.latitude <= (lat + config.tempLatitudeOffset)) &
        (t.latitude >= (lat - config.tempLatitudeOffset)) &
        (t.longitude <= (lon + config.tempLongitudeOffset)) &
        (t.longitude >= (lon - config.tempLongitudeOffset))
    ]
    nb = [x for x in t.columns \
    if (
    isinstance(x, int)
    and
        (
            x < (depth + config.tempDepthOffset)
            and
            x > (depth - config.tempDepthOffset)
        )
    )
    ]
    t = t.loc[:,nb]
    return t

def meanTab(tab):
    return np.nanmean(tab.values)

def computeRow(row, dataTab):
    tab = select(dataTab, row['latitude'], row['longitude'], row['DepthInMeters'])
    if (not tab.empty):
        return meanTab(tab)
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
        "in", time.time() - startBcp, "total not found", notFound)
    return mainTab
