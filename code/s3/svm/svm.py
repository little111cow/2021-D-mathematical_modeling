from sklearn import svm
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix
from sklearn.metrics import plot_confusion_matrix
from sklearn.metrics import accuracy_score
import matplotlib.pyplot as plt
import scipy.io as sio   # 用于加载mat文件
import pickle
from sklearn.model_selection import GridSearchCV

# 划分训练集和测试集
data_mat = sio.loadmat(r'svm_data.mat')  #评估模型时用
label_mat = sio.loadmat(r'svm_label.mat')

# train_data, test_data, train_label, test_label = train_test_split(data_mat['svm_data'], label_mat['svm_label'],
#                                                                   random_state=1, test_size=0.2)  #评估模型时用，最终预测模型时注释掉

# 用于最终预测时加载训练和测试数据,评估模型时注释掉
train_datamat = sio.loadmat('train_data.mat')  # 最终预测模型时用
train_labelmat = sio.loadmat('train_label.mat')
test_datamat = sio.loadmat('test_data.mat')

train_data = train_datamat['train_data']
train_label = train_labelmat['train_label']
test_data = test_datamat['test_data']

# 训练svm分类器，根据分类预测模型2，3，5按照论文中的参数进行修改
classifier = svm.SVC(C=40, kernel='rbf', gamma=14, decision_function_shape='ovr')
classifier.fit(train_data, train_label.ravel())

## 模型调参时用
# param_test1 = {'kernel': ['rbf', 'linear', 'sigmoid', 'poly']}
# param_test1 = {'C': range(1, 100, 1)}
# param_test1 = {'gamma': range(1, 100, 1)}
# gsearch1 = GridSearchCV(estimator=classifier, param_grid=param_test1)
# gsearch1.fit(train_data, train_label.ravel())
# print(f'{gsearch1.best_params_}+:{gsearch1.best_score_}')

# 计算分类器的分类准确率
train_fit = classifier.predict(train_data)
test_fit = classifier.predict(test_data)
print(test_fit)
sio.savemat('model5_pridict.mat', {'test_fit': test_fit})  # 保存模型预测输出，对应修改模型名称为model[2,3,5]_pridict.mat
print("训练集：", accuracy_score(train_label, train_fit))
# print("测试集：", accuracy_score(test_label, test_fit))  #评估模型

model = pickle.dumps(classifier)  #保存模型
with open('svm.model', 'wb+') as f:
	f.write(model)
print("done")

# # 绘制混淆矩阵，评估模型时用
# confusion_matrix = confusion_matrix(test_label, test_fit)
# N_class = 2
# classes = []
# for i in range(1, N_class+1):
#     classes.append(str(i))
# titles_options = [("Confusion matrix,without normalization", None),
#                   ("Normalized confusion matrix", 'true')]
#
# for title, normalize in titles_options:
#     disp = plot_confusion_matrix(classifier, test_data, test_label,
#                                  display_labels=classes,
#                                  cmap=plt.cm.Blues,
#                                  normalize=normalize)
#     disp.ax_.set_title(title)
# plt.show()

