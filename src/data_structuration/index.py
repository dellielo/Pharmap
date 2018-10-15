import config
import geopandas
import computeTemp
import tools
import factory

if __name__=='__main__':
    data = tools.load(config.dataDir)
    mainTable = data['coraux_geo.geojson']
    tempTable = data['temp_0-4000m_2013.geojson']
    tempTable = computeTemp.formatTempTab(tempTable)
    factory.addColumn(mainTable, "temperature", tempTable, computeTemp.computeTempRow)