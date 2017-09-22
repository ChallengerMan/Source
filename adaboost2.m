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
    if spike_class1{1,2}(1,i)==0
        j=j+1;
        waveforms1(j,:)=data1(1,spike_times1{1,1}(1,i):spike_times1{1,1}(1,i)+78);
        labelsA(j,1)=spike_class1{1,1}(1,i);
    end
end
spike_num1=size(waveforms1,1);

%% 加载数据2
load 'C_Difficult2_noise02.mat' spike_times spike_class data;
eval(['spike_times2'  '=spike_times;']);
eval(['spike_class2'  '=spike_class;']);
eval(['data2'  '=data;']);
clear spike_times spike_class data;
j=0;
for i=1:size(spike_times2{1,1},2)
    if spike_class2{1,2}(1,i)==0
        j=j+1;
        waveforms2(j,:)=data2(1,spike_times2{1,1}(1,i):spike_times2{1,1}(1,i)+78);
        labelsB(j,1)=spike_class2{1,1}(1,i);
    end
end
spike_num2=size(waveforms2,1);

%% adaboost
ens=fitensemble(waveforms1,labelsA,'AdaBoostM2',100,'tree','type','classification');
predict_label=predict(ens,waveforms2);

%% 准确率
error=0;
for i=1:spike_num2
    if predict_label(i,1)~=labelsB(i,1)
        error=error+1;
    end
end
rate=(spike_num2-error)/spike_num2;

%% 作图
hold on;
plot(waveforms2(predict_label==1,:)','b');
plot(waveforms2(predict_label==2,:)','r');
plot(waveforms2(predict_label==3,:)','g');
hold off;