import tools
import config

def computeTemp(mainTab, tempTab):
    return 1

if __name__=='__main__':
    data = tools.load(config.testDir)
    computeTemp(data['coraux_geo.geojson'], ['temp_0-4000m_2013.geojson'])
    #data = tools.load(config.dataDir)
    #for name, tab in data.items():
    #    data[name] = tab.head(10)
    #tools.multipleTabSave(data, config.testDir)