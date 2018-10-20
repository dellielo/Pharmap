import time
import tools
import config
import numpy as np

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
        tools.notFound += 1
        return float('NaN')

def addColumn(mainTab, newColumnName, otherTab, computeRowFct=computeRow):
    print('Adding ', newColumnName)
    tools.notFound = 0
    newTab = []
    start_time = time.time()
    startBcp = start_time
    for index, row in mainTab.iterrows():
        newRow = computeRowFct(row, otherTab)
        newTab.append(newRow)
        if ((index + 1) % 9999 == 0):
            print(index , "\nNot found: ", tools.notFound, "\ntime for 1000: ", time.time() - start_time, "s\nNew row sample:", newRow, "\n----")
            start_time = time.time()
    mainTab[newColumnName] = newTab
    print('Added', mainTab[newColumnName].count(), "row of", newColumnName,
        "in", time.time() - startBcp, "total not found", tools.notFound)
    return mainTab