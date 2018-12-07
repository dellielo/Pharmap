import numpy as np
import os 
import conf
import datetime
import tensorflow as tf
from tensorflow import keras
from sklearn.externals import joblib
import json

def write_file_error_by_name(probs, y_test, x_test, idx2label, dir_save = 'data/debug'):
    n = 5
    if not os.path.exists(dir_save):
        os.makedirs(dir_save)
    for i, t in enumerate(set(y_test)):
        idx = np.where(y_test == t)[0]
        name_coraux = idx2label[t]
        
        with open(os.path.join(dir_save, "{}_res.csv".format(name_coraux)), 'w') as fic:
            fic.write("true; pred; sanction; carac\n") 
            for _, item in enumerate(idx):
                str_results = ""
                true_label = idx2label[y_test[item]]
                pred_class =  np.argsort(probs[item, :])[::-1][:n] #[-n:] 
                for k in pred_class:
                    pred_label= idx2label[k]
                    str_results += "[{}: {:.3f}]; ".format(pred_label, probs[item, k])
                    # print(probs.shape, probs[k].shape)
                
                sanction = "OK" if true_label == idx2label[pred_class[0]]  else "ERROR"
                fic.write("[{}];{};{}; {} \n".format(true_label, sanction, str_results, x_test[item]))

def write_file_results(probs, y_test, x_test, x_test_transform, idx2label, dir_save = 'data/debug'):
    n = 5
    if not os.path.exists(dir_save):
        os.makedirs(dir_save)
    for i, t in enumerate(set(y_test)):
        idx = np.where(y_test == t)[0]
        name_coraux = idx2label[t]
        
    with open(os.path.join(dir_save, "__Aresult_all.csv"), 'w') as fic:
        fic.write("true; pred; sanction; carac\n") 
        for item, x in enumerate(probs):
            str_results = ""
            true_label = idx2label[y_test[item]]
            pred_class =  np.argsort(probs[item, :])[::-1][:n] #[-n:] 
            for k in pred_class:
                pred_label= idx2label[k]
                str_results += "[{}: {:.3f}]; ".format(pred_label, probs[item, k])
                # print(probs.shape, probs[k].shape)
            x_str = ','.join(map(str, x_test[item]))
            x_str_transform = ','.join(map(str, x_test_transform[item]))
            sanction = "OK" if true_label == idx2label[pred_class[0]]  else "ERROR"
            fic.write("[{}];{};{};[{}];[{}] \n".format(true_label, sanction, str_results, x_str, x_str_transform))

def write_data_by_name(x, y, idx2label, dir_save = 'data/debug'):
    if not os.path.exists(dir_save):
        os.makedirs(dir_save)
    for i, t in enumerate(set(y)):
        idx = np.where(y == t)[0]
        name_coraux = idx2label[t]
        with open(os.path.join(dir_save, "{}_info.csv".format(name_coraux)), 'w') as fic:
            for index, item in enumerate(idx):
                pass
                # pred_class = np.argmax(prob[item])
                # print(y.reset_index(drop=True))
                # print(y[idx[item]], item, idx2label)
                # true_label = idx2label[y[item]]
                # # print(x[idx[item]])
                # str_data = ";".join("{:.2f}".format(x) for x in x[item])
                # fic.write("{};{}\n".format(true_label, str_data)) # x_test[item],

def write_data(x, y, idx2label, dir_save = 'data/debug'):
    import conf
    import pandas as pd 
    df = pd.DataFrame(x, columns = conf.inputFileds)
    df[conf.outputField] = y

    if not os.path.exists(dir_save):
        os.makedirs(dir_save)       
    df.to_csv(os.path.join(dir_save, "data_input_pd.csv"), sep='\t')


def _save_extra_info(idx2label, scaler, dir_saved):
    with open(os.path.join(dir_saved, "idx2label.txt"), 'w') as fic:
        idx2label = json.dump(idx2label, fic, indent=4)
    
    # scaler
    joblib.dump(scaler, os.path.join(dir_saved, "scaler.txt"))  

def load_extra_info(dir_saved):
    with open(os.path.join(dir_saved, "idx2label.txt"), 'r') as fic:
        idx2label = json.load(fic)
    scaler = joblib.load(os.path.join(dir_saved,'scaler.txt')) 
    return idx2label, scaler

def save_model(model, info_run, idx2label, scaler, dir_save = 'data/model'):
    """Save the model, config, results, and for tensorflow serving
    
    :param model: the model created by NeuralNetwork
    :type model: keras model
    :param info_run: dict with all result and config 
    :type info_run: dict
    :param idx2label: Link between the index and the labels 
    :type idx2label: map or dict        
    :param scaler: to normalize input data  
    :type scaler: StandardScaler (scikit learn) 
    :param dir_save: where all data will be save , defaults to 'data/model'
    :param dir_save: str, optional
    :return: the name of the folder 
    :rtype: str
    """

    name_date = 'model-{date:%Y-%m-%d_%H%M%S}'.format(date=datetime.datetime.now())
    if not os.path.exists(dir_save):
        os.makedirs(dir_save)

    # serialize model to YAML
    model_yaml = model.to_yaml()
    with open(os.path.join(dir_save, name_date+".yaml"), "w") as yaml_file:
        yaml_file.write(model_yaml)
    # serialize weights to HDF5
    name_network = os.path.join(dir_save, name_date+".h5")
    model.save_weights(name_network)
    print("Saved model to disk " + name_network )

    name_version = 'savedModel/{date:%Y-%m-%d_%H%M%S}'.format(date=datetime.datetime.now())
    
    dir_saved_model = os.path.join(dir_save, name_version)
    # if not os.path.exists(dir_saved_model):
    #     os.makedirs(dir_saved_model)
    # import evaluation
    # outputs = evaluation.get_n_best_pred_for_one_item_tensor(model.output, 5, idx2label)
    # outputs = tf.convert_to_tensor(outputs)
    outputs = model.output
    signature = tf.saved_model.signature_def_utils.predict_signature_def(                                                                        
    inputs={'input': model.input}, outputs={'scores': outputs})                                                                         
                                                                                                                                             
    builder = tf.saved_model.builder.SavedModelBuilder(dir_saved_model)                                                                    
    builder.add_meta_graph_and_variables(                                                                                                        
        sess=keras.backend.get_session(),                                                                                                                    
        tags=[tf.saved_model.tag_constants.SERVING],                                                                                             
        signature_def_map={                                                                                                                      
            tf.saved_model.signature_constants.DEFAULT_SERVING_SIGNATURE_DEF_KEY:                                                                
                signature                                                                                                                        
        })                                                                                                                                       
    builder.save()
    
    _save_extra_info(idx2label, scaler, dir_saved_model)
    return name_date


def load_model(name_model, dir_save = 'data/model'):
    """Load the keras model 
    
    :param name_model: the name of the model (return by save_model)
    :type name_model: str
    :param dir_save: where all data will be save , defaults to 'data/model'
    :param dir_save: str, optional
    :return: the loaded model 
    :rtype: keras.models
    """

    # load YAML and create model 
    with open(os.path.join(dir_save, name_model+'.yaml'), 'r') as yaml_file:
        loaded_model_yaml = yaml_file.read()

    loaded_model = keras.models.model_from_yaml(loaded_model_yaml)
    # load weights into new model
    loaded_model.load_weights(os.path.join(dir_save, name_model+'.h5'))
    loaded_model.compile(optimizer='adam',  # 
                loss='sparse_categorical_crossentropy',
                metrics=['accuracy'])
    return loaded_model


def plot_model(model):
    from keras.utils import plot_model
    plot_model(model, to_file='head-model.svg', show_shapes=True)
      

def plot_hitory(history):
    import seaborn as sns
    df = pd.DataFrame({'epochs':history.epoch, 'accuracy': history.history['acc'], 'validation_accuracy': history.history['val_acc']})
    g = sns.pointplot(x="epochs", y="accuracy", data=df, fit_reg=False)
    g = sns.pointplot(x="epochs", y="validation_accuracy", data=df, fit_reg=False, color='green')
