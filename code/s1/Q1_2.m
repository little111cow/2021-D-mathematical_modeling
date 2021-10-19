%% 计算分子间相关性、分类
corr_data_2=corr(data_2);
[M1,N1]=find(corr_data_2>=0.85 & corr_data_2<1 );
MN=[M1,N1];

%% 利用主成分分析
[coeff,score,latent] = pca(data_2); % 利用主成分分析
% 以贡献率为85%作为筛选的依据
w_sum=0;
n=0;
while w_sum<0.85
    n=n+1;
    w_sum=(w_sum*sum(latent)+latent(n))/sum(latent);
end
display(n) %最终n=29
