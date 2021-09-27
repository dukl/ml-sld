clear
rate = [100,200,300,400,500,600]
usage = [1,40,80,120,160,200]
boxfigure = []
hasFile = [
              0,1,1,1,1,1;
              0,1,1,1,1,1;
              0,1,1,1,1,1;
              0,1,1,1,1,1;
              0,1,1,1,1,1;
              0,1,1,1,1,1;
              ]
index_src = 0
index_dst = 0
color = ['r','g','b','k','c','m']
shape = ['-o','-h','-d','-*','-s','-p']

for i=1:length(rate)
    boxfigure = []
    for j=2:length(usage)
        if j ==1
            continue
        end
        if hasFile(i,j) == 0
            continue
        end
        
        file = strcat('pct_',num2str(usage(j)),'_',num2str(rate(i)),'.xls')
        [step, stats, pct_time] = getPCT(file,rate(i));
        boxfigure(:,j-1) = pct_time;
        
        file = strcat('total_signaling_msg_',num2str(usage(j)),'_',num2str(rate(i)),'.txt')
        file_time = strcat('plugin_timestamp_',num2str(usage(j)),'_',num2str(rate(i)),'.txt')
        file_succ = strcat('successful_ues_time_',num2str(usage(j)),'_',num2str(rate(i)),'.txt')
        [time_succ, number_succ] = textread(file_succ, '%f %d');
        [a, plugin_time] = textread(file_time,'%s %f');
        [time,a,amf_n2,b,amf_n1,c,amf_n11,d,amf_app,name,cap]=textread(file,'%f %s %d %s %d %s %d %s %d %s %f');
        for m=1:length(time);
          if time(m) - plugin_time(1) >0 && time(m) - plugin_time(1) < 4000000;
             index_src = m;
          end
          if time(m) - plugin_time(length(plugin_time)) >0 && time(m) - plugin_time(length(plugin_time)) < 4000000;
             index_dst = m;
          end
        end
        x = find(cap<0);
        cap(x) = [];
        figure(6+i)
        %subplot(2,3,i)
        %plot((time(index_src:index_dst)-plugin_time(1))/1000000,cap(index_src:index_dst)/1000000,'color',color(j));
        xlabel('Running Timeline [s]')
        if i==1 || i==4
            ylabel('Real-time Capability [s/message]')
        end
        hold on
        figure(12)
        subplot(2,3,i)
        %plot(time(index_src:index_dst)-plugin_time(1),amf_n1(index_src:index_dst),shape(j),'MarkerIndices',1:10:(index_dst-index_src),'color',color(j));
        plot((time(index_src:index_dst)-plugin_time(1))/1000000,amf_n1(index_src:index_dst),'color',color(j));
        legend('40% CPU','80% CPU','120% CPU','160% CPU','200% CPU')
        xlabel('Running Timeline [s]')
        if i==1 || i==4
            ylabel('Queued Signaling Messages')
        end
        hold on
        
%         figure(4)
%         subplot(2,3,i)
%         for su=1:length(time_succ)
%             if time_succ(su) -  plugin_time(1)>0 && time_succ(su) - plugin_time(1) < 4000000
%             index_src = su;
%             end
%         end
%         plot(time_succ(index_src:length(time_succ))-plugin_time(1),number_succ(index_src:length(time_succ))/rate(i),'color',color(j))
%         hold on
    end
    RemoveSubplotWhiteArea(gca, 2, 3, floor(i/4)+1, mod(i-1,3)+1);
    figure(1)
    set(gcf, 'PaperPositionMode', 'auto')
    subplot(2,3,i)
    boxplot(boxfigure,'Labels',{'40','80','120','160','200'})
    xlabel('CPU Usage [%]')
    title_str = strcat(num2str(rate(i)),' UEs')
    title(title_str)
    axis([-inf,inf,0,2200])
    if i==1 || i==4
        ylabel('Average PCT [s]')
    end
    %RemoveSubplotWhiteArea(gca, 2, 3, floor(i/4)+1, mod(i-1,3)+1);
    
    
end

