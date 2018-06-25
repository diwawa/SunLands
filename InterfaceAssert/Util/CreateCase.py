# coding=utf-8
from Parse import Parse
from Base import casesnew_dir
from Datas.Response import *


class CreateCase(object):

	def __init__(self):
		pass

	def fileOne(self, tag):
		f = open(casesnew_dir + tag + ".robot", "w")
		setting_fun = []
		setting_fun.append("*** Settings ***\n")
		# setting_fun.append("Suite Setup       SuiteSetup\n")
		# setting_fun.append("Suite Teardown    SuiteTeardown\n")
		# setting_fun.append("Test Teardown     TestTeardown\n")
		setting_fun.append("Force Tags        文档测试\n")
		setting_fun.append("Library           ../../Common/Function.py\n")
		setting_fun.append("Resource          ../../API/" + tag + ".robot\n")
		setting_fun.append("Variables         ../../Base.py\n")
		setting_fun.append("Variables         ../../Datas/Params/" + tag + ".py\n")
		setting_fun.append("Variables         ../../Datas/Response/" + tag + ".py\n")
		setting_fun.append("\n\n")
		setting_fun.append("*** Test Cases ***\n")
		f.writelines(setting_fun)
		f.close()

	def newFile(self):
		tags = Parse().getTags()
		for tag in tags:
			self.fileOne(tag)

	def caseOne(self, path):
		p = Parse()
		p.setPath(path)
		tag = p.getTag()
		f = open(casesnew_dir + tag + ".robot", 'a+')
		apiname = p.getAPIName()
		casename = p.getCaseName()
		f.write(casename + "\n")
		# 获取接口返回值
		parameters = p.getParams()
		paramskey = []
		summary = p.getSummary()
		f.write("\t[Documentation]    " + summary.encode("utf-8") + "\n")
		f.write("\t[Tags]    Run\n")
		f.write("\t${resp}    " + apiname + "    ${token}")
		if len(parameters) > 0:
			for i in range(len(parameters)):
				name = parameters[i]["name"].keys()[0]
				paramskey.append(name)
				f.write("    ${" + casename + "_param[\'" + name + "\']}")
		f.write("\n")
		resp = globals()[casename + "_resp"]
		if isinstance(resp, dict) or isinstance(resp, list):
			self.assertDict(f, casename, resp, "")
			f.write("\n")
		else:
			f.write("\tshould be equal as strings    ${resp}    ${" + casename + "_resp}\n\n")

	def assertDict(self, f, casename, dict1, keyname):
		content = []
		content.append(
			"\t${result}    compareResp    ${" + casename + "_resp" + keyname + "}    ${resp" + keyname + "}\n")
		content.append("\tShould Be True    ${result['status']}    ${result}\n")
		f.writelines(content)

		if isinstance(dict1, dict):
			keys = dict1.keys()
			for key in keys:
				if isinstance(dict1[key], dict):
					name = keyname + "[\'" + key + "\']"
					self.assertDict(f, casename, dict1[key], name)
				elif isinstance(dict1[key], list):
					name = keyname + "[\'" + key + "\']"
					self.assertList(f, casename, dict1[key], name)
				else:
					pass
		else:
			self.assertList(f, casename, dict1, keyname)

	def assertList(self, f, casename, list1, keyname):
		for i in range(len(list1)):
			ele = list1[i]
			if isinstance(ele, dict):
				name = keyname + "[" + str(i) + "]"
				self.assertDict(f, casename, ele, name)
			elif isinstance(ele, list):
				name = keyname + "[" + str(i) + "]"
				self.assertList(f, casename, ele, name)

	def caseAll(self):
		paths = Parse().getPaths()
		for path in paths:
			self.caseOne(path)


if __name__ == '__main__':
	# CreateCase().newFile()
	# CreateCase().caseAll()
	CreateCase().caseOne("/subjects")
