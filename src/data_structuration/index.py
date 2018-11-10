import tools
import factory
import threading
import addTaxonomy
import config

def worker(mainTab, newColumnName, otherTab):
    factory.addColumn(mainTab, newColumnName, otherTab)

if __name__=="__main__":
    if (config.method not in config.methodList):
        print('unknown method ', config.method)

    oceanData = tools.load('./data/oceanData', 1)
    corauxData = tools.load('./data/coraux')
    taxonomySupport = tools.load(config.taxonomyDir, 0, ";")
    for prop in oceanData:
        oceanData[prop] = factory.formatNoaaTab(oceanData[prop])
    for key in corauxData:
        corauxData[key] = corauxData[key].head(400) #to have a fast result
        corauxData[key] = factory.formatCorailTab(corauxData[key])
        threads = []

        #adding column such as salinity temperature
        for prop in oceanData:
            t = threading.Thread(target=worker, args=(corauxData[key], prop, oceanData[prop]))
            t.start()
            threads.append(t)

        #adding columns taxonomy such as family
        t = threading.Thread(target=addTaxonomy.addTaxonomy, args=(corauxData[key], taxonomySupport[config.taxonomyFile]))
        t.start()
        threads.append(t)

        for t in threads:
            t.join()

        print(corauxData[key])
        tools.save_out_csv(corauxData[key], './data/out/', "coraux_geo.csv")