# coding=utf-8
import xlrd


class ParserCasesExcel(object):
	def __init__(self, file_dir):
		self.workbook = xlrd.open_workbook(file_dir)
		self.sheet_names = self.workbook.sheet_names()
		self.settings_row = [1, 14]
		self.variables_row = [16]
		self.col = 12
		self.cases_split = "*** Test Cases ***"
		self.data = {}
		self.build_data()

	def get_sheet(self,sheet_name):
		return self.workbook.sheet_by_name(sheet_name)

	def build_data(self):
		for sheet_name in self.sheet_names:
			self.data[sheet_name] = {}
			sheet = self.workbook.sheet_by_name(sheet_name)
			self.data[sheet_name]['settings'] = self._get_settings(sheet)
			self.data[sheet_name]['variables'] = self._get_variables(sheet)
			self.data[sheet_name]['cases'] = self._get_cases(sheet)

	def get_settings_names(self):
		sheet = self.workbook.sheet_by_name(self.sheet_names[0])
		values = sheet.col_values(0, self.settings_row[0], self.settings_row[1])
		values = list(filter(None, values))
		return values

	def get_variables_names(self):
		sheet = self.workbook.sheet_by_name(self.sheet_names[0])
		values = sheet.row_values(self.variables_row[0] - 1)
		values = list(filter(None, values))
		return values

	def get_cases_names(self):
		sheet = self.workbook.sheet_by_name(self.sheet_names[0])
		values_0 = sheet.col_values(0)
		c_row = values_0.index(self.cases_split)
		values = sheet.row_values(c_row + 1)
		values = list(filter(None, values))
		return values

	def _get_variables_row(self, sheet):
		values = sheet.col_values(0)
		c_row = values.index(self.cases_split)
		self.variables_row.append(c_row)
		variables_row = self.variables_row
		return variables_row

	def _get_cases_row(self, sheet):
		values = sheet.col_values(0)
		c_row = values.index(self.cases_split)
		cases_row = [c_row + 2, len(sheet.col_values(0))]
		return cases_row

	def _get_settings(self, sheet):
		var_names = self.get_settings_names()
		settings = {}
		row = self.settings_row
		for i in range(row[0], row[1]):
			key = var_names[i - row[0]]
			value = sheet.row_values(i, 1)
			value = list(filter(None, value))
			if len(value) == 0:
				continue
			settings.update({key: value})
		return settings

	def _get_variables(self, sheet):
		row = self._get_variables_row(sheet)
		variables = {}
		for i in range(row[0], row[1]):
			key = sheet.cell(i, 0).value
			value = sheet.row_values(i,1)
			value = list(filter(None, value))
			if len(value) == 0:
				continue
			variables.update({key: value})
		return variables

	def _get_cases(self, sheet):
		row = self._get_cases_row(sheet)
		CaseID = sheet.col_values(0, row[0])
		caseid_row = self.find_slice(CaseID)
		caseids = list(filter(None, CaseID))
		cases = {}
		for id in caseids:
			start_row = caseid_row[id][0] + row[0]
			end_row = caseid_row[id][1] + row[0]
			value = self._tans_cases(sheet, start_row, end_row)
			cases.update({id: value})
		cases.update({"case_sort": caseids})
		return cases

	def _tans_cases(self, sheet, start_row, end_row):
		var_names = self.get_cases_names()
		case_one = {}
		for i in range(self.col):
			key = var_names[i]
			value = sheet.col_values(i, start_row, end_row + 1)
			if key not in ['ProcessID', 'ProcessDoc', 'Params']:
				values = "".join(value)
			else:
				if key == "Params":
					values = []
					for v in value:
						v = v.split(",")
						values.append(v)
				else:
					values = value
			if len(values) == 0:
				continue
			case_one.update({key: values})
		tags = case_one.get("Tags", "").split(",")
		tags.insert(0, case_one.get("IsRun", ""))
		tags = list(filter(None, tags))
		if tags:
			case_one["Tags"] = tags
		return case_one

	@staticmethod
	def find_slice(str_list):
		retv_dict = dict()
		before = 0
		up_char = ''
		str_len = len(str_list)
		for index, s in enumerate(str_list):
			if s:
				if before + 1 == index:
					retv_dict[up_char] = [before, before]
				if index + 1 == str_len:
					retv_dict[s] = [index, index]
				up_char, before = s, index
			elif (not s and index < str_len - 1 and str_list[index + 1]) or (index == str_len - 1):
				retv_dict[up_char] = [before, index]

		return retv_dict
