# coding=utf-8
from Parse import Parse
from Base import resp_dir
from Base import resp_pack


class CreateResp(object):

	def __init__(self):
		pass

	def fileOne(self, tag):
		f = open(resp_dir + tag + ".py", "w")
		f.write("# coding=utf-8\n")
		f.close()

	def newFile(self):
		fi = open(resp_dir + "__init__.py", "w")
		fi.write("# coding=utf-8\n")
		fi.close()
		tags = Parse().getTags()
		for tag in tags:
			self.fileOne(tag)
			fi = open(resp_dir + "__init__.py", "a+")
			fi.write("from " + resp_pack + tag + " import *\n")
			fi.close()

	def respOne(self, path):
		p = Parse()
		p.setPath(path)
		tag = p.getTag()
		f = open(resp_dir + tag + ".py", 'a+')
		casename = p.getCaseName()
		resp = p.getResponse()

		f.write(casename + "_resp = ")
		if isinstance(resp, dict):
			self.writeDict(f, resp)
		elif isinstance(resp, list):
			self.writeList(f, resp)
		else:
			f.write("\'" + resp + "\'")
		f.write("\n\n")

	def writeDict(self, f, dict1):
		f.write("{")
		keys = dict1.keys()
		for i in range(len(keys)):
			key = keys[i]
			f.write("\n")
			f.write("\t\'" + key + "\': ")
			if isinstance(dict1[key], dict):
				self.writeDict(f, dict1[key])
			elif isinstance(dict1[key], list):
				self.writeList(f, dict1[key])
			elif dict1[key] == "string":
				f.write("\'" + dict1[key] + "\'")
			elif dict1[key] == "integer":
				f.write("0")
			elif dict1[key] == "boolean":
				f.write("True")
			else:
				pass
			if i < len(keys) - 1:
				f.write(",")

		f.write("}")

	def writeList(self, f, list1):
		f.write("[")
		for ele in list1:
			if isinstance(ele, dict):
				self.writeDict(f, ele)
			elif isinstance(ele, list):
				self.writeList(f, ele)
			elif ele == "string":
				f.write("\'" + ele + "\'")
			elif ele == "integer":
				f.write("0")
			elif ele == "boolean":
				f.write("True")
			else:
				pass
		f.write("]")

	def respAll(self):
		paths = Parse().getPaths()
		for path in paths:
			self.respOne(path)


if __name__ == '__main__':
	# CreateResp().newFile()
	# CreateResp().respAll()
	CreateResp().respOne("/pkArena/pkQuestions")
