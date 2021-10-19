% 29-X
load('for16_4.mat')
data_2_20=cell(29,1);
data_n_2_20=zeros(29,1);
data_k_2_20=zeros(29,1);
data_max_2_20=zeros(KK,1);
text_data_7=cell(6,1);
L_0=p{1,16};
for k=1:4
    L_1=p_2_20{1,k};
    L=L_0(L_1);
    data_max_2_20(k)=max(data_select_use_max(L));
    data_use_2=data_2(:,L);
    Cor_data_use_2=corr(data_use_2,'type','Spearman');
    Cor_data_use_1=corr(data_use_2);
    text_data_7{k,1}=text_use(L,1);
    if min(min(Cor_data_use_2))<0.85 && min(min(Cor_data_use_1))<0.85
        display(k)
        data_k_2_20(k,1)=k;
        data_2_20{k,1}=data_use_2;
        [coeff,score,latent] = pca(data_use_2); % 利用主成分分析
        w_sum=0;
        n=0;
        while w_sum<0.85
            n=n+1;
            w_sum=(w_sum*sum(latent)+latent(n))/sum(latent);
        end
        display(n) %最终n=29
        data_n_2_20(k,1)=n;
        save(strcat('19_2-',num2str(k),'-',num2str(n),'.mat'),'data_use_2')
    end
end

