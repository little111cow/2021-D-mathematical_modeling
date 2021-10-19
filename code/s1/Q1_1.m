%% 问题1
[data_1_0,text_1]=xlsread('ERα_activity.xlsx');
[data_2_0,text_2]=xlsread('Molecular_Descriptor.xlsx');
%% 数据归一化
data_1=mapminmax(data_1_0',0,1)'; %mapminmax按行归一，需按列归一
data_2_1=mapminmax(data_2_0',0,1)';
%data_2_1=data_2_0;

%% 部分无用值剔除（即其值固定无波动）
Var_data_2=var(data_2_1); %计算方差
L_use=find(Var_data_2~=0); %定位
N=length(L_use); 
data_2=data_2_1(:,Var_data_2~=0);
text_use=cell(N,1); %部分数据剔除后，对应分子名称更新
for k=1:N
    text_use{k,1}=text_2{1,L_use(k)+1};
end
L_unuse=find(Var_data_2==0);
N_unuse=length(L_unuse);
text_unuse=cell(N_unuse,1); %部分数据剔除后，对应分子名称更新
for k=1:N_unuse
    text_unuse{k,1}=text_2{1,L_unuse(k)+1};
end

%% 问题1——计算皮尔逊线性相关系数、斯皮尔曼秩（或Kendall）相关系数
N=length(data_2(1,:));
R_result_P=zeros(2,N); %记录线性相关系数
P_result_P=zeros(2,N); %记录线性相关显著性指标p值
R_result_S=zeros(2,N); %记录非线性相关系数
P_result_S=zeros(2,N); %记录非线性相关显著性指标p值
y1=data_1(:,1); %IC50_nM(值越小：代表生物活性越大，对抑制ERα活性越有效)
y2=data_1(:,2); %pIC50(值越大：表明生物活性越高,，对抑制ERα活性越有效)
for k=1:N
    x=data_2(:,k);
%     fig1=scatter(x,y1);
%     % saveas(fig1,strcat('1-',num2str(k),'.jpg'));
%     fig2=scatter(x,y2);
%     saveas(fig2,strcat('2-',num2str(k),'.jpg'));
    [R_result_P(1,k),P_result_P(1,k)]=corr(x,y1); % 计算IC50_nM的线性相关系数
    [R_result_P(2,k),P_result_P(2,k)]=corr(x,y2); % 计算IC50_nM的线性相关系数
    [R_result_S(1,k),P_result_S(1,k)]=corr(x,y1,'type','Spearman'); % 计算IC50_nM的非线性相关系数
    [R_result_S(2,k),P_result_S(2,k)]=corr(x,y2,'type','Spearman'); % 计算IC50_nM的非线性相关系数
    
end

%% 数据读取
[data_select_1,text_select]=xlsread('相关系数.xlsx','Sheet1');
[data_select_2,~]=xlsread('相关系数.xlsx','Sheet2');
[data_select_3,~]=xlsread('相关系数.xlsx','Sheet3');

%% 数据整合
data_select_use=[abs(data_select_1(:,1))';abs(data_select_2(:,1))';abs(data_select_3(:,1))']; % 变成了3行
data_select_use_max=max(data_select_use); %取最大值  %%%%%%%%%%%评判依据
data_select_use_max_sort=sort(data_select_use_max,2,'descend');
% 各类相关最大值排序
text_sort_2_M=cell(504,1);
data_sort_2_M=zeros(504,5);
k=1;
while k<=504 
    L_x=data_select_use_max_sort(k);
    L_2=find(abs(data_select_use_max)==L_x);
    n=length(L_2);
    for g=1:n
        L_r=data_select_use_max(L_2(g));
        data_sort_2_M(k+g-1,1:2)=[L_r,L_2(g)];
        data_sort_2_M(k+g-1,3:5)=data_select_use(:,L_2(g))';
        text_sort_2_M{k+g-1,1}=text_select{L_2(g)+1,1};
    end
    k=k+n;
%     display(strcat(text{L_x,1},num2str(L_x),',',num2str(L_2),',',num2str(L_p)))
end

