import tools
import config
import geopandas

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

def computeTempRow(row, tempTab):
    temps = select(tempTab, row['latitude'], row['longitude'], row['DepthInMeters'])
    if (not temps.empty):
        return tools.meanTab(temps)
    else:
        tools.notFound += 1
        return float('NaN')

if __name__=='__main__':
    import factory

    data = tools.load(config.testDir)
    tempTab = data['temp_0-4000m_2013.geojson']
    mainTab = data['coraux_geo.geojson']
    tempTab = formatTempTab(tempTab)
    factory.addColumn(mainTab, "temperature", tempTab, computeTempRow)
