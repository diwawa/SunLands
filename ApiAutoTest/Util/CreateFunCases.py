# coding=utf-8
from ParserCasesExcel import *
from Conf.Properties import *


class CreateFunCases(object):
	def __init__(self):
		self.parser = ParserCasesExcel(excel_case_dir)

	def new_cases(self):
		for sheet_name,sheet_values in self.parser.data.items():
			self.new_case_one(sheet_name,sheet_values)

	def new_case_one(self, sheet_name,sheet_values):
		content_setting = self._write_settings(sheet_values.get('settings',{}))
		content_variables = self._write_variables(sheet_values.get('variables',{}))
		content_case = self._write_cases(sheet_values.get('cases',{}))
		content = content_setting + content_variables + content_case

		for i in range(len(content)):
			content[i] = content[i].encode("utf-8")
		dir = os.path.join(case_dir, sheet_name + ".robot")
		with open(dir, "w") as f:
			f.writelines(content)

	def _write_settings(self, s_content):
		content = []
		content.append("*** Settings ***\n")
		s_key = self.parser.get_settings_names()
		for key in s_key:
			if key in s_content.keys():
				values = map(unicode, s_content[key])
				if key in ['Library','Resource','Variables']:
					for value in values:
						string = key + "\t        " + value + "\n"
						content.append(string)
				else:
					string = key + "\t        " + "    ".join(values) + "\n"
					content.append(string)
		content.append("\n\n")
		return content

	def _write_variables(self, v_content):
		content = []
		if v_content:
			content.append("*** Variables ***\n")
			for key,values in v_content.items():
				values = map(unicode, values)
				string = key + "\t        "+ "    ".join(values)+"\n"
				content.append(string)
			content.append("\n\n")
		return content

	def _write_cases(self, c_content):
		content = []
		caseids = c_content.get("case_sort", [])
		if caseids:
			content.append("*** Test Cases ***\n")
		for caseid in caseids:
			values = c_content.get(caseid, {})
			content.append(caseid + "\n")

			documentation = values.get("Documentation", "")
			if documentation:
				content.append("    [Documentation]    " + documentation + "\n")
			tags = values.get("Tags", [])
			if tags:
				string = "    ".join(tags)
				content.append("    [Tags]    " + string + "\n")
			setup = values.get("SetupID", "")
			if setup:
				content.append("    [Setup]    " + setup + "\n")

			processId = values.get("ProcessID", [])
			if processId:
				for i in range(len(processId)):
					content.append("    " + processId[i] + "    " + "    ".join(values['Params'][i]) + "\n")
			teardown = values.get("TeardownID", "")
			if teardown:
				content.append("    [Teardown]    " + teardown + "\n")
			content.append("\n")
		return content

