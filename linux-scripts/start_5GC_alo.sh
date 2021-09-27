#!/bin/bash
sshpass -p "1" ssh root@10.103.239.54 /home/nrf/Haiwen_test/nrf/build/nrf/build/nrf -c /home/nrf/Haiwen_test/nrf/etc/nrf.conf -o > ./log/nrf.log  2>&1 &
echo "NRF Started..."
sleep 2

#sshpass -p "1" ssh root@192.168.83.131 "cd /home/witcommm/Haiwen/oai-cn5g-smf/src/minimal-ws-server && /home/witcommm/Haiwen/oai-cn5g-smf/build/smf/build/smf -c   /home/witcommm/Haiwen/oai-cn5g-smf/etc/smf2.conf -o " > ./log/sub_server.log  2>&1 &
#echo "sub_server Started..."
#sleep 2

sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen/gnb-sbi-plugin/src/plugin_app/build/plugin -c /home/xgcore/Haiwen/gnb-sbi-plugin/etc/plugin.conf -o > ./log/plugin.log  2>&1 &
echo "Plugin Started..."
sleep 5

sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen_test/openxg-udr/build/UDR/udr -c /home/xgcore/Haiwen_test/openxg-udr/etc/udr.conf -o > ./log/udr.log  2>&1 &
echo "UDR Started..."
sleep 2

sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen_test/udm/build/UDM/udm -c /home/xgcore/Haiwen_test/udm/etc/udm.conf -o > ./log/udm.log  2>&1 &
echo "UDM Started..."
sleep 2

sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen_test/openxg-ausf/build/AUSF/ausf -c /home/xgcore/Haiwen_test/openxg-ausf/etc/ausf.conf -o > ./log/ausf.log  2>&1 &
echo "AUSF Started..."
sleep 2

sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen/oai-cn5g-smf/build/smf/build/smf -c /home/xgcore/Haiwen/oai-cn5g-smf/etc/smf.conf -o > ./log/smf.log  2>&1 &
echo "SMF Started..."
sleep 2

#sshpass -p "1" ssh root@192.168.199.201 "cd /root/upf/witxg-upf/scripts && ./run_upf.sh -o ../etc/upf.yaml" > ./log/upf.log 2>&1 &
#echo "UPF Started..."
#sleep 15

sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen_test/openxg-udsf/udsf -c /home/xgcore/Haiwen_test/openxg-udsf/etc/udsf_docker.conf -o > ./log/udsf.log  2>&1 &
echo "UDSF Started.."
sleep 2

#sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen/amf/stateless/start_stateless_amf.sh > ./log/amf-1.log  2>&1 &
#echo "AMF1 Started..."
#sleep 2

#sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen/amf/build/amf/build/amf -c /home/xgcore/Haiwen/amf/etc/stateless-amf-2.conf -o > ./log/amf-1.log  2>&1 &
#echo "AMF1(239.53) Started..."
#sleep 2

#sshpass -p "1" ssh root@10.103.239.61 /home/xgcore/Haiwen/amf/build/amf/build/amf -c /home/xgcore/Haiwen/amf/etc/stateless-amf-2.conf -o > ./log/amf-2.log  2>&1 &
#echo "AMF2(239.61) Started..."
#sleep 2
#sshpass -p "1" ssh root@10.103.239.61 /home/xgcore/Haiwen/amf/build/amf/build/amf -c /home/xgcore/Haiwen/amf/etc/stateless-amf-1.conf -o > ./log/amf-9.log  2>&1 &
#echo "AMF9(239.63) Started..."
#sleep 2

#sshpass -p "1" ssh root@10.103.239.56 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-2.conf -o > ./log/amf-3.log  2>&1 &
#echo "AMF3(239.56) Started..."
#sleep 2
#sshpass -p "1" ssh root@10.103.239.56 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-1.conf -o > ./log/amf-10.log  2>&1 &
#echo "AMF10(238.105) Started..."
#sleep 2

sshpass -p "1" ssh root@10.103.239.116 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-2.conf -o > ./log/amf-4.log  2>&1 &
echo "AMF4(239.116) Started..."
sleep 2
#sshpass -p "1" ssh root@10.103.239.116 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-1.conf -o > ./log/amf-11.log  2>&1 &
#echo "AMF11(238.104) Started..."
#sleep 2

sshpass -p "1" ssh root@10.103.239.114 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-2.conf -o > ./log/amf-5.log  2>&1 &
echo "AMF5(239.114) Started..."
sleep 2
#sshpass -p "1" ssh root@10.103.239.114 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-1.conf -o > ./log/amf-12.log  2>&1 &
#echo "AMF12(238.103) Started..."
#sleep 2

#sshpass -p "1" ssh root@10.103.239.113 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-2.conf -o > ./log/amf-6.log  2>&1 &
#echo "AMF6(239.113) Started..."
#sleep 2
#sshpass -p "1" ssh root@10.103.239.113 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-1.conf -o > ./log/amf-13.log  2>&1 &
#echo "AMF13(238.98) Started..."
#sleep 2

sshpass -p "1" ssh root@10.103.239.112 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-2.conf -o > ./log/amf-7.log  2>&1 &
echo "AMF7(239.112) Started..."
sleep 2
#sshpass -p "1" ssh root@10.103.239.112 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-1.conf -o > ./log/amf-14.log  2>&1 &
#echo "AMF14(238.97) Started..."
#sleep 2

sshpass -p "1" ssh root@10.103.238.75 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-2.conf -o > ./log/amf-8.log  2>&1 &
echo "AMF8(238.72) Started..."
sleep 2
#sshpass -p "1" ssh root@10.103.238.72 /home/xgcore/stateless-amf/amf/build/amf/build/amf -c /home/xgcore/stateless-amf/amf/etc/stateless-amf-1.conf -o > ./log/amf-15.log  2>&1 &
#echo "AMF15(238.96) Started..."
#sleep 2

#sshpass -p "1" ssh root@10.103.239.53 /home/xgcore/Haiwen/gnb-sbi-plugin/src/plugin_app/build/plugin -c /home/xgcore/Haiwen/gnb-sbi-plugin/etc/plugin.conf -o > ./log/plugin.log  2>&1 &
#echo "Plugin Started..."
#sleep 5

sshpass -p "1" ssh root@10.103.239.55 /home/witcommm/Haiwen/openair-spgwu-tiny/build/spgw_u/build/spgwu -c /home/witcommm/Haiwen/openair-spgwu-tiny/etc/spgw_u.conf -o > ./log/upf.log  2>&1 &
echo "UPF (spgwu) Started..."
sleep 2

#sshpass -p "1" ssh root@10.103.239.56 /home/xgcore/5GC/amf/build/amf/build/amf -c /home/xgcore/5GC/amf/etc/amf.conf -o > ./log/amf-stateful.log  2>&1 &
#echo "Stateful AMF Started..."
#sleep 2
