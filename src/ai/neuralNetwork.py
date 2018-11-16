import datetime
import json
import os

import numpy as np
import tensorflow as tf
from sklearn import metrics
from tensorflow import keras

import conf
import util


class NeuralNetwork:

    def __init__(self, outputNb):
        self.createNn(outputNb, 
                      optimizer=conf.network['optimizer'],
                      init_mode=conf.network['init_mode'],
                      activation=conf.network['activation'],
                      act_final=conf.network['act_final'])
        self.outputNb = outputNb

    def createNn(self, outputNb, optimizer='adam', init_mode='glorot_uniform', activation='relu', act_final='softmax'):
        inputNb = len(conf.inputFields)
        model = keras.Sequential()
        model.add(keras.layers.Flatten(input_shape=(inputNb,)))
        model.add(keras.layers.Dense(240,  kernel_initializer=init_mode, activation=activation))
        model.add(keras.layers.Dense(128,  kernel_initializer=init_mode, activation=activation))
        model.add(keras.layers.Dense(outputNb, activation=act_final))
        model.compile(optimizer=optimizer, 
                        loss='sparse_categorical_crossentropy',
                        metrics=['accuracy'])
    
        self.model = model

    def evaluate(self, testInput, testOutput):
        testLoss, testAcc = self.model.evaluate(testInput, testOutput)
        print('Accuracy:', testAcc, "loss: ", testLoss)
        return testLoss, testAcc

    def predict(self, inputsToPredict): #input is an array
        pred = self.model.predict(inputsToPredict)
        return pred

    def predict_classes(self, inputsToPredict): #input is an array
        pred = self.model.predict_classes(inputsToPredict)
        return pred


    def train(self, trainInput, trainOutput, epochs=None):
        epochs_ = conf.network['epochs'] if epochs is None else epochs

        early_stopping = keras.callbacks.EarlyStopping(monitor='val_loss', patience=20)
        #self.model.fit(trainInput, trainOutput, validation_split=0.1, callbacks=[early_stopping], epochs=epochs_)
        self.model.fit(trainInput, trainOutput, validation_split=0.1, epochs=epochs_)


def test(model, x_test, y_test, idx2label):
    y_pred = model.predict_classes(x_test)
    prob = model.predict(x_test)

    errors = np.where(y_pred != y_test)[0]
    print("No of errors = {}/{}".format(len(errors),len(y_test)))
    
    for i in range(len(errors[:5])):
        pred_class = np.argmax(prob[errors[i]])
        # todo: to fix
        print(pred_class)
        pred_label = idx2label[pred_class]
        true_label = idx2label[y_test[errors[i]]]

        print('Original label: [{}], Prediction :[{}], confidence : {:.3f}'.format(
            true_label,
            pred_label,
            prob[errors[i]][pred_class]))

    report = metrics.classification_report(y_test, y_pred, target_names=[str(l) for l in idx2label.values()])
    print (metrics.classification_report(y_test, y_pred, target_names=[str(l) for l in idx2label.values()]))
    scores = model.evaluate(x_test, y_test)  
    results =  (report, scores)   
    print("Test final with the best of the best: %2.4f %%"%(metrics.accuracy_score(y_test, y_pred)))
    util.write_file_error_by_name(y_pred, y_test, x_test, idx2label)
    
    return results

def write_report_unique(info_run, results, dir_save = "data/report"):
    name_date = 'report-{date:%Y-%m-%d_%H:%M:%S}'.format( date=datetime.datetime.now() )
    if not(os.path.exists(dir_save)):
        os.makedirs(dir_save)

    with open(os.path.join(dir_save, name_date + "_config_nn.txt"), 'w') as fic:
        json.dump(info_run, fic, indent=4)
    with open(os.path.join(dir_save, name_date +"_result_nn.txt"), 'w') as fic:
        report, scores = results
        fic.write("Resultas tests: accuracy %f loss % f\n" % (scores[1], scores[0]))
        fic.write(report)

