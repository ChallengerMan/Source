%% 清空环境变量
clc
clear
close all

%% 数据加载

%加载信噪比为03的数据
load C_Easy1_noise04 spike_times spike_class data;
labels=zeros(1,1);
waveforms=zeros(1,79);
j=0;
for i=1:size(spike_class{1,1},2)
    if spike_class{1,2}(1,i)==0
        j=j+1;
       waveforms(j,:)=data(1,spike_times{1,1}(1,i):spike_times{1,1}(1,i)+78);
       labels(j,1)=spike_class{1,1}(1,i);
    end
end
train_num=size(waveforms,1);

%%
t=fitctree(waveforms,labels);

%%
Ynew=predict(t,waveforms);

%%
load C_Easy1_noise04 spike_times spike_class data;
labels1=zeros(1,1);
waveforms1=zeros(1,79);
j=0;
for i=1:size(spike_class{1,1},2)
    if spike_class{1,2}(1,i)==0
        j=j+1;
       waveforms1(j,:)=data(1,spike_times{1,1}(1,i):spike_times{1,1}(1,i)+78);
       labels1(j,1)=spike_class{1,1}(1,i);
    end
end
train_num1=size(waveforms1,1);

%%
cost=predict(t,waveforms1);

%%
error=0;
for i=1:train_num1
    if cost(i,1)~=labels1(i,1)
        error=error+1;
    end
end
rate=(train_num1-error)/train_num1;        
%%
L=resubLoss(t);

%%
hold on;
plot(waveforms1(cost==1,:)','b');
plot(waveforms1(cost==2,:)','r');
plot(waveforms1(cost==3,:)','g');
hold off;