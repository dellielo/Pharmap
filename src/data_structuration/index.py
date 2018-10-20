import tools
import factory

if __name__=="__main__":
    oceanData = tools.load('./data/oceanData', 1)
    corauxData = tools.load('./data/coraux')
    for prop in oceanData:
        oceanData[prop] = factory.formatNoaaTab(oceanData[prop])
    for key in corauxData:
        corauxData[key] = corauxData[key].head(9000) #to have a fast result
        for prop in oceanData:
            print("Adding column ", prop)
            finalTab = factory.addColumn(corauxData[key], prop, oceanData[prop])
        print("Final tab:", key, finalTab)