# coding=utf-8
from YamlTable import *
from CreateFunCases  import *
from CreateBusiness import *
from CreateAPICases import *


class Prepare(object):
	def __init__(self):
		pass

	def run_yaml_table(self):
		YamlTable().trans_excel()

	def run_create_fun_cases(self):
		CreateFunCases().new_cases()

	def run_create_api_cases(self):
		table = YamlTable()
		new_path = table.get_new_paths()
		for path in new_path:
			filename = YamlTable().get_filename(path=path)
			file_dir = os.path.join(conf_dir, filename + ".yaml")
			new_case = CreateAPICases(file_dir)
			tag = table.get_path_tag(path)
			if not os.path.exists(os.path.join(api_cases_dir, tag + ".robot")):
				new_case.fileOne(tag)
			new_case.caseOne(path)

	def run_create_business(self):
		CreateBusiness().new_business()


if __name__ == '__main__':
	p = Prepare()
	# p.run_yaml_table()
	# p.run_create_api_cases()
	p.run_create_fun_cases()
	p.run_create_business()
