# coding=utf-8
from Parse import Parse
from Base import respAssert_dir


class CreateRespAssert(object):

	def __init__(self):
		pass

	def fileOne(self, tag):
		f = open(respAssert_dir + tag + ".robot", "w")
		connet = []
		connet.append("*** Settings ***\n")
		connet.append("Variables         ../../Datas/Response/" + tag + ".py\n")
		connet.append("\n\n")
		connet.append("*** Keywords ***\n")
		f.writelines(connet)
		f.close()

	def newFile(self):
		tags = Parse().getTags()
		for tag in tags:
			self.fileOne(tag)

	def respAssertOne(self, path):
		p = Parse()
		p.setPath(path)
		tag = p.getTag()
		f = open(respAssert_dir + tag + ".robot", 'a+')
		casename = p.getCaseName()
		resp = p.getResponse()

		f.write(casename + "_resp\n")
		f.writelines("\t${resp}    evaluate    ${" + casename + "_resp}\n")
		if isinstance(resp, dict):
			self.writeDict(f, resp,"resp")
		elif isinstance(resp, list):
			self.writeList(f, resp,"resp")
		else:
			f.write("\tShould Be Equal    ${resp}    ${sql}\n")
		f.write("\n\n")

	def writeDict(self, f, dict1,dir):
		keys = dict1.keys()
		for key in keys:
			dir_key = dir + "[\'" + key + "\']"
			if isinstance(dict1[key], dict):
				self.writeDict(f, dict1[key],dir_key)
			elif isinstance(dict1[key], list):
				self.writeList(f, dict1[key],dir_key)
			else:
				f.write("\tShould Be Equal    ${" + dir_key + "}    ${sql}\n")


	def writeList(self, f, list1,dir):
		for i in range(len(list1)):
			ele = list1[i]
			dir_i = dir + "[" + str(i) + "]"
			if isinstance(ele, dict):
				self.writeDict(f, ele,dir_i)
			elif isinstance(ele, list):
				self.writeList(f, ele,dir_i)
			else:
				f.write("\tShould Be Equal     ${" + dir_i + "}    ${sql}\n")

	def respAssertAll(self):
		paths = Parse().getPaths()
		for path in paths:
			self.respAssertOne(path)


if __name__ == '__main__':
	# CreateRespAssert().newFile()
	# CreateRespAssert().respAssertAll()
	CreateRespAssert().respAssertOne("/pkArena/pkQuestions")