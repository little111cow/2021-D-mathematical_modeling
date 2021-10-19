% x-x-x-x-x-x
load('for23_5.mat')
PP1=p_2_20;
load('for23-5-5-3.mat')
PP2=p_2_20;
load('for23-5-5-3-2-2.mat')
data_16_4_4_3_3_2=cell(29,1);
data_16_4_4_3_3_2_n=zeros(29,1);
data_16_4_4_3_3_2_k=zeros(29,1);
data_max_16_4_4_3_3_2=zeros(KK,1);
text_data_7_6_5_2_1_2=cell(6,1);
L_0=p{1,23}; 
L_1=PP1{1,5};
L_1_1=PP2{1,2};
for k=1:2
    L_2=p_2_20{1,k};
    L_3=L_1_1(L_2);
    L_4=L_1(L_3);
    L=L_0(L_4);
    data_max_16_4_4_3_3_2(k)=max(data_select_use_max(L));
    data_use_2=data_2(:,L);
    Cor_data_use_2=corr(data_use_2,'type','Spearman');
    Cor_data_use_1=corr(data_use_2);
    text_data_7_6_5_2_1_2{k,1}=text_use(L,1);
    if min(min(Cor_data_use_2))<0.85 && min(min(Cor_data_use_1))<0.85
        display(k)
        data_16_4_4_3_3_2_k(k,1)=k;
        data_16_4_4_3_3_2{k,1}=data_use_2;
        [coeff,score,latent] = pca(data_use_2); % 利用主成分分析
        w_sum=0;
        n=0;
        while w_sum<0.85
            n=n+1;
            w_sum=(w_sum*sum(latent)+latent(n))/sum(latent);
        end
        display(n) %最终n=29
        data_16_4_4_3_3_2_n(k,1)=n;
        save(strcat('23-5-5-3-2-2-',num2str(k),'-',num2str(n),'.mat'),'data_use_2')
    end
end