import tools
import factory
import threading

def worker(mainTab, newColumnName, otherTab):
    factory.addColumn(mainTab, newColumnName, otherTab)

if __name__=="__main__":
    oceanData = tools.load('./data/oceanData', 1)
    corauxData = tools.load('./data/coraux')
    for prop in oceanData:
        oceanData[prop] = factory.formatNoaaTab(oceanData[prop])
    for key in corauxData:
        corauxData[key] = corauxData[key].head(400) #to have a fast result
        threads = []
        for prop in oceanData:
            t = threading.Thread(target=worker, args=(corauxData[key], prop, oceanData[prop]))
            t.start()
            threads.append(t)
        for t in threads:
            t.join()
        print(corauxData[key])
        tools.save(corauxData[key], './data/out/', key)