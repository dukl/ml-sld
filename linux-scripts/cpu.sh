#!/bin/bash
source /etc/profile

#define variable
psUser="root"
psProcess="amf"
#pid= `ps -ef | egrep ${psProcess} | egrep ${psUser} |  egrep -v "grep|vi|tail" | sed -n 1p | awk '{print $2}'`
pid=(`ps -ef | grep "amf" | grep -v grep | awk '{print $2}'`)
echo ${pid[0]}
if [ -z ${pid[0]} ];then
	echo "The process does not exist."
	#exit 1
fi   
#CpuValue=`ps -p ${pid} -o pcpu |egrep -v CPU |awk '{print $1}'`
#echo ${CpuValue}
#flag=`echo ${CpuValue} | awk -v tem=80 '{print($1>tem)? "1":"0"}'`

interval=1  #设置采集间隔
is_stop=0

while [ $is_stop -eq 0 ]
do
    #echo $is_stop
    echo "time:		"$(date +"%y-%m-%d %H:%M:%S") >> /home/xgcore/proc_memlog.txt
    cat  /proc/${pid[0]}/status|grep -e VmRSS >> /home/xgcore/proc_memlog.txt    #获取内存占用
    cpu=`ps -p ${pid[0]} -o pcpu |egrep -v CPU | awk '{print $1}' `    #获取cpu占用
    #cpu=`top -n 1 -p $pid|tail -2|head -1|awk '{ssd=NF-4} {print $ssd}'`    #获取cpu占用
    echo "Cpu: 		" $cpu >> /home/xgcore/proc_memlog.txt
    echo $blank >> /home/xgcore/proc_memlog.txt
    sleep $interval
    res=$(ps aux | awk '{print $2}'| grep -w ${pid[0]})
    #echo "res=$res"
    if [ ! $res ];then
	    is_stop=1
	    echo "${pid[0]} has been killed."
    fi
done 

