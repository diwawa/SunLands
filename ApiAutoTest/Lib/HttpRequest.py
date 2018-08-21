# coding=utf-8
import requests
from Util.YamlTable import *


class HttpRequest(object):
	def __init__(self):
		self.url = url
		self.ReqChannel = ReqChannel

	def getResponse(self, token, mode, path, params=None):
		table = YamlTable()
		basepath = table.get_value(path,mode,"basepath")

		if basepath in path:
			uri = self.url + path
		else:
			uri = self.url + basepath + path

		pattern = re.compile(r'{\w*}')
		path_params = re.findall(pattern, uri)
		for p in path_params:
			key = p[1:-1]
			uri = uri.replace(str(p),str(params[key]))
			del params[key]
		url = uri

		reqchannel = table.get_value(path, mode, "reqchannel")
		if self.ReqChannel not in reqchannel and reqchannel:
			self.ReqChannel = reqchannel.split(",")[0]
		headers = {"Authorization": token, "ReqChannel": self.ReqChannel}

		if mode == "post":
			headers['Content-Type'] = "application/json"
			response = requests.post(url, data=json.dumps(params), headers=headers,verify = False)
		elif mode == "get":
			response = requests.get(url, params=params, headers=headers,verify = False)
		elif mode == "put":
			param_method = table.get_value(path,mode,"param_method")
			if "body" in param_method.values():
				headers['Content-Type'] = "application/json"
				response = requests.put(url, data=json.dumps(params), headers=headers, verify=False)
			else:
				response = requests.put(url, params=params, headers=headers, verify=False)
		else:
			response = -1  # 请求方式输入错误！
		print mode, "    URL = ", response.url
		print "Headers = ", headers
		if params:
			print "Params = ", params
		if response != -1:
			resp_text = response.text
			if "Content-Type" in response.headers:
				if "image/jpeg" in response.headers['Content-Type']:
					resp_text = "image"
		else:
			resp_text = "mode out of range"
		print "Resp = ", resp_text
		resp = self._getRespContent(response)
		return resp

	def _getRespContent(self, response):
		code = response.status_code
		content = response.content
		if code == 200:
			try:
				content = json.loads(content)
			except:
				print "json loads failure"
		resp = (code, content)
		return resp


if __name__ == '__main__':
	HttpRequest().getResponse("aa","get","/trans/api/v1/commodity/system/status")