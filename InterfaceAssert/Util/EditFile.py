#coding=utf-8
from Parse import Parse
from Base import *


class EditFile(object):
	def __init__(self):
		pass

	def insertFileText(self, filename, n, text):
		u'''
		在文档中的第n行开始插入文本
		:param filename: 路径
		:param n: 从0开始
		:param text: list
		:return:
		'''
		fp = open(filename, 'r')
		lines = fp.readlines()
		fp.close()
		text = list(text)
		n = int(n)
		for i in range(len(text)):
			line = n + i
			lines.insert(line, text[i])
		fp = open(filename, 'w')
		fp.writelines(lines)
		fp.close()

	def getLine(self, filename, text):
		fp = open(filename, 'r')
		lines = fp.readlines()
		n = -1
		for i in range(len(lines)):
			if text in lines[i]:
				n = i
		fp.close()
		return n

	def editText(self,filename,n,text):
		u'''
		修改某一行文字
		:param filename:
		:param n:  从0开始算
		:param text:  list
		:return:
		'''
		if n<0:
			pass
		else:
			fp = open(filename, 'r')
			lines = fp.readlines()
			fp.close()
			text = list(text)
			lines[n] = text[0]
			n = int(n)
			for i in range(1,len(text)):
				line = n + i
				lines.insert(line, text[i])
			fp = open(filename, 'w')
			fp.writelines(lines)
			fp.close()


if __name__ == '__main__':
	tags = Parse().getTags()
	for tag in tags:
		filename = cases_dir+tag+".robot"
		text = ["Library           ../../Common/Function.py\n"]
		line = EditFile().getLine(filename,"Library           ../../Util/Function.py")
		EditFile().editText(filename,line,text)
		# EditFile().insertFileText(filename, line+1, text)
