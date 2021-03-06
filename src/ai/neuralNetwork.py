import datetime
import json
import os

import numpy as np
import tensorflow as tf
from sklearn import metrics
from tensorflow import keras
import matplotlib.pyplot as plt
from tensorflow.keras import backend as K

import conf
import util
import evaluation


class NeuralNetwork:
    """Class to build a neuralNetwork
    """

    def __init__(self, outputNb):
        self.createNn(outputNb, 
                      optimizer=conf.network['optimizer'],
                      init_mode=conf.network['init_mode'],
                      activation=conf.network['activation'],
                      act_final=conf.network['act_final'])
        self.outputNb = outputNb

    
    def createNn(self, outputNb, optimizer='adam', init_mode='glorot_uniform', activation='relu', act_final='softmax', nb_neurons_settings = [240, 128]):
        """create the neural network with Keras
        
        :param outputNb: nulber of outputs
        :type outputNb: int
        :param optimizer: the name of optimizer, defaults to 'adam'
        :param optimizer: str, optional
        :param init_mode: the name of the function hwo the weigths are initialized, defaults to 'glorot_uniform'
        :param init_mode: str, optional
        :param activation: the name of activation function, defaults to 'relu'
        :param activation: str, optional
        :param act_final: the name of the activation function for the last layer, defaults to 'softmax'
        :param act_final: str, optional
        :param nb_neurons_settings: the number of neurons for each layer, defaults to [240, 128]
        :param nb_neurons_settings: list, optional
        """ 

        inputNb = len(conf.inputFields)
        model = keras.Sequential()
        model.add(keras.layers.Flatten(input_shape=(inputNb,)))
        
        for nb_neurons in nb_neurons_settings:
            model.add(keras.layers.Dense(nb_neurons,  kernel_initializer=init_mode))
            model.add(keras.layers.Activation(activation))
        # model.add(keras.layers.Dense(outputNb,  use_bias=False)) #activation=act_final,
        # model.add(keras.layers.BatchNormalization())
        # model.add(keras.layers.Activation(act_final))
        model.add(keras.layers.Dense(outputNb))
        model.add(keras.layers.Activation(act_final))
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
        # trainOutput = keras.utils.to_categorical(trainOutput, num_classes=len(np.unique(trainOutput)))
        epochs_ = conf.network['epochs'] if epochs is None else epochs

        early_stopping = keras.callbacks.EarlyStopping(monitor='val_loss', patience=20)
        
        # callbacks = [EarlyStopping(monitor='val_loss', patience=5),
        #      ModelCheckpoint('../models/model.h5'), save_best_only=True, 
        #                      save_weights_only=False)]
        #self.model.fit(trainInput, trainOutput, validation_split=0.1, callbacks=[early_stopping], epochs=epochs_)
        history = self.model.fit(trainInput, trainOutput, validation_split=0.1, epochs=epochs_)
        label=None
        plot_history(history, extra_label=label)
	

def plot_history(history, extra_label=""):
    acc = history.history['acc']
    val_acc = history.history['val_acc']
    loss = history.history['loss']
    val_loss = history.history['val_loss']
    epochs = range(len(acc))
    plt.plot(epochs, acc, '-', label='Training acc', color='m')
    plt.plot(epochs, val_acc, '-', label='Validation acc', color='g')

    plt.plot(epochs, loss, '-', label='Training loss', color='y')
    plt.plot(epochs, val_loss, '-', label='Validation loss', color='b')
    plt.legend()
    plt.title('Training and validation accuracy- {}'.format(extra_label))
    plt.show()
    print("train acc:{:.3f}, val acc: {:.3f}".format(acc[-1], val_acc[-1]))


def test(model, x_test_origin, y_test, idx2label, scaler = None, k_results = 5):
    if scaler is not None:
        print("Transform")
        x_test = scaler.transform(x_test_origin)
    else :
        print("No Transform")
        x_test = x_test_origin

    scores_k_rank = []
    y_pred = model.predict_classes(x_test)    
    prob = model.predict(x_test)

    errors = np.where(y_pred == y_test)[0]
    print("No of errors = {}/{}".format(len(errors),len(y_test)))
    
    for i in range(len(errors[:5])):
        pred_class = np.argmax(prob[errors[i]])
        best_n = evaluation.get_n_best_pred_for_one_item(prob[errors[i]], k_results, idx2label)
        true_label = idx2label[y_test[errors[i]]]
        for index, best_result in best_n.iteritems():
            # print(best_result)
            print('Original label: [{}] n {}, Prediction :[{}], confidence : {:.3f}'.format(
            true_label,
			index,
            best_result['label_pred'],
            best_result['prob']))
            print(x_test[errors[i]])


        pred_label = idx2label[pred_class]
        true_label = idx2label[y_test[errors[i]]]

        print('Original label: [{}], Prediction :[{}], confidence : {:.3f} \n'.format(
            true_label,
            pred_label,
            prob[errors[i]][pred_class]))

    report = metrics.classification_report(y_test, y_pred, target_names=[str(l) for l in idx2label.values()])
    print (report)

    for k in range(1, k_results+1):
        score = evaluation.top_n_accuracy(prob, y_test, k)
        scores_k_rank.append(score)
        print("Test final topRang{}: {:.3f}%".format(k, score))
    

    # scores = model.evaluate(x_test, y_test)  
    results =  (report, scores_k_rank)   
    print("Test final with the best of the best: %2.4f %%"%(metrics.accuracy_score(y_test, y_pred)))
    util.write_file_error_by_name(prob, y_test, x_test_origin, idx2label)
    util.write_file_results(prob, y_test, x_test_origin, x_test, idx2label)
    return results

def write_report_unique(info_run, results, dir_save = "data/report"):
    name_date = 'report-{date:%Y-%m-%d_%H%M%S}'.format( date=datetime.datetime.now() )
    if not(os.path.exists(dir_save)):
        os.makedirs(dir_save)
    with open(os.path.join(dir_save, name_date + "_config_nn.txt"), 'w') as fic:
        json.dump(info_run, fic, indent=4)
    with open(os.path.join(dir_save, name_date +"_result_nn.txt"), 'w') as fic:
        report, scores_k_rank = results
        for k, score in enumerate(scores_k_rank):
            fic.write("Resultats rank {} :{:.3f}\n".format(k, score))
        fic.write(report)


## just for test, 
def focal_loss(y_true, y_pred):
    gamma = 2.0
    alpha = 0.25
    pt_1 = tf.where(tf.equal(y_true, 1), y_pred, tf.ones_like(y_pred))
    pt_0 = tf.where(tf.equal(y_true, 0), y_pred, tf.zeros_like(y_pred))
    return -K.sum(alpha * K.pow(1. - pt_1, gamma) * K.log(pt_1))-K.sum((1-alpha) * K.pow( pt_0, gamma) * K.log(1. - pt_0))
