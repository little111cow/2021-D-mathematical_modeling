%29类
load('dcor.mat')
KK=29;
data_data=cell(KK,1);
data_n=zeros(KK,1);
data_k=zeros(KK,1);
data_max=zeros(KK,1);
text_data=cell(KK,1);
for k=1:KK
    L=p{1,k};
    data_max(k)=max(data_select_use_max(L));
    data_use_2=data_2(:,L);
    Cor_data_use_2=corr(data_use_2,'type','Spearman');
    Cor_data_use_1=corr(data_use_2);
    text_data{k,1}=text_use(L,1);
    if min(min(Cor_data_use_2))<0.85 && min(min(Cor_data_use_1))<0.85
        display(k)
        data_k(k,1)=k;
        data_data{k,1}=data_use_2;
        [coeff,score,latent] = pca(data_use_2); % 利用主成分分析
        w_sum=0;
        n=0;
        while w_sum<0.85
            n=n+1;
            w_sum=(w_sum*sum(latent)+latent(n))/sum(latent);
        end
        display(n) %最终n=29
        data_n(k,1)=n;
        % save(strcat(num2str(k),'-',num2str(n),'.mat'),'data_use_2')
    end
end

