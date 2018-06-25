# coding=utf-8
import time
import datetime
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


if __name__ == '__main__':
	f = PrivateMethod()
	print f.convertSeconds("0'50")
