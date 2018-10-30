import conf

# https://imbalanced-learn.readthedocs.io/en/stable/over_sampling.html
from imblearn.over_sampling import SMOTE, ADASYN, BorderlineSMOTE

def smote(x, y): # balnce dataset by using SMOTE algorithm to oversample
    sm = SMOTE('not majority')
    x_out, y_out = sm.fit_sample(x, y)
    return (x_out, y_out)

def makeOverSamples(X,y):
    sm = SMOTE()
    X, y = sm.fit_resample(X, y)
    return X,y