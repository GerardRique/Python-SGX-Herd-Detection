import numpy as np
import pandas as pd


import sklearn
from sklearn.preprocessing import scale
from sklearn.linear_model import LogisticRegression
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn import preprocessing

import matplotlib.pyplot as plt

data_set = pd.read_csv('octave_data.csv')

data_set.columns = ['csad', 'equity', 'equity_abs', 'equity_squared']
equity = data_set.ix[:,1]
equity_squared = data_set.ix[:,3]
equity_abs = data_set.ix[:,2]


print(data_set.head())

data_subset = data_set.ix[:, (2, 3)]
y = data_set.ix[:,0]

X = scale(data_subset)

model = LinearRegression()

model.fit(X, y)
print(model.coef_)
print(model.intercept_)

y_pred = model.predict(X)

plt.scatter(equity_squared, y)
plt.show()
