import gridSearch
from tensorflow import keras 
import dataManage as dm

def filter_data(data, keyTaxonRk):
    dm.ManageData(data)
    min_sample_size = 0
    dm.prepareData(False, min_sample_size, keyTaxonRk, output=keyTaxonRk)

def train_model_with_taxon_rank(model, data, taxon_rank):
    x_train, y_train, x_test, y_test = filter_data(data, keyTaxonRk)
    model.fit(x_train, y_train)

def freeze_model(model):
    for layer in model.layers:
	    layer.trainable = False
    return model 



def remove_last_layer(model):
    model.pop()
    return model 

def add_layer(model, nb_neurons, init_mode, activation):
    model.add(keras.layers.Dense(nb_neurons,  kernel_initializer=init_mode, activation=activation))
    return model
    

def make_cascade(data, taxon_rank):
    for taxon in taxon_rank:
        if model is None:
            model = gridSearch.createNN()
        else:
            model = add_layer(model)
        model.summary()

        model = train_model_with_taxon_rank(model, data, taxon_rank)
        
        model = remove_last_layer()
        model.summary()
        model = freeze_model()
        model.summary()

        

