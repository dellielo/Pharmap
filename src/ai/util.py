import numpy as np
import os 

def get_idx2label(tab):
    labels = sorted(tab['ScientificName'].unique())
    idx2label = dict((v,k) for k,v in zip(labels, range(0,len(labels))))
    return idx2label

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
                # pred_class = np.argmax(prob[item])
                true_label = idx2label[y_test[item]]
                pred_label = idx2label[y_pred[item]]
                sanction = "OK" if true_label == pred_label else "ERROR"
                str_data = ";".join("{:.4f}".format(x) for x in x_test[item])

                fic.write("[{}];{};{};{}\n".format(true_label, pred_label, sanction, str_data)) # x_test[item],

def write_data_by_name(x, y, idx2label, dir_save = 'data/debug'):
    if not os.path.exists(dir_save):
        os.makedirs(dir_save)
    for i, t in enumerate(set(y)):
        idx = np.where(y == t)[0]
        name_coraux = idx2label[t]
        with open(os.path.join(dir_save, "{}_info.csv".format(name_coraux)), 'w') as fic:
            for index, item in enumerate(idx):
                # pred_class = np.argmax(prob[item])
                true_label = idx2label[y[item]]
                str_data = ";".join("{:.2f}".format(x) for x in x[item])
                fic.write("{};{}\n".format(true_label, str_data)) # x_test[item],
