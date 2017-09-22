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

j=0;
for i=1:size(spike_times1{1,1},2)
    if spike_class1{1,1}(1,i)==3
        j=j+1;
        waveforms1(j,:)=data1(1,spike_times1{1,1}(1,i):spike_times1{1,1}(1,i)+78);
        labelsA(j,1)=spike_class1{1,1}(1,i);
        spike_timesN1(1,j)=spike_times1{1,1}(1,i);
    end
end
spike_num1=size(waveforms1,1);

j=0;
for i=1:size(spike_times1{1,1},2)
    if spike_class1{1,1}(1,i)~=3
        j=j+1;
        waveforms2(j,:)=data1(1,spike_times1{1,1}(1,i):spike_times1{1,1}(1,i)+78);
        labelsB(j,1)=spike_class1{1,1}(1,i);
        spike_timesN2(1,j)=spike_times1{1,1}(1,i);
    end
end
spike_num2=size(waveforms2,1);

for i=1:size(spike_times1{1,1},2)
        waveforms(i,:)=data1(1,spike_times1{1,1}(1,i):spike_times1{1,1}(1,i)+78);
        labels(i,1)=spike_class1{1,1}(1,i);
end
spike_num=size(spike_times1{1,1},2);

%% 阈值检测1
[x1,y1]=findpeaks(data1,'minpeakheight',0.675);
y1=y1-22;
spike_num01=size(x1,2);
for i=1:spike_num01
    waveforms01(i,:)=data1(1,y1(1,i):y1(1,i)+78);
end

%% 阈值检测2
[x2,y2]=findpeaks(-data1,'minpeakheight',0.52);
y2=y2-22;
spike_num02=size(x2,2);
for i=1:spike_num02
    waveforms02(i,:)=data1(1,y2(1,i):y2(1,i)+78);
end

% 看类
plot(waveforms(labels==3,:)');
