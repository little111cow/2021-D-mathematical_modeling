load('data_set_select');  %加载筛选出的20个变量
data=data_select_result;
activity = xlsread('ERα_activity.xlsx');  % 加载活性数据
load('for-question2_and_question3.mat');  %加载测试数据
test=data_2_test_use_1;
test=mapminmax(test',0,1);  %测试数据归一化
test=test';
activity = activity(:,2);  %使用PIC50活性值，作为回归模型输出

[activity_norm,ps] = mapminmax(activity',0,1);  %数据归一化
activity_norm = activity_norm';

dim = 15;  %pca分析降维维数
[coeff,demension_dec,latent] = pca(data);  %训练数据PCA降维
data_dec = demension_dec(:,1:dim);  %降到dim维
[coff,test_demension_dec,latent_test] = pca(test);  %测试数据PCA降维
data_dec = demension_dec(:,1:dim);  %降到dim维

test_data_dec = test_demension_dec(:,1:dim);

train_data = data_dec;
train_y = activity_norm;

test_data = test_data_dec;
save train_data;
save train_y;
save test_data;
save ps;  %保存归一化记录，用于反归一化