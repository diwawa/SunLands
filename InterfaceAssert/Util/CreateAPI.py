# coding=utf-8
from Parse import Parse
from Base import url
from Base import api_dir


class CreateAPI(object):

	def __init__(self):
		pass

	def fileOne(self ,tag):
		f = open(api_dir + tag + ".robot", "w")
		setting_api = []
		setting_api.append("*** Settings ***\n")
		setting_api.append("Library          RequestsLibrary\n")
		setting_api.append("Library          Collections\n")
		setting_api.append("\n\n")
		setting_api.append("*** Keywords ***\n")
		f.writelines(setting_api)
		f.close()

	def newFile(self):
		tags = Parse().getTags()
		for tag in tags:
			self.fileOne(tag)

	def apiOne(self, path):
		p = Parse()
		p.setPath(path)
		tag = p.getTag()
		f = open(api_dir + tag + ".robot", 'a+')
		apiname = p.getAPIName()
		f.write(apiname + "\n")
		# 写参数
		parameters = p.getParams()
		paramskey = []
		paramsmethod = []
		f.write("\t[Arguments]    ${token}")
		if len(parameters) > 0:
			for i in range(len(parameters)):
				name = parameters[i]["name"].keys()[0]
				paramskey.append(name)
				f.write("    ${" + name + "}")
				method = parameters[i]["method"]
				paramsmethod.append(method)
		f.write("\n")
		# 写说明
		summary = p.getSummary()
		f.write("\t[Documentation]    " + summary.encode("utf-8") + "\n")
		# 写内容
		mode = p.getMode()
		content = []
		content.append("\tCreate Session    exam    " + url + "\n")
		# 头文件
		headers = "\t${headers}    Create Dictionary    Authorization    ${token}"
		if mode == "post":
			headers = headers + "    Content-Type    application/json\n"
		else:
			headers = headers + "\n"
		content.append(headers)
		# 请求参数
		if len(paramskey) > 0:
			query = 0
			body = 0
			path0 = 0
			params_path = []
			params = "\t${params}    Create Dictionary    "
			for i in range(len(paramskey)):
				if paramsmethod[i] == "query":
					params = params + paramskey[i] + "    ${" + paramskey[i] + "}    "
					query += 1
				elif paramsmethod[i] == "body":
					params = "\t${params}    set variable    ${" + paramskey[i] + "}    "
					body += 1
				elif paramsmethod[i] == "path":
					params_path.append("{" + paramskey[i] + "}")
					path0 += 1
				else:
					print "参数方式错误！"

			content.append(params + "\n")

			if mode == "post":
				resp_params = "data=${params}"
			else:
				resp_params = "params=${params}"

			if body == len(paramskey):
				resp = "\t${resp}    " + mode + " request    exam    " + path + "    headers=${headers}    " + resp_params + "\n"
			elif query == len(paramskey):
				resp = "\t${resp}    " + mode + " request    exam    " + path + "    headers=${headers}    " + resp_params + "\n"
			elif path0 == len(paramskey):
				for j in range(path0):
					path = path.replace(params_path[j], "$" + params_path[j])
				resp = "\t${resp}    " + mode + " request    exam    " + path + "    headers=${headers}\n"
			elif 0 < query < len(paramskey) and 0 < path0 < len(paramskey):
				for j in range(path0):
					path = path.replace(params_path[j], "$" + params_path[j])
				resp = "\t${resp}    " + mode + " request    exam    " + path + "    headers=${headers}    " + resp_params + "\n"

			content.append(resp)

		else:
			resp = "\t${resp}    " + mode + " request    exam    " + path + "    headers=${headers}\n"
			content.append(resp)

		# 断言
		content.append("\tshould be equal as integers    ${resp.status_code}    200    ${resp.content}\n")
		# 转成json
		if isinstance(p.getResponse(), dict) or isinstance(p.getResponse(), list):
			content.append("\t${json}    to json    ${resp.content}\n\tlog    ${json}\n")
			f.writelines(content)
			# 写返回值
			f.write("\t[Return]    ${json}\n\n\n")
		else:
			f.writelines(content)
			# 写返回值
			f.write("\t[Return]    ${resp.content}\n\n\n")
		f.close()

	def apiAll(self):
		paths = Parse().getPaths()
		for path in paths:
			self.apiOne(path)


if __name__ == '__main__':
	CreateAPI().newFile()
	CreateAPI().apiAll()
