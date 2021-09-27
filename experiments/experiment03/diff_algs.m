clear
algs = ["RR","WRR","OMF"];
rate = [100,200,300,400,500,600];
color = ['r','g','b','c'];
shape = ["-o","-d","-h","-*"]
cpu = [];
cpus = [];
index = 0;
cpu_i_k = [];
for i=1:length(algs)
    for j=6:length(rate)
        for k=1:4
            cpu = [];
            file = strcat('amf_instance_cpu_',algs(i),'_',num2str(rate(j)),'_',num2str(k),'.txt');
            [a,b,c,d] = textread(file,'%s %f %s %f');
            for n=1:length(b)
                if mod(n,4)==0
                    cpu(end+1) = b(n);
                end
            end
            cpu_i_k(i,k) = mean(cpu);
            if j<6
                continue
            end
            figure(1)
            subplot(1,3,i)
            plot520 = plot(cpu,shape(k),'MarkerIndices',1:40:length(cpu),'color',color(k))
            plot520.Color(4) = 0.8;
            xlabel('Running Timeline [s]')
            if i==1
                ylabel('CPU Usage [%]')
            end
            title(algs(i))
            axis([-inf,inf,0,110])
            hold on
        end
    end
    RemoveSubplotWhiteArea(gca, 1, 3, floor(i/4)+1, mod(i-1,3)+1);
end
    figure(4)
    subplot(1,3,1)
    bar(rate(1:3),cpu_i_k)
    ylabel('mean CPU usage')
    %zlabel('mean CPU usage')
    xlabel('Load Balancing Algorithms')
    axis([-inf,inf,0,100])
    set(gca,'xticklabel',{'RR','WRR','OMF'});
    RemoveSubplotWhiteArea(gca, 1, 3, 1, 1);
    legend('AMF-Instance-ID-1','AMF-Instance-ID-2','AMF-Instance-ID-3','AMF-Instance-ID-4')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = []; g1 = [];
x2 = []; g2 = [];
x3 = []; g3 = [];
x4 = []; g4 = [];
x5 = []; g5 = [];
x6 = []; g6 = [];
boxfigure = [];
for i=1:length(algs)
    for j=6:length(rate)
        file = strcat('pct_',algs(i),'_',num2str(rate(j)),'.xls');
        [step, stats, pct_time] = getPCT(file,rate(i));
        boxfigure(:,i) = pct_time;
        if j==1
            x1 = pct_time;
            g1 = repmat({'100'},rate(j),1);
        end
        if j==2
            x2 = pct_time;
            g2 = repmat({'200'},rate(j),1);
        end
        if j==3
            x3 = pct_time;
            g3 = repmat({'300'},rate(j),1);
        end
        if j==4
            x4 = pct_time;
            g4 = repmat({'400'},rate(j),1);
        end
        if j==5
            x5 = pct_time;
            g5 = repmat({'500'},rate(j),1);
        end
        if j==6
            x6 = pct_time;
            g6 = repmat({'600'},rate(j),1);
        end
    end
end
    figure(4)
    subplot(1,3,2)
    x = [x1;x2;x3;x4;x5;x6];
    g = [g1;g2;g3;g4;g5;g6];
    boxplot(boxfigure,'Labels',{'RR','WRR','OMF'})
    %axis([0,7,0,500])
    xlabel('Number of Synchronous UEs')
    ylabel('Average PCT [s]')
    RemoveSubplotWhiteArea(gca, 1, 3, 1, 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index_src = 1;
index_dst = 1;
for i=6:length(rate)
    for j=1:length(algs)
        file_time = strcat('plugin_timestamp_',algs(j),'_',num2str(rate(i)),'.txt');
        [a, plugin_time] = textread(file_time,'%s %f');
        for k=1:4
            file = strcat('total_signaling_msg_',algs(j),'_',num2str(rate(i)),'_',num2str(k),'.txt');
            [time,a,amf_n2,b,amf_n1,c,amf_n11,d,amf_app,name,cap]=textread(file,'%f %s %d %s %d %s %d %s %d %s %f');
            for m=1:length(time);
                if time(m) - plugin_time(1) >0 && time(m) - plugin_time(1) < 4000000;
                    index_src = m;
                end
                if time(m) - plugin_time(length(plugin_time)) >0 && time(m) - plugin_time(length(plugin_time)) < 8000000;
                    index_dst = m;
                end
            end
            if i==6
                figure(9+j)
                plot((time(index_src:index_dst)-plugin_time(1))/1000000,amf_n1(index_src:index_dst),'color',color(k));
                %axis([-inf,inf,0,250])
                xlabel('Running Timeline [s]')
                ylabel('Queued Signaling Messages')
                hold on
            end
            for s=1:length(cap)
                if cap(s) <= 0
                    cap(s) = 0;
                end
            end
            if i==6
                figure(13+j)
                plot(time(index_src:index_dst)-plugin_time(1),cap(index_src:index_dst),'color',color(k));
                axis([-inf,inf,0,25])
                hold on
            end
        end
    end
end


