#!/bin/bash

RR=(100 200 300 400 500 600)
cpu=(1 40 80 120 160 200)
isOK=('0 1 1 1 1 1'  '0 1 1 1 1 0'  '0 1 1 1 1 1' '0 1 1 1 1 1' '0 1 1 1 1 1 ' '0 1 1 1 1 1')


for (( a = 1; a < 2; a++ ))
do
	isOK_1=(${isOK[$a]})
	echo "is_OK_1"
        for (( b = 1; b < 6; b++ ))
        do
	       if [ ${isOK_1[$b]} -eq 1 ]; then
		       echo "file available"
		       continue
	       else
		       echo "file not available"
	       fi
	       sub_bits_1=1414
	       sub_bits_2=1
               echo "RR: ${RR[$a]}"
               echo "CPU: ${cpu[$b]}"
	       sshpass -p "1" ssh root@10.103.239.116 "cpulimit -e /home/xgcore/stateless-amf/amf/build/amf/build/amf -l ${cpu[$b]}" 2>&1 &
	       /home/gnb-ue1/scripts/start_5GC_alo.sh
	       sleep 10
	       is_run=`sshpass -p "1" ssh root@10.103.239.53 "ps -aux |grep plugin|grep -v grep" 2>&1 &`
	       if [ -z "${is_run}" ]; then
		       echo "plugin has not started"
		       sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen/gnb-sbi-plugin/src/plugin_app/build/plugin -c /home/xgcore/Haiwen/gnb-sbi-plugin/etc/plugin.conf -o > ./log/plugin.log  2>&1 &
	               sleep 5
	       else
		       echo "plugin has started"
	       fi
	       #ps -fe|grep plugin |grep -v grep
	       #if [ $? -ne 0 ]
	       #then
	       #	       echo "started plugin....."
	       #else
	       #	       echo "re-run plugin"
	       #        sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen/gnb-sbi-plugin/src/plugin_app/build/plugin -c /home/xgcore/Haiwen/gnb-sbi-plugin/etc/plugin.conf -o > /home/gnb-ue1/scripts/log/plugin.log  2>&1
	       #fi
	       #sleep 10
	       echo "123"|sudo -S /home/gnb-ue1/UERANSIM/build/nr-gnb -c /home/gnb-ue1/UERANSIM/config/open5gs-gnb-stateless.yaml &
	       sleep 5
	       echo "123"|sudo -S /home/gnb-ue1/UERANSIM/build/nr-ue -c /home/gnb-ue1/UERANSIM/config/open5gs-ue.yaml -n ${RR[$a]} |tee /home/gnb-ue1/UERANSIM/build/ue.log &
	       until [ $sub_bits_1 -eq $sub_bits_2 ]
	       do
	           sub_bits_2=$sub_bits_1
	       	   bits=`wc -c /home/gnb-ue1/UERANSIM/build/ue.log`
                   sub_bits_1=`echo ${bits% *}`
	           echo "1:$sub_bits_1"
                   echo "2:$sub_bits_2"
		   if [ ${cpu[$b]} -eq 1 ]; then
                     sleep 90
	           else
		     sleep 90
	           fi
               done
               echo "ue.log is no bigger"
               echo "123"|sudo -S pkill -9 nr-gnb
               echo "123"|sudo -S pkill -9 nr-ue  
	       sshpass -p "1" ssh root@10.103.239.116 "pkill -9 cpulimit" 2>&1
	       /home/gnb-ue1/scripts/stop_5GC_alo.sh
	       file_name="total_signaling_msg_${cpu[$b]}_${RR[$a]}.txt"
	       cp /home/gnb-ue1/total_signaling_msg_1.txt /home/gnb-ue1/scripts/experiments/$file_name
	       echo "123"|sudo -S /home/gnb-ue1/signalingTrace.py /home/gnb-ue1/UERANSIM/build/ue.log /home/gnb-ue1/UERANSIM/build/by-imsi.log ${RR[$a]} ${cpu[$b]} sigT 
	       file_name="pct_${cpu[$b]}_${RR[$a]}.xls"
	       cp /home/gnb-ue1/scripts/$file_name /home/gnb-ue1/scripts/experiments/$file_name
	       file_name="successful_ues_time_${cpu[$b]}_${RR[$a]}.txt"
	       echo "123"|sudo -S cp /home/gnb-ue1/successful_ues_time.txt /home/gnb-ue1/scripts/experiments/$file_name
	       echo "123"|sudo -S rm /home/gnb-ue1/successful_ues_time.txt
	       file_name="plugin_timestamp_${cpu[$b]}_${RR[$a]}.txt"
	       sshpass -p "1" scp root@10.103.239.53:/home/xgcore/plugin_timestamp.txt /home/gnb-ue1/scripts/experiments/$file_name 
	       sshpass -p "1" ssh root@10.103.239.53 "rm /home/xgcore/plugin_timestamp.txt" 2>&1
	       sleep 60
        done
done

	#/home/gnb-ue1/scripts/start_5GC_alo.sh
	#sshpass -p "1" ssh root@10.103.239.116 "cpulimit -e /home/xgcore/stateless-amf/amf/build/amf/build/amf -l $cpu" 2>&1 &
	
