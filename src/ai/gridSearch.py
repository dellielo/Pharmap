
import numpy as np
import tensorflow as tf
from tensorflow import keras
import os 

import conf
from keras.wrappers.scikit_learn import KerasClassifier
from sklearn.model_selection import GridSearchCV

def createNn(outputNb, optimizer='adam', init_mode='glorot_uniform', activation='relu', act_final='softmax'):
    inputNb = len(conf.inputFileds)
    model = keras.Sequential()
    model.add(keras.layers.Flatten(input_shape=(len(conf.inputFileds),)))
    model.add(keras.layers.Dense(240,  kernel_initializer=init_mode, activation=activation))
    model.add(keras.layers.Dense(128,  kernel_initializer=init_mode, activation=activation))
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
    def __init__(self):
        self.epochs = [10, 100]
        self.optimizers = ['adam', 'RMSprop', 'SGD' , 'Nadam']
        self.init_mode = ['normal', 'uniform', 'glorot_uniform', 'glorot_normal']
        self.batches = [20, 50, 100]
        self.activation = ['relu', 'linear', 'tanh']
        self.act_final = ['softmax', 'sigmoid', 'tanh']
        #init_mode = ['uniform', 'lecun_uniform', 'normal', 'zero', 'glorot_normal', 'glorot_uniform', 'he_normal', 'he_uniform']
        # optimizer = ['SGD', 'RMSprop', 'Adagrad', 'Adadelta', 'Adam', 'Adamax', 'Nadam']
        # activation = ['softmax', 'softplus', 'softsign', 'relu', 'tanh', 'sigmoid', 'hard_sigmoid', 'linear']
        # dropout rate
        # neurons_1 and _2 = [1, 5, 10, 15, 20, 25, 30]
        # learn_rate = [0.001, 0.01, 0.1, 0.2, 0.3]

    def set_epochs(self, new_epochs):
        self.epochs = new_epochs

    def set_optimizers(self, new_optimizers):
        self.optimizers = new_optimizers
    
    def set_init_mode(self, new_init_mode):
        # 
        self.init_mode = new_init_mode
    
    def set_batches(self, batches):
        self.batches = batches

    def run_search(self, x_train, y_train, outputNb):
        np.random.seed(42) # fix random seed for reproducibility
        tf.set_random_seed(42)
        model = KerasClassifier(build_fn=createNn, outputNb=outputNb, verbose=1)
        
        param_grid = dict(optimizer=self.optimizers, 
                          epochs=self.epochs, 
                          batch_size=self.batches, 
                          init_mode=self.init_mode, 
                          activation=self.activation, 
                          act_final=self.act_final)
        grid = GridSearchCV(estimator=model, param_grid=param_grid, n_jobs=2, cv=None)
        print('shape :', (x_train.shape))
        print('shape :', (y_train.shape))
        grid_result = grid.fit(x_train, y_train)
        # summarize results
        print("Best: %f using %s" % (grid_result.best_score_, grid_result.best_params_))
        means = grid_result.cv_results_['mean_test_score']
        stds = grid_result.cv_results_['std_test_score']
        params = grid_result.cv_results_['params']
        print(grid_result.cv_results_.keys())
        for mean, stdev, param in zip(means, stds, params):
            print("%f (%f) with: %r" % (mean, stdev, param))
        return grid_result


def write_report(info_run, grid_result, dir_save = "data/report"):
    import json
    import datetime 

    name_date = 'report-{date:%Y-%m-%d_%H:%M:%S}'.format( date=datetime.datetime.now() )
    if not(os.path.exists(dir_save)):
        os.makedirs(dir_save)

    with open(os.path.join(dir_save, name_date + "_config.txt"), 'w') as fic:
        # info_run['nb_data'] = nb_data
        json.dump(info_run, fic, indent=4)
    with open(os.path.join(dir_save, name_date +"_result.txt"), 'w') as fic:
        fic.write("Best: %f using %s \n" % (grid_result.best_score_, grid_result.best_params_))
        means = grid_result.cv_results_['mean_test_score']
        stds = grid_result.cv_results_['std_test_score']
        params = grid_result.cv_results_['params']
        for mean, stdev, param in zip(means, stds, params):
            fic.write("%f (%f) with: %r \n" % (mean, stdev, param))


def gridSearch_table_plot(grid_clf, param_name,
                          num_results=15,
                          graph=True,
                          display_all_params=True):

    '''Display grid search results

    Arguments
    ---------

    grid_clf           the estimator resulting from a grid search
                       for example: grid_clf = GridSearchCV( ...

    param_name         a string with the name of the parameter being tested

    num_results        an integer indicating the number of results to display
                       Default: 15

    negative           boolean: should the sign of the score be reversed?
                       scoring = 'neg_log_loss', for instance
                       Default: True

    graph              boolean: should a graph be produced?
                       non-numeric parameters (True/False, None) don't graph well
                       Default: True

    display_all_params boolean: should we print out all of the parameters, not just the ones searched for?
                       Default: True

    Usage
    -----

    GridSearch_table_plot(grid_clf, "min_samples_leaf")

                          '''
    from matplotlib      import pyplot as plt
    from IPython.display import display
    import pandas as pd

    clf = grid_clf.best_estimator_
    clf_params = grid_clf.best_params_

    clf_score = grid_clf.best_score_
    clf_stdev = grid_clf.cv_results_['std_test_score'][grid_clf.best_index_]
    cv_results = grid_clf.cv_results_

    print("best parameters: {}".format(clf_params))
    print("best score:      {:0.5f} (+/-{:0.5f})".format(clf_score, clf_stdev))
    if display_all_params:
        import pprint
        pprint.pprint(clf.get_params())

    # pick out the best results
    # =========================
    scores_df = pd.DataFrame(cv_results).sort_values(by='rank_test_score')

    best_row = scores_df.iloc[0, :]
    best_mean = best_row['mean_test_score']
    best_stdev = best_row['std_test_score']
    best_param = best_row['param_' + param_name]

    # # display the top 'num_results' results
    # # =====================================
    # display(pd.DataFrame(cv_results) \
    #         .sort_values(by='rank_test_score').head(num_results))

    # plot the results
    # ================
    scores_df = scores_df.sort_values(by='param_' + param_name)

    
    means = scores_df['mean_test_score']
    stds = scores_df['std_test_score']
    params = scores_df['param_' + param_name]

    # plot
    if graph:
        plt.figure(figsize=(8, 8))
        plt.errorbar(params, means, yerr=stds)

        plt.axhline(y=best_mean + best_stdev, color='red')
        plt.axhline(y=best_mean - best_stdev, color='red')
        plt.plot(best_param, best_mean, 'or')

        plt.title(param_name + " vs Score\nBest Score {:0.5f}".format(clf_score))
        plt.xlabel(param_name)
        plt.ylabel('Score')
        plt.show()

