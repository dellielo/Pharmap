import tensorflow as tf
from tensorflow import keras
import conf

class NeuralNetwork:

    def __init__(self, outputNb):
        self.createNn(outputNb)

    def createNn(self, outputNb):
        self.model = keras.Sequential([
            keras.layers.Flatten(input_shape=(len(conf.inputFileds),)),
            keras.layers.Dense(240, activation=tf.nn.relu),
            keras.layers.Dense(128, activation=tf.nn.relu),
            keras.layers.Dense(outputNb, activation=tf.nn.softmax)
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

    def test(self, testInput, testOutput):
        test_loss, test_acc = self.model.evaluate(testInput, testOutput)
        print('Test accuracy:', test_acc, "loss: ", test_loss)

    def train(self, trainInput, trainOutput):
        self.model.fit(trainInput, trainOutput, epochs=100)