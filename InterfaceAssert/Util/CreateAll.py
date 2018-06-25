# coding=utf-8
from Parse import Parse
from CreateAPI import CreateAPI
from CreateResp import CreateResp
from CreateParam import CreateParam
from CreateCase import CreateCase


class CreateAll(object):
	def __init__(self):
		pass

	def getTagPaths(self):
		paths = list( Parse().getPaths())
		paths.sort()
		tags = list(Parse().getTags())
		tags.sort()

		p = Parse()
		tags_paths = {}
		for tag in tags:
			tags_paths[tag] = []
			index = []
			for path in paths:
				p.setPath(path)
				path_tag = p.getTag()
				if path_tag == tag:
					tags_paths[tag].append(path)
					index.append(paths.index(path))
			index.sort()
			index.reverse()
			for i in index:
				paths.pop(i)

		return tags_paths

	def createTag(self, tag):
		tags_paths = self.getTagPaths()
		if tag in tags_paths.keys():
			CreateAPI().fileOne(tag)
			for path in tags_paths[tag]:
				CreateAPI().apiOne(path)

			CreateResp().fileOne(tag)
			for path in tags_paths[tag]:
				CreateResp().respOne(path)

			CreateParam().fileOne(tag)
			for path in tags_paths[tag]:
				CreateParam().paramOne(path)

			CreateCase().fileOne(tag)
			for path in tags_paths[tag]:
				CreateCase().caseOne(path)
		else:
			print tag + u"不存在！"

	def createPath(self, path):
		CreateAPI().apiOne(path)
		CreateResp().respOne(path)
		CreateParam().paramOne(path)
		CreateCase().caseOne(path)


if __name__ == '__main__':
	# CreateAll().createPath("")
	CreateAll().createTag("Subject")
