from sklearn.model_selection import train_test_split
from sklearn.ensemble import AdaBoostRegressor
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import GridSearchCV

import scipy.io as sio

#  加载数据，模型评估建立时使用的训练数据和测试数据，预测时注释掉
data_mat = sio.loadmat('train_data.mat')
reg_mat = sio.loadmat('train_y.mat')
X = data_mat['train_data']
y = reg_mat['train_y']

# 用于训练和评估模型和调参，预测时注释掉
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=1, test_size=0.2)

######################决策树和adaboost回归器
regr_2 = AdaBoostRegressor(base_estimator=DecisionTreeRegressor(max_depth=11), n_estimators=250, random_state=1, learning_rate=0.2, loss='linear')

#  网格搜索调参，分多次单个参数进行搜索分别找到最佳参数，主要调节了max_depth、n_estimators、learning_rate
# param_test1 = {'n_estimators': range(50, 1000, 50)}
# gsearch1 = GridSearchCV(estimator=regr_2, param_grid=param_test1)
# gsearch1.fit(X_train, y_train.ravel())
# print(f'{gsearch1.best_params_}+:{gsearch1.best_score_}')

#  训练回归模型
regr_2.fit(X_train, y_train.ravel())

# 预测
y_2 = regr_2.predict(X_test)
print('adaBoost回归器:', regr_2.score(X_test, y_test.ravel()))  # 评估模型用的R2值，预测时注释掉，预测时注释掉

sio.savemat('regr_res.mat', {'regr_res': y_2})  # 保存模型评估结果，预测时注释掉
sio.savemat('y_res.mat', {'y_res': y_test})  # 保存评估模型测试数据对应的真值，预测时注释掉
