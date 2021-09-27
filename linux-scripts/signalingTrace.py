#!/usr/bin/python3

import sys
import re

class LogInfo:
    def __init__(self, log_file, reshape_log, ue_num):
        self.log_file = log_file
        self.reshape = reshape_log
        self.ue_num = ue_num
        self.num = 0
        self.delay = 0
    def sigT(self):
        inFile = open(self.log_file, mode='r')
        outFile = open(self.reshape, mode='w')
        imsi = 460990000000001
        for i in range(self.ue_num):
            imsi_str = '%d'%(imsi+i)
            #print(imsi_tmp)
            start = 0
            end = 0
            startTrue = False
            endTrue = False
            while True:
                line = inFile.readline()
                if not line:
                    break
                else:
                    searchByImsi = re.search(r'\[.* (\d{2}):(\d{2}):(\d+\.\d+)\] \['+imsi_str+'.*\]\s\[.*\] .*', line, re.M|re.I)
                    searchByImsiSrc = re.search(r'\[.* (\d{2}):(\d{2}):(\d+\.\d+)\] \['+imsi_str+'.*\]\s\[.*\] Sending Initial Registration', line, re.M|re.I)
                    searchByImsiEnd = re.search(r'\[.* (\d{2}):(\d{2}):(\d+\.\d+)\] \['+imsi_str+'.*\]\s\[.*\] PDU Session establishment is successful PSI\[\d\]', line, re.M|re.I)
                    if searchByImsiSrc:
                        print (searchByImsiSrc.group())
                        start = int(searchByImsiSrc.group(1))*60*60+int(searchByImsiSrc.group(2))*60+float(searchByImsiSrc.group(3))
                        startTrue = True
                        #print (searchByImsi.group(4))
                        #outFile.write(line)
                    if searchByImsiEnd:
                        print (searchByImsiEnd.group())
                        end = int(searchByImsiEnd.group(1))*60*60+int(searchByImsiEnd.group(2))*60+float(searchByImsiEnd.group(3))
                        endTrue = True
                        #print (searchByImsi.group(4))
                        #outFile.write(line)
                    if searchByImsi:
                        outFile.write(line)
            inFile.seek(0,0)
            if startTrue and endTrue:
                self.delay += end - start
                print(imsi_str+' delay = ', end-start)
                self.num += 1
            else:
                outFile.write(imsi_str + " ---------- ERROR\n")
            outFile.write("\n")
        print('successful rate = ', self.num/self.ue_num)
        if self.num != 0:
            print('avaragy delay = ', self.delay/self.num)
        inFile.close()
        outFile.close()


#log = LogInfo(sys.argv[1],sys.argv[2], int(sys.argv[3]))
#print ('Log File: ',log.log_file)
#print ('Reshape Log file: ', log.reshape)
#if sys.argv[4]=='sigT':
#    print('Signaling Trace')
#    log.sigT()
#else:
#    print('Unknown command')


ueLog = open("ues_signaling.log", mode='r')
allId = []
while True:
    log_l = ueLog.readline()
    #isOK = False
    if not log_l:
        break
    searchByRanId = re.search(r'.*ran_ue_ngap_id = (\d+)',log_l,re.M|re.I)
    if not searchByRanId:
        continue
    else:
        allId.append(int(searchByRanId.group(1)))
    #for i in range(100):
        #print("int(searchByRanId.group(1))", int(searchByRanId.group(1)))
        #print("i = ", i)
        #if int(searchByRanId.group(1)) == (i+1):
        #    isOK = True
        #    break
    #if isOK:
    #    print("ran_ue_ngap_id " + searchByRanId.group(1))
ueLog.close()
isOK = False
num = 0
for i in range(100):
    for j in range(len(allId)):
        if (i+1) == allId[j]:
            #print("ran_ue_ngap_id ", i+1)
            isOK = True
            break
    if not isOK:
        print("Missing ran_ue_ngap_id ", i+1)
        num = num + 1
    isOK = False
print("Total missed UEs: ", num)
