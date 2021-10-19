clc;clear;close all
%%说明：注释掉的部分代码为模型评估的过程代码，需要改变训练和测试集的定义
%训练集和测试集均用训练集来分，部分用于训练，其余用于测试
%% 加载数据
load('data_set_select');  %选取出来的20个变量的归一化数据
data=data_select_result;
load('for-question2_and_question3.mat');  %50个测试数据相应的20个变量的未归一化数据
test_data=data_2_test_use_1;
test_data=mapminmax(test_data',0,1);  %归一化测试数据
test_data=test_data';
admet_training = xlsread('ADMET.xlsx');  %读取ADMET性质作为标签

%% PCA分析
dim = 5;  %PCA降维后取的主成分维数
N_train=400;  %在训练数据中选取400个作为KNN训练数据
admet_var = 1;  %用于ADMET第一列性质预测
[coeff,demension_dec,latent] = pca(data);  %训练数据PCA分析
[coff,test_demension_dec,latent_test] = pca(test_data);%测试数据PCA分析
data_dec = demension_dec(:,1:dim);  %降到dim维
test_data_dec = test_demension_dec(:,1:dim);

%% 数据集
test=zeros(50,dim+1);
test(:,1:end-1) = test_data_dec;  %测试数据
%把50个数据标签全部置为1，本身不起作用，只为了KNNmain与函数适应，最终的预测标签为pridicted对应的值
test(:,end) =ones(50,1);  

%取400个训练数据训练KNN
train =zeros(N_train,dim+1);
% test =zeros(1974-N_train,dim+1);  %初始化

train(:,1:end-1)= data_dec(1:N_train,:);
train(:,end) = admet_training(1:N_train,admet_var);

% test(:,1:end-1) = data_dec(N_train+1:end,:);  %测试数据
save test;  %保存便于KNNmain函数读取
save train;  %保存便于KNNmain函数读取
% test(:,end) = admet_training(N_train+1:end,admet_var);  %测试标签

acc=KNNmain(80);  %进行预测
% plot(N_train,acc,'*--','linewidth',1.5);
% title('CaCo-2:KNN分类模型准确率随训练样本数变化的曲线');
% xlabel('训练样本数')
% ylabel('预测准确率')
% legend('CaCo-2-KNN预测模型')