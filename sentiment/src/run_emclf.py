#coding=utf-8
import sys
import time
import EmdictClassifier
import matplotlib.pyplot as plt
import numpy as np
import datetime 
import matplotlib.dates as mdates
counter=dict()
emclf=EmdictClassifier.EmdictClassifier()
emclf.loademdict('../tools/humanemotions')
h=3600
while True:
	line=sys.stdin.readline().strip()
	if not line:
		break
	line=line.split('\t')
	content=line[3]
	timestamp=line[1]
	label=emclf.decide(content)
	if not timestamp in counter.keys():
		counter[timestamp]=dict()
	if not label in counter[timestamp].keys():
		counter[timestamp][label]=0
	counter[timestamp][label]+=1
t0=int(min(counter.keys()))

labelnameset=set(emclf.emdict.values())
labelnameset.add(None)
emhist=dict()
daysum=dict()
for timestamp, labeldict in counter.iteritems():
	t=(int(timestamp)-t0)/h
	if not t in emhist.keys():
		emhist[t]=dict()
		daysum[t]=0
		for labelname in labelnameset:
			emhist[t][labelname]=0
	for label,cnt in labeldict.iteritems():
		emhist[t][label]+=cnt
		daysum[t]+=cnt
emhistevol=dict()
for t, cntdict in emhist.iteritems():
	for label,cnt in cntdict.iteritems():
		if not label in emhistevol.keys():
			emhistevol[label]=dict()
		emhistevol[label][t]=float(cnt)/daysum[t]


colors = list("rgbcmyk")
print time.gmtime(t0)
for data_dict in emhistevol.values():
	x = data_dict.keys()
	y = data_dict.values()
	plt.plot(x,y,color=colors.pop(),linewidth=1)
plt.legend(emhistevol.keys(),'best')

plt.show()
# prearray=np.empty((len(labelnameset),len(emhistevol.values())))
# k=0
# for item in emhistevol.values():
# 	prearray[k,:]=np.array(item.values())
# 	k+=1
# print prearray









