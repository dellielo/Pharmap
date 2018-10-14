import tools
import config
import geopandas
import numpy as np
import time

totalNotFound = 0

def toNumber(s):
    if (s.isnumeric()):
        return int(s)
    else:
        return s

def formatTempTab(tempTab):
    print('formating')
    newTab = tempTab.rename(columns={'#COMMA SEPARATED LATITUDE':'latitude', "LONGITUDE":'longitude', 'AND VALUES AT DEPTHS (M):0':'0'})
    newTab = newTab.rename(columns=toNumber)
    print('done formating')
    return newTab

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

def computeRow(row, tempTab):
    global totalNotFound
    temps = select(tempTab, row['latitude'], row['longitude'], row['DepthInMeters'])
    if (not temps.empty):
        total = 0
        length = 0
        for c in temps.columns:
            total += temps[c].sum()
            length += temps[c].count()
        return total / length
    else:
        totalNotFound += 1
        return float('NaN')

def computeTemp(mainTab, tempTab, format=True):
    tempTab = formatTempTab(tempTab)
    temp = []
    start_time = time.time()
    for index, row in mainTab.iterrows():
        tempRow = computeRow(row, tempTab)
        temp.append(tempRow)
        if (index % 1000 == 0):
            print(index , "\nNot found: ", totalNotFound, "\ntime for 1000: ", time.time() - start_time, "s\n----")
            start_time = time.time()
    mainTab['temperature'] = temp
    print(mainTab)
    return 1




if __name__=='__main__':
    data = tools.load(config.testDir)
    tempTab = data['temp_0-4000m_2013.geojson']
    mainTab = data['coraux_geo.geojson']
    computeTemp(mainTab, tempTab)
    #data = tools.load(config.dataDir)
    #for name, tab in data.items():
    #    data[name] = tab.head(10)
    #tools.multipleTabSave(data, config.testDir)
