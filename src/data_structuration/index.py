import config
import geopandas
import computeTemp
import tools

if __name__=='__main__':
    data = tools.load(config.dataDir)
    for name, tab in data.items():
        print(name, tab.columns)
    mainTable = data['coraux_geo.geojson']
    tempTable = data['temp_0-4000m_2013.geojson']
    computeTemp.computeTemp(mainTable, tempTable)