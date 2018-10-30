import tensorflow as tf
from tensorflow import keras
import conf
import numpy as np
from sklearn import metrics

class NeuralNetwork:

    def __init__(self, outputNb):
        self.createNn(outputNb)
        self.outputNb = outputNb

    def createNn(self, outputNb):
        self.model = keras.Sequential([
            keras.layers.Flatten(input_shape=(len(conf.inputFileds),)),
            keras.layers.Dense(240, activation='relu'),
            keras.layers.Dense(128, activation='relu'),
            keras.layers.Dense(outputNb, activation='softmax')
        ])

        self.model.compile(optimizer=tf.train.AdamOptimizer(),
                      loss='sparse_categorical_crossentropy',
                      metrics=['accuracy'])

    ##  test another network, don't work very well"
    # def createNn(self, outputNb):
    #     print("len")
    #     print(outputNb, len(conf.inputFileds))

    #     self.model = keras.Sequential([
    #         keras.layers.Dense(64, activation='relu', input_dim=(len(conf.inputFileds))),
    #         keras.layers.Dropout(0.5),
    #         keras.layers.Dense(64, activation='relu'),
    #         keras.layers.Dropout(0.5),
    #         keras.layers.Dense(outputNb, activation='softmax')
    #     ])
    #     sgd = keras.optimizers.SGD(lr=0.01, decay=1e-6, momentum=0.9, nesterov=True)
    #     self.model.compile(optimizer=sgd,
    #                   loss='categorical_crossentropy',
    #                   metrics=['accuracy'])

    def predict(self, inputsToPredict): #input is an array
        pred = self.model.predict(inputsToPredict)
        return pred

    def predict_classes(self, inputsToPredict): #input is an array
        pred = self.model.predict_classes(inputsToPredict)
        return pred

    def train(self, trainInput, trainOutput, epochs=100):
        #if network works with "categorical_crossentropy"
        # trainOutput = keras.utils.to_categorical(trainOutput, num_classes=47)
        # print(trainInput.shape, trainOutput.shape)
        self.model.fit(trainInput, trainOutput, epochs=epochs)

    def evaluate(self, testInput, testOutput):
        testLoss, testAcc = self.model.evaluate(testInput, testOutput)
        print('Accuracy:', testAcc, "loss: ", testLoss)
        return testLoss, testAcc

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

        print (metrics.classification_report(y_test, y_pred, target_names=labels))