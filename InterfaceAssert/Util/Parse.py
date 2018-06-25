# coding=utf-8
import yaml

u'''
解析yaml接口文件
'''

class Parse(object):
	filename = "exam-swagger.yaml"

	def __init__(self):
		f = open(self.filename)
		self.yamlfile = yaml.load(f)

	def getPaths(self):
		u'''
		获取所有接口路径
		:return: paths
		'''
		return self.yamlfile["paths"].keys()

	def getTags(self):
		tags = self.yamlfile['tags']
		list = []
		for tag in tags:
			name = tag['name']
			list.append(name)
		return list

	def setPath(self, path):
		self.path = path

	def getPath(self):
		return self.path

	def getMode(self):
		path = self.getPath()
		mode = self.yamlfile["paths"][path].keys()
		return mode[0]

	def getCaseName(self):
		path = self.getPath()
		path = path[1:]
		path = path.replace("/", "_")
		if "{" in path and "}" in path:
			name = path.replace("{", "")
			name = name.replace("}", "")
		else:
			name = path
		return name

	def getAPIName(self):
		path = self.getPath()
		name = self.getMode() + path
		return name

	def getTag(self):
		path = self.getPath()
		mode = self.getMode()
		tag = self.yamlfile['paths'][path][mode]['tags']
		return tag[0]

	def getSummary(self):
		path = self.getPath()
		mode = self.getMode()
		summary = self.yamlfile['paths'][path][mode]['summary']
		return summary

	def getParams(self):
		path = self.getPath()
		params = []
		mode = self.getMode()
		try:
			parameters = self.yamlfile['paths'][path][mode]['parameters']
		except:
			parameters = []
		if len(parameters) > 0:
			for parameter in parameters:
				param = {}
				method = parameter['in']
				param['method'] = method
				key = parameter['name']
				if method == 'path':
					type = parameter['type']
					param['name'] = {key: type}
				elif method == 'query':
					type = parameter['type']
					param['name'] = {key: type}
				elif method == 'body':
					schema = parameter['schema']
					type = schema['type']
					if type == "array":
						if "properties" in schema.keys():
							body_parameters = parameter['schema']['properties']
							body_keys = body_parameters.keys()
							if len(body_keys) > 0:
								body = self.getBodyParam(body_parameters)
							param['name'] = {key: [body]}
						else:
							body_parameters = parameter['schema']['items']['properties']
							body_keys = body_parameters.keys()
							if len(body_keys) > 0:
								body = self.getBodyParam(body_parameters)
							param['name'] = {key: [body]}
					else:
						if "properties" in schema.keys():
							body_parameters = parameter['schema']['properties']
							body_keys = body_parameters.keys()
							if len(body_keys) > 0:
								body = self.getBodyParam(body_parameters)
							param['name'] = {key: body}
						else:
							body_parameters = parameter['schema']['items']['properties']
							body_keys = body_parameters.keys()
							if len(body_keys) > 0:
								body = self.getBodyParam(body_parameters)
							param['name'] = {key: body}
				params.append(param)
		return params

	def getBodyParam(self, body):
		resp = {}
		for key in body:
			if body[key]['type'] == "object":
				resp[key] = self.getBodyParam(body[key]['properties'])
			elif body[key]['type'] == "array":
				resp[key] = []
				resp[key].append(self.getBodyParam(body[key]['items']['properties']))
			else:
				resp[key] = body[key]['type']
		return resp

	def getResponse(self):
		path = self.getPath()
		mode = self.getMode()
		responses = self.yamlfile["paths"][path][mode]["responses"]["200"]
		if "schema" in responses.keys():
			schema = responses['schema']
			if "type" in schema.keys():
				type1 = schema['type']
				if type1 == "boolean":
					resp = "true"
				elif type1 == "object":
					resp = {}
					if "properties" in schema.keys():
						param = schema['properties']
						resp = self.getResponseObject(param)
					else:
						pass
				elif type1 == "array":
					resp = []
					items = schema['items']
					if "properties" in items.keys():
						resp.append(self.getResponseObject(items['properties']))
					elif "$ref" in items.keys():
						ref = items["$ref"]
						resp.append(self.getResponseRef(ref))
					else:
						resp.append(items['type'])
				else:
					resp = {}
			else:
				resp = {}
				properties = schema['properties']
				keys = properties.keys()
				for key in keys:
					type1 = properties[key]['type']
					resp[key] = type1
				return resp

		else:
			resp = "OK"

		return resp


	def getResponseObject(self, param):
		resp = {}
		for key in param.keys():
			type1 = param[key]['type']
			if type1 == 'object':
				if "properties" in param[key]:
					properties = param[key]['properties']
					resp[key] = self.getResponseObject(properties)
				else:
					pass
			elif type1 == "array":
				temp = []
				items = param[key]['items']
				if "type" in items.keys():
					if items['type'] == "object":
						if "properties" in items:
							properties = items['properties']
							temp.append(self.getResponseObject(properties))
						else:
							pass
					elif items['type'] == "array":
						pass
					else:
						temp.append(items['type'])
					resp[key] = temp
				elif "properties" in items.keys():
					temp.append(self.getResponseObject(items['properties']))
					resp[key] = temp
				elif "$ref" in items.keys():
					ref = items['$ref']
					temp.append(self.getResponseRef(ref))
					resp[key] = temp
				else:
					temp.append(self.getResponseObject(items))
					resp[key] = temp
			else:
				resp[key] = type1
		return resp

	def getResponseRef(self, ref):
		resp = {}
		name = ref.split("/")[-1]
		param = self.yamlfile["definitions"][name]['properties']
		for key in param:
			if "type" in param[key]:
				type1 = param[key]['type']
				if type1 == "object":
					if "properties" in param[key].keys():
						properties = param[key]['properties']
						resp[key] = self.getResponseObject(properties)
					elif "$ref"in param[key].keys():
						ref0 = param[key]['$ref']
						resp[key] = self.getResponseRef(ref0)
					else:
						pass
				elif type1 == "array":
					temp = []
					items = param[key]['items']
					if "type" in items.keys():
						temp.append(items['type'])
						resp[key] = temp
					elif "properties" in items.keys():
						temp.append(self.getResponseObject(items['properties']))
						resp[key] = temp
					elif "$ref" in items.keys():
						ref = items['$ref']
						temp.append(self.getResponseRef(ref))
						resp[key] = temp
					else:
						temp.append(self.getResponseObject(items))
						resp[key] = temp
				else:
					resp[key] = type1
		return resp


if __name__ == '__main__':
	p = Parse()

	# paths = p.getPaths()
	# for path in paths:
	# 	p.setPath(path)
	# 	re = p.getResponse()
	# 	print path,"================"
	# 	print re
	p.setPath("/pkArena/pkQuestions")
	re = p.getResponse()
	print re

