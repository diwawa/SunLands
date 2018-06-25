# coding=utf-8
import pymysql
from Base import dbHost
from Base import dbPort
from Base import dbName
from Base import dbUsername
from Base import dbPassword
from Base import dbCharset


class MySQL(object):
	def __init__(self):
		# 连接数据库
		self.conn = pymysql.connect(host=dbHost, port=dbPort, user=dbUsername, passwd=dbPassword, db=dbName,
									charset=dbCharset)

	def getRowCount(self, sql):
		u'''
		获取行数
		:param sql:
		:return:
		'''
		cursor = self.conn.cursor()
		count = cursor.execute(sql)
		cursor.close()
		return count

	def getFistRow(self, sql):
		u'''
		获取剩余结果第一行
		:param sql:
		:return:
		'''
		result = ""
		cursor = self.conn.cursor()
		count = cursor.execute(sql)
		if count==0:
			pass
		else:
			row = cursor.fetchone()
			result =  list(row)
		cursor.close()
		return result

	def getFewRow(self, sql, num):
		u'''
		获取剩余结果前num行
		:param sql:
		:param num:
		:return:
		'''
		result = ""
		cursor = self.conn.cursor()
		count = cursor.execute(sql)
		if count==0:
			pass
		else:
			if count < num:
				row = cursor.fetchmany(count)
			else:
				row = cursor.fetchmany(num)
			list2 = []
			for x in range(len(row[0])):
				list1 = []
				for i in range(len(row)):
					list1.append(row[i][x])
				list2.append(list1)
			result = list2
		cursor.close()
		return result

	def getAllRow(self, sql):
		u'''
		获取剩余结果所有数据
		:param sql:
		:return:
		'''
		result = ""
		cursor = self.conn.cursor()
		count = cursor.execute(sql)
		if count==0:
			pass
		else:
			row = cursor.fetchall()
			list2 = []
			for x in range(len(row[0])):
				list1 = []
				for i in range(len(row)):
					list1.append(row[i][x])
				list2.append(list1)
			result =  list2
		cursor.close()
		return result

	def __del__(self):
		self.conn.close()


if __name__ == '__main__':
	sql = "SELECT subject_name,id FROM `subject` WHERE id=1"
	mysql = MySQL()
	print mysql.getRowCount(sql)
	print mysql.getFistRow(sql)
	print mysql.getFewRow(sql, 2)
	print mysql.getAllRow(sql)
