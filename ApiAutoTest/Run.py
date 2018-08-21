# coding=utf-8
import os
import subprocess

suite = ""
exclude_tag = "NotRun"
include_tag = "DocTest"


def getcmd():
	file_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Cases")

	def _get_tag_str(tag, param_name):
		tag_str = ""
		tags = tag.split(",")
		for t in tags:
			if t:
				tag_str = tag_str + "--" + param_name + " " + t + " "
		return tag_str

	exclude = _get_tag_str(exclude_tag,"exclude")
	include = _get_tag_str(include_tag,"include")

	suites = filter(None,suite.split("/"))
	for s in suites:
		file_dir = os.path.join(file_dir, s)
	cmd = "python -m  robot.run -d ./results " + exclude + include + file_dir
	return cmd


cmd = getcmd()
print cmd
os.system(cmd)
# 执行脚本
# ping = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
# out, error = ping.communicate()
# print(out.decode('GBK'))
