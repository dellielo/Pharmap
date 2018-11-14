import numpy as np
import os 
import conf
import datetime
from keras.models import model_from_yaml

def write_file_error_by_name(y_pred, y_test, x_test,  idx2label, dir_save = 'data/debug'):
    if not os.path.exists(dir_save):
        os.makedirs(dir_save)
    for i, t in enumerate(set(y_test)):
        idx = np.where(y_test == t)[0]
        name_coraux = idx2label[t]
        # errors = np.where(y_pred != y_test)[0]
        # print("[{}] No of errors = {}/{}".format(name_coraux, len(errors),len(y_test)))
        with open(os.path.join(dir_save, "{}_res.csv".format(name_coraux)), 'w') as fic:
            fic.write("true; pred; sanction; carac\n")
            
            for _, item in enumerate(idx):
                pass #/!\ todo: to fix
                # pred_class = np.argmax(prob[item])
                # true_label = idx2label[y_test[item]]
                # pred_label = idx2label[y_pred[item]]
                # sanction = "OK" if true_label == pred_label else "ERROR"
                # str_data = ";".join("{:.4f}".format(x) for x in x_test[item])

                # fic.write("[{}];{};{};{}\n".format(true_label, pred_label, sanction, str_data)) # x_test[item],

def write_data_by_name(x, y, idx2label, dir_save = 'data/debug'):
    if not os.path.exists(dir_save):
        os.makedirs(dir_save)
    for i, t in enumerate(set(y)):
        idx = np.where(y == t)[0]
        name_coraux = idx2label[t]
        with open(os.path.join(dir_save, "{}_info.csv".format(name_coraux)), 'w') as fic:
            for index, item in enumerate(idx):
                pass  #/!\ todo: to fix
                # pred_class = np.argmax(prob[item])
                # print(y.reset_index(drop=True))
                # print(y[idx[item]], item, idx2label)
                # true_label = idx2label[y[item]]
                # print(x[idx[item]])
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
    # with open(os.path.join(dir_save, "data_input.csv"), 'w') as fic:
    #     for x_item, y_item in zip(x,y):
    #         true_label = idx2label[y_item]
    #         str_data = ";".join("{:.2f}".format(i) for i in x_item)
    #         fic.write("{};{}\n".format(true_label, str_data))

def save_model(model, dir_save = 'data/model'):

    name_date = 'model-{date:%Y-%m-%d_%H:%M:%S}'.format(date=datetime.datetime.now())
    if not os.path.exists(dir_save):
        os.makedirs(dir_save)

    # serialize model to YAML
    model_yaml = model.to_yaml()
    with open(os.path.join(dir_save, name_date+".yaml"), "w") as yaml_file:
        yaml_file.write(model_yaml)
    # serialize weights to HDF5
    model.save_weights(os.path.join(dir_save, name_date+".h5"))
    print("Saved model to disk")

def load_model(name_model, dir_save = 'data/model'):
    # load YAML and create model
    yaml_file = open(os.path.join(dir_save, name_model+'.yaml'), 'r')
    loaded_model_yaml = yaml_file.read()
    yaml_file.close()
    loaded_model = model_from_yaml(loaded_model_yaml)
    # load weights into new model
    loaded_model.load_weights(open(os.path.join(dir_save, name_model+'.h5'))