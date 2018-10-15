import time
import tools

totalNotFound = 0

def addColumn(mainTab, newColumnName, otherTab, computeRowFct):
    newTab = []
    start_time = time.time()
    for index, row in mainTab.iterrows():
        newRow = computeRowFct(row, otherTab)
        newTab.append(newRow)
        if (index % 1000 == 0):
            print(index , "\nNot found: ", tools.notFound, "\ntime for 1000: ", time.time() - start_time, "s\nNew row sample:", newRow, "\n----")
            start_time = time.time()
    mainTab[newColumnName] = newTab
    print(mainTab)
    return mainTab