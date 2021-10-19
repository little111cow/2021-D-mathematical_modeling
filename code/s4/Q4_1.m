%% 数据读取
[data_1_0,text_1]=xlsread('ERα_activity.xlsx'); %活性
[data_2_0,text_2]=xlsread('Molecular_Descriptor.xlsx'); %化合物-分子
[data_3_0,text_3]=xlsread('ADMET.xlsx'); %ADMET性质
%% 数据处理-部分无用值剔除（即其值固定无波动）
Var_data_2=var(data_2_0); %计算方差
L_use=find(Var_data_2~=0); %定位
N=length(L_use); 
data_2=data_2_0(:,Var_data_2~=0);
text_use=text_2(1,L_use+1);
data_3_1=zeros(size(data_3_0));
data_3_1(:,[1,2,4])=data_3_0(:,[1,2,4]);
data_3_1(:,[3,5])=abs(data_3_0(:,[3,5])-1);
z_sum=sum(data_3_1,2);
L_use_select=[440,55,11,353,102,4,5,366,419,493,174,91,56,482,284,439,99,42,221,406];
y2=data_1_0(:,2);
data_select_result=data_2(:,L_use_select);
F1=quantile(y2,0.5,1); %抑制ERα是否具有更好的生物活性的临界指标
L_1=find(y2>=F1 & z_sum>=3);
L_2=find(y2<F1 | z_sum<3);
data_CC1=data_select_result(L_1,:);
data_CC2=data_select_result(L_2,:);
maxxx=max(data_select_result);
mixxx=min(data_select_result);
H=zeros(4,20);
for k=1:20
    x1=data_CC1(:,k);
    x2=data_CC2(:,k);
    H(1,k) = jbtest(x1,0.05);
    H(2,k) = jbtest(x2,0.05);
    H(3,k) = kstest2(x1,x2);
    H(4,k) = ttest2(x1,x2);
    fig2=figure;
    subplot(2,2,1);hist(x1,30);title('x1')
    subplot(2,2,2);hist(x2,30);title('x2')
    subplot(2,2,3);plot(x1,'*');title('x1')
    subplot(2,2,4);plot(x2,'*');title('x2')
    %saveas(fig2,strcat('20-',num2str(k),'.jpg'));
end

%% 临界值查找
k=9; % 根据显著性检验情况，手动改写k值，k=1，2……，17，19，20
R_result_P_x=zeros(4,100);
P_1=0.5;
P_2=0.5;
x1=data_CC1(:,k);
x2=data_CC2(:,k); 
Z_1=quantile(x1,P_1,1);
Z_2=quantile(x2,P_2,1);
R_result_P_x(:,1)=[P_1;P_2;Z_1;Z_2];
if Z_1>Z_2
    K_z=1;
else
    K_z=-1;
end
n=0;
while K_z*(Z_1-Z_2)>0
    n=n+1;
    P_1=P_1-K_z*0.01;
    P_2=P_2+K_z*0.01;
    Z_1=quantile(x1,P_1,1);
    Z_2=quantile(x2,P_2,1);
    R_result_P_x(:,n+1)=[P_1;P_2;Z_1;Z_2];
end
display(strcat('迭代',num2str(n),'次'))
