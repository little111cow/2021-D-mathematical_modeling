clc;clear;close all;
cd C:\Users\小牛犊\Desktop\数学建模\2021年D题
N=729;
activity = xlsread('ERα_activity.xlsx');
descriptor_training = xlsread('Molecular_Descriptor.xlsx',1);  %分子描述符训练数据
descriptor_test = xlsread('Molecular_Descriptor.xlsx',2);  %分子描述符测试数据
admet_training = xlsread('ADMET.xlsx'); %性质

cd C:\Users\小牛犊\Desktop\数学建模\2021年D题\code\s1
%%  归一化数据
activity_norm = mapminmax(activity',0,1);
descriptor_training_norm = mapminmax(descriptor_training',0,1);
descriptor_test_norm = mapminmax(descriptor_test',0,1);



%% 筛出方差不为零的变量
j=1;
for i=1:N
    if var(descriptor_training_norm(i,:))~=0
        descriptor_training_byvar(j,:)=descriptor_training_norm(i,:);
        descriptor_index(j)=i;  %对应变量在xlxs表中的索引位置
        j=j+1;
    end
end
save activity_norm;
save descriptor_training_byvar;
%测试数据选出和上边相同的变量
for i=1:length(descriptor_index)
    descriptor_test_byvar(i,:) = descriptor_test_norm(descriptor_index(i),:);
end

N_class = 50;
[idx,C,sumd,D] = kmeans(descriptor_training_byvar,N_class);

for i=1:N_class
    p{i}=find(idx==i);
end


%% 在聚类各个类中找出相关系数最大的那个变量所在索引
load('coff1.mat');
topn = zeros(1,N_class);
for i=1:N_class
    temp = coff1(p{i}(1:length(p{i})));
    for j=1:length(temp)
        if coff1(p{i}(j))==max(temp)
            topn(i)=p{i}(j);
        end
    end
end
topn =sort(topn);
%% 排序筛出前20个
res = zeros(1,20);

temp = coff1(topn(1:N_class));
temp1 = sort(temp,'descend');   
th = temp1(20);

j=1;
for i=1:N_class
    if coff1(topn(i))>=th
        res(j)=topn(i);
        j=j+1;
    end
end
res= sort(res);

