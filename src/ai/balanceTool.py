import conf
from imblearn.over_sampling import SMOTE

def smote(x, y): # balnce dataset by using SMOTE algorithm to oversample
    sm = SMOTE('not majority')
    x_out, y_out = sm.fit_sample(x, y)
    return (x_out, y_out)