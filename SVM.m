%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%作用：数据加载以及计算数据长度并保存在n中。               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;
close all;

%加载数据
m1=load('C_Difficult2_noise02.mat');
j=0;
for i=1:size(m1.spike_times{1,1},2)
    if m1.spike_class{1,2}(1,i)==0
        j=j+1;
        waveforms01(j,:)=m1.data(1,m1.spike_times{1,1}(1,i):m1.spike_times{1,1}(1,i)+78);
        label1(j,1)=m1.spike_class{1,1}(1,i);
    end
end

num=j;

model1=svmtrain(label1,waveforms01,'-t 0');

m2=load('C_Difficult2_noise02.mat');
j=0;
for i=1:size(m2.spike_times{1,1},2)
    if m2.spike_class{1,2}(1,i)==0
        j=j+1;
        label2(j,1)=m2.spike_class{1,1}(1,i);
        waveforms04(j,:)=m2.data(1,m2.spike_times{1,1}(1,i):m2.spike_times{1,1}(1,i)+78);
    end
end

predict1=svmpredict(label2,waveforms04,model1)';

