
import numpy as np
import keras

from keras.wrappers.scikit_learn import KerasClassifier
from sklearn.model_selection import GridSearchCV

# def create_model(outputNb, optimizer='rmsprop', init='glorot_uniform'):
#     from keras.models import Sequential
#     from keras.layers import Dense, Flatten
#     import keras
#     # create model
#     # model = Sequential()
#     # model.add(Flatten(input_shape=(len(conf.inputFileds),)))
#     # model.add(Dense(240, activation='relu'))
#     # model.add(Dense(128, activation='relu'))
#     # model.add(Dense(outputNb, activation='sigmoid'))
#     # return model
#     inputNb =  6 #len(conf.inputFileds)
#     print("outputNb " + str(outputNb))
#     model = keras.Sequential([
#             keras.layers.Flatten(input_shape=(inputNb,)),
#             keras.layers.Dense(240, kernel_initializer=init, activation='relu'),            
#             keras.layers.Dense(128, kernel_initializer=init, activation='relu'),
#             keras.layers.Dense(outputNb, kernel_initializer=init, activation='softmax')
#         ])

#     model.compile(optimizer=optimizer,
#                     loss='sparse_categorical_crossentropy',
#                     metrics=['accuracy'])


def createNn(outputNb, optimizer='adam', init_mode='uniform'):
    inputNb = len(conf.inputFileds)
    model = keras.Sequential([
        keras.layers.Flatten(input_shape=(inputNb,)),
        keras.layers.Dense(240, kernel_initializer=init_mode, activation='relu'),
        # keras.layers.BatchNormalization(),
        
        # keras.layers.Activation('relu'),
        # keras.layers.Dropout(0.5),
        # keras.layers.Dense(128, activation='relu'),
        keras.layers.Dense(128, kernel_initializer=init_mode, activation='relu'), 
        # keras.layers.BatchNormalization(),
        # keras.layers.Activation('relu'),
        # keras.layers.Dropout(0.5),
        keras.layers.Dense(outputNb, activation='softmax')
    ])

    model.compile(optimizer=optimizer, #tf.train.AdamOptimizer(),
                    loss='sparse_categorical_crossentropy',
                    metrics=['accuracy'])
    
    return model

class MultiSearchParam :
    def __init__(self):
        self.epochs = [10]
        self.optimizers = ['adam']
        self.init_mode = ['normal']
        self.batches = [5]
        # activation = ['softmax', 'softplus', 'softsign', 'relu', 'tanh', 'sigmoid', 'hard_sigmoid', 'linear']
        # dropout rate
        # neurons_1 and _2 = [1, 5, 10, 15, 20, 25, 30]
        # learn_rate = [0.001, 0.01, 0.1, 0.2, 0.3]

    def set_epochs(self, new_epochs):
        self.epochs = new_epochs

    def set_optimizers(self, new_optimizers):
        self.optimizers = new_optimizers
    
    def set_init_mode(self, new_init_mode):
        # ['uniform', 'lecun_uniform', 'normal', 'zero', 'glorot_normal', 'glorot_uniform', 'he_normal', 'he_uniform']
        self.init_mode = new_init_mode
    
    def set_batches(self, batches):
        self.batches = batches

    def run_search(self, x_train, y_train, outputNb):
        np.random.seed(42)
        model = KerasClassifier(build_fn=createNn, outputNb=outputNb, verbose=1)
        # optimizers = ['rmsprop', 'adam'] #['SGD', 'RMSprop', 'Adagrad', 'Adadelta', 'Adam', 'Adamax', 'Nadam']
        # init_mode = ['glorot_uniform', 'normal', 'uniform']
        # # epochs = [50, 100, 150]
        # epochs = [1, 5, 10]
        # batches = [5] #, 10, 20]
        param_grid = dict(optimizer=self.optimizers, epochs=self.epochs, batch_size=self.batches, init_mode=self.init_mode)
        grid = GridSearchCV(estimator=model, param_grid=param_grid, n_jobs=1)
        grid_result = grid.fit(x_train, y_train)
        # summarize results
        print("Best: %f using %s" % (grid_result.best_score_, grid_result.best_params_))
        means = grid_result.cv_results_['mean_test_score']
        stds = grid_result.cv_results_['std_test_score']
        params = grid_result.cv_results_['params']
        for mean, stdev, param in zip(means, stds, params):
            print("%f (%f) with: %r" % (mean, stdev, param))
        return grid_result
    
    def write_report(self, grid_result):
        with open("report_result.txt", 'w') as fic:
            fic.write("Best: %f using %s" % (grid_result.best_score_, grid_result.best_params_))
            means = grid_result.cv_results_['mean_test_score']
            stds = grid_result.cv_results_['std_test_score']
            params = grid_result.cv_results_['params']
            for mean, stdev, param in zip(means, stds, params):
                fic.write("%f (%f) with: %r" % (mean, stdev, param))