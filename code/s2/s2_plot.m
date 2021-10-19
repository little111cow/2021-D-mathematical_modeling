%% 加载数据
load ps;  %加载归一化状态用于反归一化
load('y_res.mat');  %模型评估时真实数据
load('regr_res.mat');  %模型评估时的预测数据
load('y_2.mat')  %模型得到的测试集预测数据

%% 按照归一化活性的方法，ps记录，反归一化各个数据
a=mapminmax('reverse',y_res,ps);  %真实值按照ps所保存的归一化状态，反归一化得真实数据
b=mapminmax('reverse',regr_res,ps);  %模型评估预测值按照ps所保存的归一化状态，反归一化得真实数据
d=mapminmax('reverse',y_2,ps);  %模型对测试数据的预测值按照ps所保存的归一化状态，反归一化得最终预测数据

%% 预测结果
plot(d,'*--','color','red');
title('测试样本的预测结果')
xlabel('样本号')
ylabel('pIC50')

%% 画出回归测试图像，模型拟合效果
l=length(a);
figure
plot(1:l,a(1:l),'*--')
hold on
plot(1:l,b(1:l),'x--','linewidth',1.5)
legend('true','pridict')
title('adaBoost')
xlabel('样本')
ylabel('pIC50')

% %% 计算回归模型的平均绝对误差误差
disp(['adaboost回归器的平均绝对误差为：',num2str(mean(abs(a'-b)))])

