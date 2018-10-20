import tensorflow as tf
from tensorflow import keras
import conf

class NeuralNetwork:

    def __init__(self):
        self.createNn()

    def createNn(self):
        self.model = keras.Sequential([
            keras.layers.Flatten(input_shape=(len(conf.inputFileds),)),
            keras.layers.Dense(4, activation=tf.nn.relu),
            keras.layers.Dense(2, activation=tf.nn.softmax)
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

    def train(self, trainInput, trainOutput):
        self.model.fit(trainInput, trainOutput, steps_per_epoch=5000)