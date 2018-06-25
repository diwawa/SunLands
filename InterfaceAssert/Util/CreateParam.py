# coding=utf-8
from Parse import Parse
from Base import paramsnew_dir


class CreateParam(object):
	def __init__(self):
		pass

	def fileOne(self, tag):
		f = open(paramsnew_dir + tag + ".py", "w")
		f.write("# coding=utf-8\n")
		f.close()

	def newFile(self):
		tags = Parse().getTags()
		for tag in tags:
			self.fileOne(tag)


	def paramOne(self, path):
		p = Parse()
		p.setPath(path)
		tag = p.getTag()
		f = open(paramsnew_dir + tag + ".py", 'a+')
		casename = p.getCaseName()
		params = p.getParams()
		if len(params) > 0:
			f.write(casename + "_param = ")
			for i in range(len(params)):
				name = params[i]["name"]
				if i == 0:
					param = name
				else:
					param = dict(param, **name)
			self.writeDict(f, param)
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
		f.write("]")

	def paramAll(self):
		paths = Parse().getPaths()
		for path in paths:
			self.paramOne(path)


if __name__ == '__main__':
	# CreateParam().newFile()
	# CreateParam().paramAll()
	CreateParam().paramOne("/trans/api/v1/order/prePay")
