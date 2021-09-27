#!/bin/bash
sshpass -p "1" ssh root@10.103.239.53 pkill -9 udm 2>&1 &
echo "UDM Stoped..."
sleep 2

sshpass -p "1" ssh root@10.103.239.53 pkill -9 udr 2>&1 &
echo "UDR Stoped..."
sleep 2

sshpass -p "1" ssh root@10.103.239.53 pkill -9 ausf 2>&1 &
echo "AUSF Stoped..."
sleep 2

sshpass -p "1" ssh root@10.103.239.53 pkill -9 smf 2>&1 &
echo "SMF Stoped..."
sleep 2

#sshpass -p "1" scp root@10.103.239.53:/home/xgcore/total_signaling_msg.txt /home/gnb-ue1/total_signaling_msg_7.txt
#sshpass -p "1" scp root@10.103.239.61:/home/xgcore/total_signaling_msg.txt /home/gnb-ue1/total_signaling_msg_8.txt
#sshpass -p "1" scp root@10.103.239.56:/home/xgcore/total_signaling_msg.txt /home/gnb-ue1/total_signaling_msg_1.txt
sshpass -p "1" scp root@10.103.239.116:/home/xgcore/total_signaling_msg.txt /home/gnb-ue1/total_signaling_msg_1.txt
sshpass -p "1" scp root@10.103.239.114:/home/xgcore/total_signaling_msg.txt /home/gnb-ue1/total_signaling_msg_2.txt
#sshpass -p "1" scp root@10.103.239.113:/home/xgcore/total_signaling_msg.txt /home/gnb-ue1/total_signaling_msg_4.txt
sshpass -p "1" scp root@10.103.239.112:/home/xgcore/total_signaling_msg.txt /home/gnb-ue1/total_signaling_msg_3.txt
sshpass -p "1" scp root@10.103.238.75:/home/xgcore/total_signaling_msg.txt /home/gnb-ue1/total_signaling_msg_4.txt
#sudo rm /home/gnb-ue1/successful_ues_time.txt

#sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen/amf.sh 2>&1 &
#sshpass -p "1" ssh root@10.103.239.53 "rm /home/xgcore/total_signaling_msg.txt ; pkill -9 amf" 2>&1 &
#echo "AMF1 Stoped..."
#sleep 2

#sshpass -p "1" ssh root@10.103.239.61 "pkill -9 amf  ; rm /home/xgcore/total_signaling_msg.txt" 2>&1 &
#echo "AMF2 Stoped..."
#sleep 2

#sshpass -p "1" ssh root@10.103.239.56 "rm /home/xgcore/total_signaling_msg.txt ; pkill -9 amf" 2>&1 &
#echo "AMF3 Stoped..."
#sleep 2

sshpass -p "1" ssh root@10.103.239.116 "pkill -9 amf  ;pkill -9 cpulimit; rm /home/xgcore/total_signaling_msg.txt" 2>&1 &
echo "AMF4 Stoped..."
sleep 2

sshpass -p "1" ssh root@10.103.239.114 "pkill -9 amf  ; pkill -9 cpulimit; rm /home/xgcore/total_signaling_msg.txt" 2>&1 &
echo "AMF5 Stoped..."
sleep 2

#sshpass -p "1" ssh root@10.103.239.113 "pkill -9 amf  ; rm /home/xgcore/total_signaling_msg.txt" 2>&1 &
#echo "AMF6 Stoped..."
#sleep 2

sshpass -p "1" ssh root@10.103.239.112 "pkill -9 amf;pkill -9 cpulimit; rm /home/xgcore/total_signaling_msg.txt" 2>&1 &
echo "AMF7 Stoped..."
sleep 2

sshpass -p "1" ssh root@10.103.238.75 "pkill -9 amf  ;pkill -9 cpulimit;  rm /home/xgcore/total_signaling_msg.txt" 2>&1 &
echo "AMF8 Stoped..."
sleep 2

#sshpass -p "1" ssh root@10.103.239.56 pkill -9 amf 2>&1 &
#echo "Stateful AMF Stoped..."
#sleep 2

sshpass -p "1" ssh root@10.103.239.53 pkill -9 udsf 2>&1 &
echo "UDSF Stoped..."
sleep 2

sshpass -p "1" ssh root@10.103.239.53 pkill -9 plugin 2>&1 &
echo "Plugin Stoped..."
sleep 2

sshpass -p "1" ssh root@10.103.239.55 pkill -9 spgwu 2>&1 &
echo "UPF (spgwu) Stoped..."
sleep 2

#sshpass -p "1" ssh root@192.168.83.131 pkill -9 smf 2>&1 &
#echo "sub_server Stoped..."
#sleep 2

HOSTNAME="10.103.239.54"
  
USERNAME="root"

PASSWORD="1234"

DATANAME="amfdata"

sshpass -p "1" ssh root@10.103.239.54 pkill -9 nrf  2>&1 &
delete_sql="truncate table gnb_context"
mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DATANAME} -e "${delete_sql}"
delete_sql="truncate table ue_ngap_context"
mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DATANAME} -e "${delete_sql}"
delete_sql="truncate table ue_context"
mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DATANAME} -e "${delete_sql}"
delete_sql="truncate table nas_context"
mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DATANAME} -e "${delete_sql}"
delete_sql="truncate table pdu_session_context"
mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DATANAME} -e "${delete_sql}"
#delete_sql="delete from gnb_context,nas_context,pdu_session_context,ue_context,ue_ngap_context"
#delete_sql="DROP TABLE gnb_context,nas_context,ue_context,ue_ngap_context"
#delete_sql="DROP TABLE gnb_context"
#mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DATANAME} -e "${delete_sql}"
#delete_sql="DROP TABLE nas_context"
#mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DATANAME} -e "${delete_sql}"
#delete_sql="DROP TABLE ue_context"
#mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DATANAME} -e "${delete_sql}"
#delete_sql="DROP TABLE pdu_session_context"
#mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DATANAME} -e "${delete_sql}"
#delete_sql="DROP TABLE ue_ngap_context"
#mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DATANAME} -e "${delete_sql}"
echo "NRF Stoped..."
sleep 2

#sshpass -p "1" ssh root@192.168.199.201 "cd /root/upf/witxg-upf/scripts  && ./run_upf.sh --close" 2>&1 &
#echo "UPF Stoped..."
#sleep 2
