from sklearn.model_selection import train_test_split
from sklearn.ensemble import AdaBoostRegressor
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import GridSearchCV

import scipy.io as sio

# 加载数据，预测时使用的训练数据，模型评估时注释掉
data_mat = sio.loadmat('train_data.mat')
reg_mat = sio.loadmat('train_y.mat')
X_train = data_mat['train_data']
y_train = reg_mat['train_y']
test_mat = sio.loadmat('test_data.mat')
X_test = test_mat['test_data']

######################决策树和adaboost回归器
regr_2 = AdaBoostRegressor(base_estimator=DecisionTreeRegressor(max_depth=11), n_estimators=250, random_state=1, learning_rate=0.2, loss='linear')

#  训练回归模型
regr_2.fit(X_train, y_train.ravel())

# 预测
y_2 = regr_2.predict(X_test)

sio.savemat('y_2.mat', {'y_2': y_2})  # 保存预测结果，模型评估时注释掉
print('Done')

