%% 清空环境变量
clc
clear
close all

%% 加载数据
load 'C_Difficult1_noise02.mat'
j=0;
for i=1:size(spike_times{1,1},2)
    if spike_class{1,2}(1,i)==0
        j=j+1;
        waveforms(j,:)=data(1,spike_times{1,1}(1,i):spike_times{1,1}(1,i)+78);
        labels(j,1)=spike_class{1,1}(1,i);
    end
end
spike_num1=j;

%% PCA主成分分析
[pc,score,latent,tsquare] = princomp(waveforms);  %对data进行主成分分析
result=cumsum(latent)./sum(latent);    %表示贡献率，即部分特征值之和占总特征值的百分比
tranMatrix = pc(:,1:9);   %选贡献率高于85%即可
Pnew=waveforms*tranMatrix;    %得到新样本矩阵

%% k-means聚类
[idx,C] = kmeans(Pnew,3);  %Kmeans聚类分析分为3类
newData=[Pnew,idx];          %产生的带标号的数据newData，最后一列为标号
[p ,q]=size(newData);  %计算newData的行数和列数

%% 最后显示聚类后的图像
hold on;
for i=1:spike_num1
    if newData(i,q)==1   
         plot3(Pnew(i,1),Pnew(i,2),Pnew(i,3),'r.');     %取Pnew中前两列的数据进行观察
    elseif newData(i,q)==2
         plot3(Pnew(i,1),Pnew(i,2),Pnew(i,3),'g.'); 
    elseif newData(i,q)==3 
         plot3(Pnew(i,1),Pnew(i,2),Pnew(i,3),'b.'); 
    end
end
grid on;

%%
for i=1:spike_num1
    if idx(i,1)==3
        idx(i,1)=1;
    elseif idx(i,1)==2
        idx(i,1)=2;
    elseif idx(i,1)==1
        idx(i,1)=3;
    end
end

%% 准确率
error=0;
for i=1:spike_num1
    if idx(i,1)~=labels(i,1)
        error=error+1;
    end
end
rate=1-error/spike_num1;
