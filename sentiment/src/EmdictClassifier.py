#coding=utf-8
import re
"""This class decides which class a given sentence belongs to based
on the emotion icon dictionary. If the input sentence contains an icon that 
is not in the dictionary, output None.
"""
class EmdictClassifier:
	iconpattern=re.compile(r'(\[.+?\])')
	sen=str()	
	emdict=dict()
	def loademdict(self,filename):
		self.emdict=dict()
		with open(filename) as f:
			for line in f:
				label,emlist=line.split('\t')
				emlist=emlist.split()
				for icon in emlist:
					self.emdict[icon]=label
	def decide(self,sen):
		iconmatch=self.iconpattern.search(sen)
		if iconmatch!=None:
			icon=iconmatch.group()
		else:
			icon=None
		if icon in self.emdict.keys():
			return self.emdict[icon]
		else:
			return None
