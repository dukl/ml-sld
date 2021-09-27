%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
algs = ["RR","WRR","OMF"];
rate = [100,200,300,400,500,600];
color = ['r','g','b','c','k','m'];
shape = ["-o","-d","-h","-*","-s","-x"]
for i=6:length(rate)
    for j=1:length(algs)
        file_succ = strcat('successful_ues_time_',algs(j),'_',num2str(rate(i)),'.txt')
        file_time = strcat('plugin_timestamp_',algs(j),'_',num2str(rate(i)),'.txt');
        %[a, plugin_time] = textread(file_time,'%s %f');
        [time,succ_num]=textread(file_succ,'%f %d');
        timeline = [1:5:(time(length(time))-time(1))/1000000];
        figure_succ = []
        for m=1:length(timeline)
            for n=1:length(time)-1
                if (timeline(m)+time(1)/1000000)>time(n)/1000000 && (timeline(m)+time(1)/1000000)<time(n+1)/1000000
                    figure_succ(m) = succ_num(n);
                    break;
                end
            end
        end
        figure(4)
        subplot(1,3,3)
        %step = floor(length(timeline)/2)
        plot(timeline,figure_succ/rate(i),shape(j),'MarkerIndices',1:2:length(timeline),'color',color(j))
        xlabel('Running Timeline [s]')
        ylabel('ECDF')
        hold on
    end
end
RemoveSubplotWhiteArea(gca, 1, 3, 1, 3);
