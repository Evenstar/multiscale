from sklearn import cross_validation
from sklearn.svm import SVC
import numpy as np,h5py
mat=h5py.File('mnist_myfilter.mat','r')
train_x=np.array(mat.get('seqx')).transpose()
train_y=np.ravel(np.array(mat.get('seqy')))
train_x=train_x[0:3000,:]
train_y=train_y[0:3000]
shuffle = np.random.permutation(np.arange(train_x.shape[0]))
train_x, train_y = train_x[shuffle], train_y[shuffle]
clf = SVC(kernel="linear", C=1)
# Train and validate the model with 7-fold cross validation
scores = cross_validation.cross_val_score(clf, train_x, train_y, cv=3)
print scores
