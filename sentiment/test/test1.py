#coding=utf-8
import sys
sys.path.append('../src')
import EmdictClassifier

counter=dict()
emclf=EmdictClassifier.EmdictClassifier()
emclf.loademdict('../tools/humanemotions')
while True:
	line=sys.stdin.readline().strip()
	if not line:
		break
	line=line.split('\t')
	content=line[3]
	label=emclf.decide(content)
	if not label in counter.keys():
		counter[label]=0
	else:
		counter[label]+=1
print counter

