import tensorflow as tf
from tensorflow import keras
import conf
import numpy as np
from sklearn import metrics
import util


class NeuralNetwork:

    def __init__(self, outputNb):
        self.createNn(outputNb)
        self.outputNb = outputNb

    def createNn(self, outputNb):
        inputNb = len(conf.inputFileds)
        self.model = keras.Sequential([
            keras.layers.Flatten(input_shape=(inputNb,)),
            keras.layers.Dense(240, activation='relu'),
            keras.layers.Dense(128, activation='relu'),
            keras.layers.Dense(outputNb, activation='softmax')
        ])

        self.model.compile(optimizer=tf.train.AdamOptimizer(),
                      loss='sparse_categorical_crossentropy',
                      metrics=['accuracy'])

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


    def train(self, trainInput, trainOutput, epochs=100):
        self.model.fit(trainInput, trainOutput, epochs=epochs)


    def test(self, x_test, y_test, labels):
        y_pred = self.predict_classes(x_test)
        prob = self.predict(x_test)

        idx2label = dict((v,k) for k,v in zip(labels, range(0,self.outputNb)))
        print(idx2label)
        errors = np.where(y_pred != y_test)[0]
        print("No of errors = {}/{}".format(len(errors),len(y_test)))

        for i in range(len(errors[:5])):
            pred_class = np.argmax(prob[errors[i]])
            print(pred_class)
            pred_label = idx2label[pred_class]
            true_label = idx2label[y_test[errors[i]]]

            print('Original label: [{}], Prediction :[{}], confidence : {:.3f}'.format(
                true_label,
                pred_label,
                prob[errors[i]][pred_class]))

        report = metrics.classification_report(y_test, y_pred, target_names=[str(l) for l in labels])
        print (metrics.classification_report(y_test, y_pred, target_names=[str(l) for l in labels]))
        util.write_file_error_by_name(y_pred, y_test, x_test, idx2label)
        scores = self.evaluate(x_test, y_test)  
        results =  (report, scores)   
        return results

def write_report_unique(info_run, results, dir_save = "data/report"):
    import json, os
    import datetime 

    
    name_date = 'report-{date:%Y-%m-%d_%H:%M:%S}'.format( date=datetime.datetime.now() )
    if not(os.path.exists(dir_save)):
        os.makedirs(dir_save)

    with open(os.path.join(dir_save, name_date + "_config_nn.txt"), 'w') as fic:
        json.dump(info_run, fic, indent=4)
    with open(os.path.join(dir_save, name_date +"_result_nn.txt"), 'w') as fic:
        report, scores = results
        fic.write("Resultas tests: accuracy %f loss % f\n" % (scores[1], scores[0]))
        fic.write(report)


