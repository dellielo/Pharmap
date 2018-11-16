import conf 
from sklearn.model_selection import train_test_split
from sklearn import preprocessing
import numpy as np 

def getInputColumn(df_x):
    x = df_x.loc[:,conf.inputFields].values 
    return x

def filterTaxonRank(tab, key=None):
    # si key == None, aucun filtre n'est applique
    if key is not None:
        tab = tab[tab['TaxonRank']==key]
        print("Len Tab after filter {}".format(len(tab)))
    return tab

def orderColumns(tab):
    cols = tab.columns.tolist()
    for field in conf.inputFields:
        if not field in cols:
            raise ("Can t find column ", field, " in tab")
    cols = conf.inputFields + [x for x in cols if x not in conf.inputFields]
    tab =  tab[cols]
    if 'ScientificName' not in tab.keys() : # to be compatible with old file
        tab.loc[:,'ScientificName'] = tab['species']
    return tab

def cleanTab(tab):
    print("Len Tab with Nan {}".format(len(tab)))
    tab = tab.dropna(subset=conf.inputFields)
    print("Len Tab without Nan {}".format(len(tab)))
    return tab 

def removeDuplicate(tab, remove_duplicate):
    if remove_duplicate :
        # conf.selectedField, "longitude", "latitude", "longitude", "latitude",
        column_dupli = [ "phosphate.csv" , "oxygen.csv", "salinity.csv", "temperature.csv","nitrate.csv"] 
        tab = tab.drop_duplicates(subset=column_dupli, keep="first")
        print("Len Tab without duplicate {}".format(len(tab)))
    return tab 

def filterNumberOcc(tab, minSampleSize=2000):
    tab['counts'] = tab.groupby(conf.selectedField)[conf.selectedField].transform('count')  
    tab = tab[tab.counts > minSampleSize] # select all element that have at least $minSampleSize element
    print('have', len(tab.groupby(conf.selectedField).size()), 'type with more than', minSampleSize, 'sample')
    return tab

def transformOutput(tab):
    c = tab[conf.selectedField].astype('category')
    dict_category = dict(enumerate(c.cat.categories))
    tab[conf.outputField] = c.cat.codes
    y = tab[conf.outputField].values # 
    
    return y, dict_category

# def addOutputColumn(tab):
#     print('adding output column')
#     print(tab.keys())  
#     print('have', len(tab.groupby(conf.selectedField).size()), 'type with more than', minSampleSize, 'sample')
#     tab = tab.assign(output=(tab[conf.selectedField]).astype('category').cat.codes) #add unique id to each scientific name
#     return tab


def makeStandardization(x_train, x_test):
    # Standardization
    inputFields = conf.inputFields
    x_train_p = x_train.loc[:,conf.inputFields]
    x_test_p = x_test.loc[:,conf.inputFields]

    scaler = preprocessing.StandardScaler().fit(x_train_p) # StandardScaler
    x_train_transform = scaler.transform(x_train_p)
    x_test_transform = scaler.transform(x_test_p)
    x_train.loc[:,conf.inputFields] = x_train_transform
    x_test.loc[:,conf.inputFields] = x_test_transform
    return x_train, x_test

def getInputOutput(tab):
    x = tab.loc[:,conf.inputFields].values
    y = tab.loc[:,conf.outputField].values
    return (x, y)

def describe(y):
    unique, counts = np.unique(y, return_counts=True)
    print(unique, counts)
    print('Mean output: ', np.mean(counts), "\nRange: ", np.ptp(counts), "\nMax: ", np.amax(counts), "\nMin: ", np.amin(counts))

def get_idx2label(tab):
    labels = sorted(tab[conf.selectedField].unique())
    idx2label = dict((v,k) for k,v in zip(labels, range(0,len(labels))))
    return idx2label

class ManageData:
    def __init__(self, tab):
        self.tab = tab
        print("Len Tab init {}".format(len(tab)))
        
        self.y, self.idx2label = transformOutput(tab)
    
    @property
    def labels(self):
        return self.idx2label.values()

    @property
    def nb_labels(self):
        return len(self.idx2label)

    def prepareData(self,remove_duplicate, min_sample_size, keyTaxonRk, return_copy=False):
            # tab = data[key]
        tab = filterTaxonRank(self.tab, keyTaxonRk)
        tab = orderColumns(tab)
        tab = cleanTab(tab)
        tab = removeDuplicate(tab, remove_duplicate)
        tab = filterNumberOcc(tab, min_sample_size)
        tab = tab.reset_index(drop=True)
        self.y, self.idx2label = transformOutput(tab)
        # tab = addOutputColumn(tab, min_sample_size)
        # return x,y, tab
        self.tab = tab
        
        # self.know_output(dict_category)
        if return_copy :
            return tab 
        
    # def _getInputOutput(self):
    #     x, y = getInputOutput(self.tab)
    #     return x, y

    def split_train_test(self):
        # _getInputOutput
        y = self.y # self.tab[conf.outputField]
        x_train, x_test, y_train, y_test = train_test_split(self.tab, y, random_state=42, test_size=0.2,  stratify=y)
        return  x_train, x_test, y_train, y_test
