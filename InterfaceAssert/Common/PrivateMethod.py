# coding=utf-8
import random

class PrivateMethod(object):
	def __init__(self):
		pass

	def getPkScore(self, correct, answer, duration, isLast):
		u'''
		通过答题时间的长短，返回获得的分数
		'''
		if correct == answer:
			if 0 <= int(duration) <= 2:
				score = 10
			elif 2 < int(duration) <= 4:
				score = 8
			elif 4 < int(duration) <= 6:
				score = 6
			elif 6 < int(duration) <= 8:
				score = 4
			elif 8 < int(duration) <= 10:
				score = 2
			else:
				score = 0

			if isLast:
				score *= 2
		else:
			score = 0
		return score

	def getPKresult(self, scorelist1, scorelist2):
		u'''
		根据每题得分，判断PK结果
		'''
		scorelist1 = list(scorelist1)
		scorelist2 = list(scorelist2)
		sum1 = 0
		sum2 = 0
		for x in range(len(scorelist1) - 1):
			sum1 += scorelist1[x]
			sum2 += scorelist2[x]
		if sum1 <= sum2:
			sum1 += scorelist1[-1]
			sum2 += scorelist2[-1]
			if sum1 > sum2:
				result = "FINAL_HIT"
			elif sum1 == sum2:
				result = "DRAW"
			else:
				result = "LOSE"
		else:
			sum1 += scorelist1[-1]
			sum2 += scorelist2[-1]
			if sum1 > sum2:
				if sum1 - sum2 <= 2:
					result = "WIN_MARGIN"
				else:
					result = "WIN"
			elif sum1 == sum2:
				result = "DRAW"
			else:
				result = "LOSE"
		return result

	def getPKGranding(self, beforeGrading, beforeStar, results):
		u'''
		通过pk前的段位及星星数量和pk结果，获取当前的段位名称，星星数量
		'''
		grading = (u'黑铁', u'青铜', u'白银', u'黄金', u'铂金', u'钻石', u'星耀', u'王者')
		star = (1, 2, 3, 5, 7, 9, 12, 100)

		if str(results) in ("WIN", "WIN_MARGIN", "FINAL_HIT"):
			pkstar = int(beforeStar) + 1
		elif str(results) == "LOSE":
			pkstar = int(beforeStar) - 1
		elif str(results) == "DRAW":
			pkstar = int(beforeStar)
		else:
			pkstar = int(beforeStar)

		index = grading.index(beforeGrading)
		if pkstar < 0:
			pkgrading = beforeGrading
			pkstar = 0
		elif pkstar == star[index]:
			pkgrading = grading[index + 1]
			pkstar = 0
		else:
			pkgrading = beforeGrading

		data = {"pkgrading": pkgrading, "pkstar": pkstar}
		return data

	def getApmTile(self,title_int):
		u'''
		根据title的int值，返回对应的汉字
		:param title_int:
		:return:
		'''
		title_int = int(title_int)
		title = ""
		if title_int==1:
			title = u"玉女无痕手"
		elif title_int == 2:
			title = u"兰花拂穴手"
		elif title_int == 3:
			title = u"隔空点穴手"
		elif title_int == 4:
			title = u"葵花点穴手"
		else:
			print u"暂时还没有称号"

		return title

	def getApmFinal(self,pointSum):
		u'''
		根据点击次数返回获得题量和称号
		:param pointSum: 点击次数
		:return:
		'''
		final = {"pointSum":pointSum}
		pointSum = int(pointSum)
		if pointSum == 0:
			final['question'] = 0
		elif 0 < pointSum < 10:
			final['question'] = 5
		elif 10 <= pointSum < 20:
			final['question'] = 10
		elif 20 <= pointSum < 30:
			final['question'] = 15
		elif 30 <= pointSum < 45:
			final['question'] = 20
		elif 45 <= pointSum < 60:
			final['question'] = 25
		elif 60 <= pointSum < 80:
			final['question'] = 30
		else:
			final['question'] = 35

		if 0 <= pointSum < 40:
			final['title'] = u"玉女无痕手"
		elif 40 <= pointSum < 60:
			final['title'] = u"兰花拂穴手"
		elif 60 <= pointSum < 100:
			final['title'] = u"隔空点穴手"
		else:
			final['title'] = u"葵花点穴手"

		return final

	def listToString(self,list):
		u'''
		将list转换为string，元素之间 ， 隔开
		:param:list
		:return:string
		'''
		string = ''
		for i in range(len(list)):
			string += str(list[i])
			if i == len(list) - 1:
				break
			else:
				string += ','
		return string

	def getQuestion(self,qtype, options):
		u'''
		根据题目类型和选项获得答案
		:param:qtype,options
		:return:answer
		'''
		answer = []
		if qtype == 'SINGLE_ANSWER' or qtype == 'JUDGE_ANSWER':
			answer.append(random.choice(options))
		elif qtype == 'MULTIPLE_ANSWER':
			l = len(options)
			n = random.randint(1, int(l))
			for i in range(n):
				ele = random.choice(options)
				if ele in answer:
					pass
				else:
					answer.append(ele)
		else:
			pass
		return answer


if __name__ == '__main__':
	f = PrivateMethod()
	aa =  f.getApmFinal(80)
	for key in aa:
		print key ,":" ,aa[key]
