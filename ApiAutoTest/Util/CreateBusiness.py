# coding=utf-8
from xlutils.copy import copy
from ParserCasesExcel import *
from Conf.Properties import *
from Lib.Function import *


class CreateBusiness(object):
	def __init__(self):
		self.parser = ParserCasesExcel(excel_case_dir)

	def new_business(self):
		with open(business_robot, "r") as f:
			content = f.readlines()
		index = content.index("*** Keywords ***\n")
		for sheet_name, sheet_values in self.parser.data.items():
			business = self._get_business(sheet_values.get('cases', {}))
			self.edit_business_excel(business)
			new_content = self._get_newbusiness_write(business)
			for i in range(len(new_content)):
				content.insert(index + i + 1, new_content[i])
			with open(business_robot, "w") as f:
				f.writelines(content)

	def edit_business_excel(self,business):
		workbook = xlrd.open_workbook(business_tabel)
		sheet2 = workbook.sheet_by_name("sheet1")
		col0_values = sheet2.col_values(0)
		len2 = len(col0_values)
		workbooknew = copy(workbook)
		ws = workbooknew.get_sheet(0)

		for i in range(len((business))):
			key = business.keys()[i]
			if key in col0_values:
				print key ," is exist at Business.xls"
				continue
			ws.write(len2 + i, 0, key)
			ws.write(len2 + i, 1, business[key].get("Documentation", ""))
			ws.write(len2 + i, 2, ",".join(business[key].get("Params", [])))
		workbooknew.save("temp.xls")
		Function().movefile("temp.xls",business_tabel)

	def _get_business_names(self):
		with open(business_robot, "r") as f:
			content = f.readlines()
		index = content.index("*** Keywords ***\n")
		names = []
		for i in range(index + 1, len(content)):
			if not content[i].startswith("    "):
				c = content[i][0:-1]
				if c:
					names.append(c)
		return names

	def _get_newbusiness_write(self, business):
		u'''
		获取新的写入内容
		:param business:
		:return:
		'''
		content = []
		for key, values in business.items():
			content.append(key + "\n")
			param = values.get("Params", [])
			if param:
				content.append("    [Arguments]    " + "    ".join(param) + "\n")
			doc = values.get("Documentation", "")
			if doc:
				content.append("    [Documentation]    " + doc + "\n")
			content.append("    log    " + u'待完成' + "\n\n")
		for i in range(len(content)):
			content[i] = content[i].encode("utf-8")
		return content

	def _get_business(self, c_content):
		business = {}
		for key, values in c_content.items():
			if key != "case_sort":
				business.update(self._get_business_from_caseone(values))
		return business

	def _get_business_from_caseone(self, caseone):
		resp = {}
		exist_keys = self._get_business_names()
		setupId = caseone.get('SetupID', '')
		processId = caseone.get("ProcessID", [])
		teardownId = caseone.get('TeardownID', '')
		keys = list(filter(None, list(set(processId + [setupId, teardownId]))))
		import copy

		keys_copy = copy.deepcopy(keys)
		for key in keys_copy:
			if key in exist_keys:
				keys.remove(key)

		for key in keys:
			if key == setupId:
				doc = caseone.get("SetupDoc", "")
				param = ""
				resp.update({key: {'businessID': key, "Documentation": doc, "Params": param}})

			if key == teardownId:
				doc = caseone.get("TeardownDoc", "")
				param = ""
				resp.update({key: {'businessID': key, "Documentation": doc, "Params": param}})

			if key in processId:
				index = processId.index(key)
				doc = caseone.get("ProcessDoc", [])[index]
				param = caseone.get("Params", [])[index]
				resp.update({key: {'businessID': key, "Documentation": doc, "Params": param}})
		return resp
