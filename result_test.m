%% 阈值检测1
false1=0;
for i=1:spike_num
    if isempty(find(abs(y1-spike_times1{1,1}(1,i))<=5,1))
        false1=false1+1;
    end
end
% rate1=(spike_num-false1)/spike_num;

%% 阈值检测2
false2=0;
% for i=1:spike_num2
%     if isempty(find(abs(y2-spike_timesN2(1,i))<=2,1))
%         false2=false2+1;
%     end
% end

%% 准确率
rate=(spike_num-false1-false2)/spike_num;