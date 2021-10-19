%% 聚类
load('./分类数据/2-20-7-4-3-4.mat'); %手动更改文件名，文件夹中数据已经完成分类，此处为了说明方法
N_class = 4;  %需要聚类的类别数
[idx,C,sumd,D] = kmeans(data_use_2',N_class);  %data_use_2为需要聚类的数据
for i=1:N_class
p_2_20{i}=find(idx==i);  %将各类数据归类
end
save ./分类数据/for2-20-7-4-3-4.mat  %均按照forx-x-x规范保存