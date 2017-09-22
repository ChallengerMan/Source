%% 清空环境变量
clc
clear
close all

%% 加载数据1
load 'C_Difficult2_noise02.mat' spike_times spike_class data;
eval(['spike_times1'  '=spike_times;']);
eval(['spike_class1'  '=spike_class;']);
eval(['data1'  '=data;']);
clear spike_times spike_class data;

%% 峰电位波形
for i=1:size(spike_times1{1,1},2)
        waveforms(i,:)=data1(1,spike_times1{1,1}(1,i):spike_times1{1,1}(1,i)+78);
        labels(i,1)=spike_class1{1,1}(1,i);
end
spike_num=size(spike_times1{1,1},2);


%% 非线性能量算子
NewData=data1.^2-circshift(data1,[0,1]).*circshift(data1,[0,-1]);
[x1,y1]=findpeaks(NewData,'minpeakheight',0.065);
y1=y1-22;
spike_num01=size(x1,2);
for i=1:spike_num01
    waveforms01(i,:)=data1(1,y1(1,i):y1(1,i)+78);
end
