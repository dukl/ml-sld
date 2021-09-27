clear
algs = ["RR","WRR","OMF"];
rate = [100,200,300,400,500,600];
color = ['r','g','b','c'];
shape = ["-o","-d","-h","-*"]
limit = [40,80,120,160]
cpu = [];
cpus = [];
index = 0;
for i=1:length(algs)
    cpu_j_k = [];
    for j=1:length(rate)
        for k=1:4
            cpu = [];
            file = strcat('amf_instance_cpu_',algs(i),'_',num2str(rate(j)),'_',num2str(k),'.txt');
            [a,b,c,d] = textread(file,'%s %f %s %f');
            for n=1:length(b)
                if mod(n,4)==0
                    cpu(end+1) = b(n);
                end
            end
            cpu_j_k(j,k) = mean(cpu)/limit(k);
            if j<6
                continue
            end
            figure(1)
            subplot(1,3,i)
            plot520 = plot(cpu/limit(k),shape(k),'MarkerIndices',1:40:length(cpu),'color',color(k))
            plot520.Color(4) = 0.8;
            axis([-inf,inf,0,1.2])
            title(algs(i))
            xlabel('Running Timeline [s]')
            if i==1
                ylabel('CPU Usage [%]')
            end
            hold on
        end
    end
    RemoveSubplotWhiteArea(gca, 1, 3, floor(i/4)+1, mod(i-1,3)+1);
    figure(4)
    subplot(1,3,i)
    bar(rate,cpu_j_k)
    if i==1
        ylabel('mean CPU usage')
    end
    %zlabel('mean CPU usage')
    xlabel('Number of Concurrent UEs')
    axis([-inf,inf,0,1])
    title(algs(i))
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = []; g1 = [];
x2 = []; g2 = [];
x3 = []; g3 = [];
x4 = []; g4 = [];
x5 = []; g5 = [];
x6 = []; g6 = [];
for i=1:length(algs)
    boxfigure = [];
    for j=1:length(rate)
        file = strcat('pct_',algs(i),'_',num2str(rate(j)),'.xls');
        [step, stats, pct_time] = getPCT(file,rate(i));
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
    figure(7)
    subplot(1,3,i)
    x = [x1;x2;x3;x4;x5;x6];
    g = [g1;g2;g3;g4;g5;g6];
    boxplot(x,g)
    axis([0,7,0,500])
    xlabel('Number of Concurrent UEs')
    if i==1
        ylabel('Average PCT [s]')
    end
    title(algs(i))
    RemoveSubplotWhiteArea(gca, 1, 3, floor(i/4)+1, mod(i-1,3)+1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index_src = 1;
index_dst = 1;
for i=1:length(rate)
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
                xlabel('Running Timeline [s]')
                ylabel('Queued Signaling Messages')
                axis([-inf,inf,0,250])
                hold on
            end
            for s=1:length(cap)
                if cap(s) <= 0
                    cap(s) = 0;
                else
                    cap(s) = 1000000/cap(s);
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

