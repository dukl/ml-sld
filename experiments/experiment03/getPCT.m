function [vector_, stats_, pct_time] = getPCT(input_, num_)
format long
input = xlsread(input_);
sort_input = sortrows(input,4);
start_time = sort_input(:,4);
end_time   = sort_input(:,5);
pct_time   = end_time - start_time;
step       = (max(pct_time)-min(pct_time))/size(pct_time,1);
step_vec   = [min(pct_time):step:max(pct_time)];
stats = []
index = 1;
for i = step_vec;
    num = 0;
    for j = 1:size(end_time,1);
        if (end_time(j)-start_time(j)) < i;
            num = num + 1;
        end
    end
    stats(index) = num/num_;
    index = index + 1;
end
index
%figure(1)
%plot(step_vec,stats,'-o','MarkerIndices',1:20:length(step_vec),'color','r')
%axis([140, 310,0,1])
vector_ = step_vec;
stats_  = stats;

end

