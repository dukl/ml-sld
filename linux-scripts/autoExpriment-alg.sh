#!/bin/bash

RR=(100 200 300 400 500 600)
#cpu=(1 20 50 80 110 200)
cpu=(1 40 80 120 160 200)
isOK=('0 1 1 1 1 1'  '0 0 0 0 0 1'  '0 1 1 1 1 1' '0 1 1 1 1 1' '0 1 1 1 1 1 ' '0 1 1 1 1 1')
alg=("RR" "OMF" "WRR")
isAlg=('0 0 0' '0 0 0' '0 0 0' '0 0 0' '0 0 0' '0 0 0')

for (( a = 2; a < 6; a++ ))
do
	isAlg_1=(${isAlg[$a]})
	echo "is_OK_1"
        for (( b = 2; b < 3; b++ ))
        do
	       if [ ${isAlg_1[$b]} -eq 1 ]; then
		       echo "file available"
		       continue
	       else
		       echo "file not available"
	       fi
	       sub_bits_1=1414
	       sub_bits_2=1
               echo "RR: ${RR[$a]}"
               #echo "CPU: ${cpu[$b]}"
               echo "ALG: ${alg[$b]}"
	       sshpass -p "1" ssh root@10.103.239.53 "sed -i \"s+@ALG@+\"${alg[$b]}\"+g\" /home/xgcore/Haiwen/gnb-sbi-plugin/etc/plugin.conf" 2>&1 &
	       /home/gnb-ue1/scripts/start_5GC_alo.sh
	       sleep 5
	       sshpass -p "1" ssh root@10.103.239.116 "cpulimit -e /home/xgcore/stateless-amf/amf/build/amf/build/amf -l ${cpu[0]}" 2>&1 & 
	       sshpass -p "1" ssh root@10.103.239.114 "cpulimit -e /home/xgcore/stateless-amf/amf/build/amf/build/amf -l ${cpu[1]}" 2>&1 &
	       sshpass -p "1" ssh root@10.103.239.112 "cpulimit -e /home/xgcore/stateless-amf/amf/build/amf/build/amf -l ${cpu[2]}" 2>&1 &
	       sshpass -p "1" ssh root@10.103.238.75  "cpulimit -e /home/xgcore/stateless-amf/amf/build/amf/build/amf -l ${cpu[3]}" 2>&1 &
	       sshpass -p "1" ssh root@10.103.239.116 "rm /home/xgcore/proc_memlog.txt; /home/xgcore/cpu.sh" 2>&1 &
	       sshpass -p "1" ssh root@10.103.239.114 "rm /home/xgcore/proc_memlog.txt; /home/xgcore/cpu.sh" 2>&1 &
	       sshpass -p "1" ssh root@10.103.239.112 "rm /home/xgcore/proc_memlog.txt; /home/xgcore/cpu.sh" 2>&1 &
	       sshpass -p "1" ssh root@10.103.238.75  "rm /home/xgcore/proc_memlog.txt; /home/xgcore/cpu.sh" 2>&1 &
	       sleep 5
	       #is_run=`sshpass -p "1" ssh root@10.103.239.53 "ps -aux |grep plugin|grep -v grep" 2>&1 `
	       #if [ -z "${is_run}" ]; then
	       #	       echo "plugin has stoped"
	       #	       sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen/gnb-sbi-plugin/src/plugin_app/build/plugin -c /home/xgcore/Haiwen/gnb-sbi-plugin/etc/plugin.conf -o > ./log/plugin.log  2>&1 &
	       #        sleep 5
	       #else
	#	       echo "plugin has started"
	 #      fi
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
	       sleep 10
	       echo "123"|sudo -S /home/gnb-ue1/UERANSIM/build/nr-ue -c /home/gnb-ue1/UERANSIM/config/open5gs-ue.yaml -n ${RR[$a]} |tee /home/gnb-ue1/UERANSIM/build/ue.log &
	       until [ $sub_bits_1 -eq $sub_bits_2 ]
	       do
	           sub_bits_2=$sub_bits_1
	       	   bits=`wc -c /home/gnb-ue1/UERANSIM/build/ue.log`
                   sub_bits_1=`echo ${bits% *}`
	           echo "1:$sub_bits_1"
                   echo "2:$sub_bits_2"
		   if [ $a -eq 5 ]; then
		     echo "sleep 90 second"
                     sleep 90
	           else
		     echo "sleep 30 second"
		     sleep 30
	           fi
               done
               echo "ue.log is no bigger"
               echo "123"|sudo -S pkill -9 nr-gnb
               echo "123"|sudo -S pkill -9 nr-ue  
	       sshpass -p "1" ssh root@10.103.239.116 "pkill -9 cpulimit" 2>&1
	       sshpass -p "1" ssh root@10.103.239.114 "pkill -9 cpulimit" 2>&1
	       sshpass -p "1" ssh root@10.103.239.112 "pkill -9 cpulimit" 2>&1
	       sshpass -p "1" ssh root@10.103.238.75 "pkill -9 cpulimit" 2>&1
	       /home/gnb-ue1/scripts/stop_5GC_alo.sh
	       sleep 10
	       sshpass -p "1" ssh root@10.103.239.53 "sed -i \"s/${alg[$b]}/@ALG@/g\" /home/xgcore/Haiwen/gnb-sbi-plugin/etc/plugin.conf" 2>&1 &
	       file_name="total_signaling_msg_${alg[$b]}_${RR[$a]}"
	       cp /home/gnb-ue1/total_signaling_msg_1.txt /home/gnb-ue1/scripts/experiments_2/"${file_name}_1.txt"
	       cp /home/gnb-ue1/total_signaling_msg_2.txt /home/gnb-ue1/scripts/experiments_2/"${file_name}_2.txt"
	       cp /home/gnb-ue1/total_signaling_msg_3.txt /home/gnb-ue1/scripts/experiments_2/"${file_name}_3.txt"
	       cp /home/gnb-ue1/total_signaling_msg_4.txt /home/gnb-ue1/scripts/experiments_2/"${file_name}_4.txt"
	       echo "123"|sudo -S /home/gnb-ue1/signalingTrace.py /home/gnb-ue1/UERANSIM/build/ue.log /home/gnb-ue1/UERANSIM/build/by-imsi.log ${RR[$a]} ${alg[$b]} sigT 
	       file_name="pct_${alg[$b]}_${RR[$a]}.xls"
	       cp /home/gnb-ue1/scripts/$file_name /home/gnb-ue1/scripts/experiments_2/$file_name
	       file_name="successful_ues_time_${alg[$b]}_${RR[$a]}.txt"
	       echo "123"|sudo -S cp /home/gnb-ue1/successful_ues_time.txt /home/gnb-ue1/scripts/experiments_2/$file_name
	       echo "123"|sudo -S rm /home/gnb-ue1/successful_ues_time.txt
	       file_name="plugin_timestamp_${alg[$b]}_${RR[$a]}.txt"
	       sshpass -p "1" scp root@10.103.239.53:/home/xgcore/plugin_timestamp.txt /home/gnb-ue1/scripts/experiments_2/$file_name 
	       sshpass -p "1" ssh root@10.103.239.53 "rm /home/xgcore/plugin_timestamp.txt" 2>&1
	       file_name="amf_instance_cpu_${alg[$b]}_${RR[$a]}"
	       sshpass -p "1" scp root@10.103.239.116:/home/xgcore/proc_memlog.txt /home/gnb-ue1/scripts/experiments_2/"${file_name}_1.txt"
	       sshpass -p "1" scp root@10.103.239.114:/home/xgcore/proc_memlog.txt /home/gnb-ue1/scripts/experiments_2/"${file_name}_2.txt"
	       sshpass -p "1" scp root@10.103.239.112:/home/xgcore/proc_memlog.txt /home/gnb-ue1/scripts/experiments_2/"${file_name}_3.txt"
	       sshpass -p "1" scp root@10.103.238.75:/home/xgcore/proc_memlog.txt /home/gnb-ue1/scripts/experiments_2/"${file_name}_4.txt"
	       sleep 120
        done
done

	#/home/gnb-ue1/scripts/start_5GC_alo.sh
	#sshpass -p "1" ssh root@10.103.239.116 "cpulimit -e /home/xgcore/stateless-amf/amf/build/amf/build/amf -l $cpu" 2>&1 &
	
