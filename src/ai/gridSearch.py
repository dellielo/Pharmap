from __future__ import print_function
import numpy as np
import tensorflow as tf
from tensorflow import keras
import os 
from  collections  import OrderedDict

import conf
from keras.wrappers.scikit_learn import KerasClassifier
from sklearn.model_selection import GridSearchCV

# def createNn(outputNb, optimizer='adam', init_mode='glorot_uniform', activation='relu', act_final='softmax', nb_neurons="240"):
#     inputNb = len(conf.inputFields)
#     model = keras.Sequential()
#     model.add(keras.layers.Flatten(input_shape=(inputNb,)))
#     model.add(keras.layers.Dense(240,  kernel_initializer=init_mode, activation=activation))
#     model.add(keras.layers.Dense(128,  kernel_initializer=init_mode, activation=activation))
#     model.add(keras.layers.Dense(outputNb, activation=act_final))
#     model.compile(optimizer=optimizer, 
#                     loss='sparse_categorical_crossentropy',
#                     metrics=['accuracy'])
    
#     return model

def createNn(outputNb, optimizer='adam', init_mode='glorot_uniform', activation='relu', act_final='softmax', nb_neurons_settings=[240, 128]):
    inputNb = len(conf.inputFields)
    model = keras.Sequential()
    model.add(keras.layers.Flatten(input_shape=(inputNb,)))
    
    for nb_neurons in nb_neurons_settings:
        model.add(keras.layers.Dense(nb_neurons,  kernel_initializer=init_mode, activation=activation))#, kernel_regularizer=keras.regularizers.l2(0.003)))
    model.add(keras.layers.Dense(outputNb, activation=act_final))
    model.compile(optimizer=optimizer, 
                    loss='sparse_categorical_crossentropy',
                    metrics=['accuracy'])

    return model

def create_best_model(outputNb, params):
    # params = grid_results.best_params_
    ## create the model with the best params found
    model = createNn(outputNb, init_mode=params['init_mode'],
                        activation=params['activation'],
                        optimizer=params['optimizer'])
    return model
    

class MultiSearchParam :
    #init_mode = ['uniform', 'lecun_uniform', 'normal', 'zero', 'glorot_normal', 'glorot_uniform', 'he_normal', 'he_uniform']
    # optimizer = ['SGD', 'RMSprop', 'Adagrad', 'Adadelta', 'Adam', 'Adamax', 'Nadam']
    # activation = ['softmax', 'softplus', 'softsign', 'relu', 'tanh', 'sigmoid', 'hard_sigmoid', 'linear']
    # dropout rate
    # neurons_1 and _2 = [1, 5, 10, 15, 20, 25, 30]
    # learn_rate = [0.001, 0.01, 0.1, 0.2, 0.3]

    def __init__(self):
        self.epochs = [10] #, 100]
        self.optimizers = ['adam', 'RMSprop', 'SGD' , 'Nadam']
        self.init_mode = ['normal', 'uniform', 'glorot_uniform', 'glorot_normal']
        self.batches = [1, 20, 50, 100]
        self.activation = ['relu', 'linear', 'tanh']
        self.act_final = ['softmax', 'sigmoid']
        self.nb_neurons_settings = [[240, 128], [480, 240], [128, 240], [480, 240, 128]]
        
    def run_search(self, x_train, y_train, outputNb):
        np.random.seed(42) # fix random seed for reproducibility
        tf.set_random_seed(42)
        model = KerasClassifier(build_fn=createNn, outputNb=outputNb, verbose=0)
        
        param_grid = OrderedDict(optimizer=self.optimizers, 
                          nb_neurons_settings=self.nb_neurons_settings,
                          epochs=self.epochs, 
                          batch_size=self.batches, 
                          init_mode=self.init_mode, 
                          activation=self.activation, 
                          act_final=self.act_final
                          )
        best_param = dict()
        grid_result = []
        for key, val in param_grid.items() :
            print( "--------------- Run on [%s] --------------- "%(key))
            param_cur = {key: val}
            param_cur.update(best_param)

            grid = GridSearchCV(estimator=model, param_grid=param_cur, n_jobs=4, cv=3, verbose=1)

            grid_result_cur = grid.fit(x_train, y_train)
            # summarize results
            print("\n ---- Best: %f using %s -----" % (grid_result_cur.best_score_, grid_result_cur.best_params_))
            means = grid_result_cur.cv_results_['mean_test_score']
            stds = grid_result_cur.cv_results_['std_test_score']
            params = grid_result_cur.cv_results_['params']
            for mean, stdev, param in zip(means, stds, params):
                print("%f (%f) with: %r" % (mean, stdev, param))
            best_param = grid_result_cur.best_params_
            # print(best_param)
            # best_param = {best_param.keys()[0]: list(best_param.values())}
            best_param = {k: [v] for k, v in best_param.items()}
            grid_result.append(grid_result_cur)
        return grid_result, grid_result_cur.best_params_


def write_report(info_run, grid_result_tot, dir_save = "data/report"):
    import json
    import datetime 

    name_date = 'report-{date:%Y-%m-%d_%H%M%S}'.format( date=datetime.datetime.now() )
    if not(os.path.exists(dir_save)):
        os.makedirs(dir_save)

    with open(os.path.join(dir_save, name_date + "_config.txt"), 'w') as fic:
        # info_run['nb_data'] = nb_data
        json.dump(info_run, fic, indent=4)
    with open(os.path.join(dir_save, name_date +"_result.txt"), 'w') as fic:
        for grid_result in grid_result_tot:
            fic.write("Best: %f using %s \n" % (grid_result.best_score_, grid_result.best_params_))
            means = grid_result.cv_results_['mean_test_score']
            stds = grid_result.cv_results_['std_test_score']
            params = grid_result.cv_results_['params']
            for mean, stdev, param in zip(means, stds, params):
                fic.write("%f (%f) with: %r \n" % (mean, stdev, param))


