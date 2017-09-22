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
    if spike_class1{1,2}(1,i)==1
        j=j+1;
        waveforms1(j,:)=data1(1,spike_times1{1,1}(1,i):spike_times1{1,1}(1,i)+78);
        labelsA(j,1)=spike_class1{1,1}(1,i);
    end
end
spike_num1=size(waveforms1,1);

%已给数据的峰电位波形提取
for i=1:size(spike_times1{1,1},2)
    if spike_class1{1,2}(1,i)==0
        waveforms(i,:)=data1(1,spike_times1{1,1}(1,i):spike_times1{1,1}(1,i)+78);
    end
end

%峰电位模板提取
template1=sum(waveforms(spike_class1{1,1}==1,:))/sum(spike_class1{1,1}==1);
template2=sum(waveforms(spike_class1{1,1}==2,:))/sum(spike_class1{1,1}==2);
template3=sum(waveforms(spike_class1{1,1}==3,:))/sum(spike_class1{1,1}==3);
template=[template1;template2;template3];

%分类重叠信号

A(1,1:46)=0;
A(1,47:79)=template1(1,1:33);
template11=template1+A;          
tempalte11=template11-mean(template11);    %第一类
template21=template2+A;
tempalte21=template21-mean(template21);    %第二类
template31=template3+A;
tempalte31=template31-mean(template31);    %第三类
A(1,47:79)=template2(1,1:33);
template12=template1+A;
tempalte12=template12-mean(template12);    %第一类
template22=template2+A;
tempalte22=template22-mean(template22);    %第二类
template32=template3+A;
tempalte32=template32-mean(template32);    %第三类
A(1,47:79)=template3(1,1:33);
template13=template1+A;
tempalte13=template13-mean(template13);    %第一类
template23=template2+A;
tempalte23=template23-mean(template23);    %第二类
template33=template3+A;
tempalte33=template33-mean(template33);    %第三类

%% 倒序归一化
GuiYi11=mapminmax(fliplr(template11)); 
filter11=conv(mapminmax(template11),GuiYi11);
GuiYi12=mapminmax(fliplr(template12));
filter12=conv(mapminmax(template12),GuiYi12);
GuiYi13=mapminmax(fliplr(template13));
filter13=conv(mapminmax(template13),GuiYi13);
GuiYi21=mapminmax(fliplr(template21));
filter21=conv(mapminmax(template21),GuiYi21);
GuiYi22=mapminmax(fliplr(template22));
filter22=conv(mapminmax(template22),GuiYi22);
GuiYi23=mapminmax(fliplr(template23));
filter23=conv(mapminmax(template23),GuiYi23);
GuiYi31=mapminmax(fliplr(template31));
filter31=conv(mapminmax(template31),GuiYi31);
GuiYi32=mapminmax(fliplr(template32));
filter32=conv(mapminmax(template32),GuiYi32);
GuiYi33=mapminmax(fliplr(template33));
filter33=conv(mapminmax(template33),GuiYi33);

%%
for i=1:spike_num1
Nwave=waveforms1(i,:)-mean(waveforms1(i,:));
Nfilter11=conv(Nwave,GuiYi11);
Nfilter12=conv(Nwave,GuiYi12);
Nfilter13=conv(Nwave,GuiYi13);
Nfilter21=conv(Nwave,GuiYi21);
Nfilter22=conv(Nwave,GuiYi22);
Nfilter23=conv(Nwave,GuiYi23);
Nfilter31=conv(Nwave,GuiYi31);
Nfilter32=conv(Nwave,GuiYi32);
Nfilter33=conv(Nwave,GuiYi33);
B(1,1)=max(Nfilter11);
B(1,2)=max(Nfilter21);
B(1,3)=max(Nfilter31);
B(2,1)=max(Nfilter12);
B(2,2)=max(Nfilter22);
B(2,3)=max(Nfilter32);
B(3,1)=max(Nfilter13);
B(3,2)=max(Nfilter23);
B(3,3)=max(Nfilter33);
C(1,1)=max(B(:,1));
C(1,2)=max(B(:,2));
C(1,3)=max(B(:,3));
[m(i,1),n(i,1)]=max(C);
end