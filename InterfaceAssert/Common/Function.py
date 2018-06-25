# coding=utf-8
import time
import datetime
import random


class Function(object):
	def __init__(self):
		pass

	def convertSeconds(self,minutes):
		u'''
		将分钟转换成秒
		:param minutes:
		:return:
		'''
		minutes = str(minutes)
		list1 = minutes.split("\'")
		seconds = int(list1[0]) * 60 + int(list1[1])
		return seconds

	def convertTimestamp(self, data):
		u'''
		将时间转换成时间戳
		'''
		# 转换成时间数组
		timeArray = time.strptime(data, "%Y-%m-%d %H:%M:%S")
		# 转换成时间戳
		timestamp = int(time.mktime(timeArray))

		return timestamp

	def getPercent(self, num, sum, n):
		u'''
		返回百分数，四舍五入到小数点后n位
		:param num:分子
		:param sum:分母
		:param n:小数点后几位，如果位0，返回整数
		:return:
		'''
		num = int(num)
		sum = int(sum)
		n = int(n)
		if num == 0:
			return 0
		elif sum == 0:
			return 0
		else:
			num = float(num)
			sum = float(sum)
			rate = round(num * 100 / sum, n)
			if n==0:
				rate = int(rate)
			return rate

	def getPercentUp(self, num, sum):
		u'''
		返回百分数,向上取整
		:param num:
		:param sum:
		:return:
		'''
		num = int(num)
		sum = int(sum)
		if num == 0:
			return 0
		elif sum==0:
			return 0
		else:
			rate = num * 100 / sum
			return rate+1

	def getPercentDown(self, num, sum):
		u'''
		返回百分数,向下取整
		:param num:
		:param sum:
		:return:
		'''
		num = int(num)
		sum = int(sum)
		if num == 0:
			return 0
		elif sum==0:
			return 0
		else:
			rate = num * 100 / sum
			return rate

	def getRandomInt(self, num1, num2):
		u'''
		获取num1到num2的随机整数,包含上下限
		'''
		return random.randint(int(num1), int(num2))

	def getRandomChar(self, string, num):
		u'''
		在字符串string中获取num个字符，返回值为list
		'''
		return random.sample(string, num)

	def getRandomStr(self, listn):
		u'''
		在listn中随机获取其中一个字符串，返回string
		'''
		return random.choice(listn)

	def getRandomList(self, listn):
		u'''
		在listn中随机获取多个元素，返回list
		'''
		re_list = []
		l = len(listn)
		if l>0:
			n = self.getRandomInt(1,l)
			for i in range(n):
				ele = random.choice(listn)
				if ele in re_list:
					pass
				else:
					re_list.append(ele)
		return re_list

	def compareResp(self, resp, response):
		u'''
		比较接口返回值与接口文档是否一致
		:param resp:  接口文档定义的返回值
		:param response:  接口返回值
		'''
		re_dict = {"status": True}

		def changeUnicode(response):
			if isinstance(response,unicode):
				response = response.encode("utf-8")
			return type(response)

		type1 = type(resp)
		type2 = changeUnicode(response)

		if type1 == type2:
			while True:
				if isinstance(resp, dict):
					break
				elif isinstance(resp, list):
					resp = resp[0]
					response = response[0]
				else:
					break

			if isinstance(resp,dict):
				keys1 = resp.keys()
				keys1.sort()
				keys2 = response.keys()
				keys2.sort()

				if keys1 == keys2:
					for key in keys1:
						v1 = resp[key]
						v2 = response[key]
						t1 = type(v1)
						t2 = changeUnicode(v2)

						if t1 == t2:
							pass
						else:
							# 类型不一致，返回false，并返回对应类型值
							re_dict["status"] = False
							re_dict[key] = {'DocumentType': t1, 'ResponseType': t2}
				else:
					re_dict['status'] = False
					index1 = []
					index2 = []
					for key1 in keys1:
						for key2 in keys2:
							if key1 == key2:
								i1 = keys1.index(key1)
								i2 = keys2.index(key2)
								index1.append(i1)
								index2.append(i2)
					index1.reverse()
					for i in index1:
						keys1.pop(i)
					index2.sort()
					index2.reverse()
					for i in index2:
						keys2.pop(i)

					re_dict["DocumentKeys"] = keys1
					re_dict["ResponseKeys"] = keys2
		else:
			re_dict['status'] = False
			re_dict["DocumentType"] = type1
			re_dict["ResponseType"] = type2
		return re_dict


if __name__ == '__main__':
	f = Function()
	print f.convertSeconds("0'50")
