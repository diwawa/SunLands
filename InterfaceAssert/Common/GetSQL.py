# coding=utf-8
from MySQL import *
from Function import *
import json


class GetSQL(object):
	def __init__(self):
		pass

	def examType(self):
		mysql = MySQL()
		sql = {}
		query_parent = "SELECT id,primary_categories FROM `exam_type` WHERE parent_id IS NULL AND del_flag=0"
		parent = mysql.getAllRow(query_parent)
		sql["parent_id"] = parent[0]
		sql["parent_name"] = parent[1]
		sql["child_id"] = []
		sql["child_name"] = []
		for id in sql["parent_id"]:
			query_child = "SELECT id,primary_categories FROM `exam_type` WHERE parent_id="+str(id)+" AND del_flag=0"
			print query_child
			child = mysql.getAllRow(query_child)
			if child=='':
				sql["child_id"].append([])
				sql["child_name"].append([])
			else:
				sql["child_id"].append(child[0])
				sql["child_name"].append(child[1])
		return sql

	def subject(self, exam_type_id):
		print "exam_type_id=",exam_type_id
		mysql = MySQL()
		sql = {}
		fields = "id,subject_name,number"
		listfields = fields.split(",")
		query = "SELECT " + fields + " FROM `subject` WHERE del_flag=0 AND exam_type_id=" + str(exam_type_id) + " ORDER BY number"
		print query
		result = mysql.getAllRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]
		return sql

	def userInfo(self, user_id):
		u'''
		通过用户id，获取用户基础信息
		:param user_id:
		:return:  dict
		'''
		print "user_id=", user_id
		mysql = MySQL()
		sql = {}
		fields = "head_image_url,nick_name,gender,location,phone_number,source"
		listfields = fields.split(",")
		query = "SELECT " + fields + " FROM `user` WHERE del_flag=0 AND id=" + str(user_id)
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]
		return sql

	def userAlterableInfo(self, user_id, exam_type_id=0):
		u'''
		通过用户id，获取用户可变的信息
		:param user_id:
		:return:  dict
		'''
		print "user_id=", user_id
		print "exam_type_id=", exam_type_id
		mysql = MySQL()
		sql = {}
		fields = "exam_type_id,secondary_categories,user_integral,level_id,subject_id,dan_grading_id,current_star,pk_sum,win_sum"
		listfields = fields.split(",")
		if exam_type_id == 0:
			query = "SELECT " + fields + \
					" FROM relation_user_exam_type WHERE del_flag=0 AND current=1 AND user_id=" + str(user_id)
		else:
			query = "SELECT " + fields + \
					" FROM relation_user_exam_type WHERE del_flag=0 AND user_id=" + str(user_id) + \
					" AND exam_type_id=" + str(exam_type_id)
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]

		exam_type_id = sql["exam_type_id"]
		fields_time = "begain_date,end_date,`year`"
		listfields_time = fields_time.split(",")
		query_time = "SELECT " + fields_time + " FROM exam_time WHERE id =( SELECT MAX(exam_time_id) FROM `relation_exam_time_type` WHERE exam_type_id =" + str(exam_type_id) + ")"
		result_time = mysql.getFistRow(query_time)
		for i in range(len(result_time)):
			sql[listfields_time[i]] = result_time[i]

		sql['examTimeInfo'] = self.examTimeInfo(sql['begain_date'],sql['end_date'])


		level_id = sql["level_id"]
		fields_level = "level_num,min_integral,max_integral,level_name"
		listfields_level = fields_level.split(",")
		query_level = "SELECT " + fields_level + " FROM `level` WHERE id=" + str(level_id)
		result_level = mysql.getFistRow(query_level)
		for i in range(len(result_level)):
			sql[listfields_level[i]] = result_level[i]

		subject_id = sql["subject_id"]
		fields_subject = "subject_name"
		listfields_subject = fields_subject.split(",")
		query_subject = "SELECT " + fields_subject + " FROM `subject` WHERE id=" + str(subject_id)
		result_subject = mysql.getFistRow(query_subject)
		for i in range(len(result_subject)):
			sql[listfields_subject[i]] = result_subject[i]

		dan_grading_id = sql["dan_grading_id"]
		fields_grading = "dan_grading_name,min_star,max_star,number,integral"
		listfields_grading = fields_grading.split(",")
		query_grading = "SELECT " + fields_grading + " FROM `dan_grading` WHERE del_flag=0 AND id=" + str(
			dan_grading_id)
		result_grading = mysql.getFistRow(query_grading)
		for i in range(len(result_grading)):
			sql[listfields_grading[i]] = result_grading[i]

		return sql

	def userCartogram(self, user_id):
		print "user_id=", user_id
		mysql = MySQL()
		sql = {}
		fields = "answer_ration,diligent,accuracy,duration_ratio,score_ratio,question_sum"
		listfields = fields.split(",")
		query = "SELECT " + fields + " FROM `user_cartogram` WHERE user_id=" + str(user_id)
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]
		return sql

	def examShare(self, user_id,exam_type_id):
		print "user_id=", user_id
		print "exam_type_id=", exam_type_id
		mysql = MySQL()
		sql = {}
		fields = "share_mark"
		listfields = fields.split(",")
		query = "SELECT " + fields + " FROM `exam_share` WHERE del_flag=0 AND user_id=" + str(user_id) + " AND exam_type_id=" + str(exam_type_id) + " ORDER BY id DESC"
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]
		return sql

	def pkQuestionCount(self, user_id, exam_type_id=0):
		print "user_id=", user_id
		print "exam_type_id=", exam_type_id
		mysql = MySQL()
		sql = {}
		query_count = "SELECT * FROM pk_log_details WHERE del_flag=0 AND user_id=" + str(user_id)
		query_correct = "SELECT * FROM pk_log_details WHERE del_flag=0 AND correct_answer = user_answer AND user_id=" + str(
			user_id)
		result_count = mysql.getRowCount(query_count)
		result_correct = mysql.getRowCount(query_correct)
		sql['count'] = result_count
		sql['correct'] = result_correct
		if exam_type_id == 0:
			pass
		else:
			query_count_week = "SELECT * FROM pk_log_details WHERE del_flag = 0 AND YEARWEEK(DATE_FORMAT(modifi_date,'%Y-%m-%d')) = YEARWEEK(NOW()) AND pk_log_id IN (SELECT id FROM `pk_log` WHERE exam_type_id=" + str(exam_type_id) + ") AND user_id =" + str(
				user_id)
			query_correct_week = "SELECT * FROM pk_log_details WHERE del_flag = 0 AND YEARWEEK(DATE_FORMAT(modifi_date,'%Y-%m-%d')) = YEARWEEK(NOW()) AND correct_answer = user_answer AND pk_log_id IN (SELECT id FROM `pk_log` WHERE exam_type_id=" + str(exam_type_id) + ") AND user_id =" + str(
				user_id)
			result_count_week = mysql.getRowCount(query_count_week)
			result_correct_week = mysql.getRowCount(query_correct_week)
			sql['count_week'] = result_count_week
			sql['correct_week'] = result_correct_week
		return sql

	def answerQuestionCount(self, user_id, exam_type_id=0):
		print "user_id=", user_id
		print "exam_type_id=", exam_type_id
		mysql = MySQL()
		sql = {}
		query_count = "SELECT * FROM user_answer_details WHERE del_flag=0 AND user_answer_id IN (SELECT id FROM `user_answer` WHERE user_id=" + str(user_id) +")"
		query_correct = "SELECT * FROM user_answer_details WHERE del_flag=0 AND answer_correct>0 AND user_answer_id IN (SELECT id FROM `user_answer` WHERE user_id=" + str(user_id) +")"
		result_count = mysql.getRowCount(query_count)
		result_correct = mysql.getRowCount(query_correct)
		sql['count'] = result_count
		sql['correct'] = result_correct
		if exam_type_id == 0:
			pass
		else:
			query_count_week = "SELECT * FROM user_answer_details WHERE del_flag = 0 AND YEARWEEK(DATE_FORMAT(modifi_date,'%Y-%m-%d')) = YEARWEEK(NOW()) AND user_answer_id IN (SELECT id FROM `user_answer` WHERE user_id=" + str(user_id) +" AND exam_type_id=" +str(exam_type_id) + ")"
			query_correct_week = "SELECT * FROM user_answer_details WHERE del_flag = 0 AND YEARWEEK(DATE_FORMAT(modifi_date,'%Y-%m-%d')) = YEARWEEK(NOW()) AND answer_correct>0 AND user_answer_id IN (SELECT id FROM `user_answer` WHERE user_id=" + str(user_id) +" AND exam_type_id=" +str(exam_type_id) + ")"
			result_count_week = mysql.getRowCount(query_count_week)
			result_correct_week = mysql.getRowCount(query_correct_week)
			sql['count_week'] = result_count_week
			sql['correct_week'] = result_correct_week
		return sql

	def pkLog(self,pk_log_id):
		print "pk_log_id=", pk_log_id
		mysql = MySQL()
		sql = {}
		fields = "win_user_id,pk_type,question_ids,surpass,head_img_urls"
		listfields = fields.split(",")
		query = "SELECT " + fields + " FROM `pk_log` WHERE id=" + str(pk_log_id)
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]
		if isinstance(sql['head_img_urls'],unicode):
			head_img_urls = sql['head_img_urls'].split(",")
			sql['head_img_urls'] = head_img_urls
		else:
			sql['head_img_urls'] = []
		if isinstance(sql['surpass'],int):
			pass
		else:
			sql['surpass'] = 0

		fields_mark = "source_user_id,share_mark"
		listfields_mark = fields_mark.split(",")
		query_mark = "SELECT " + fields_mark + " FROM `relation_pk_share` WHERE pk_log_id=" + str(pk_log_id)
		result_mark = mysql.getFistRow(query_mark)
		for i in range(len(result_mark)):
			sql[listfields_mark[i]] = result_mark[i]

		question_ids = sql['question_ids'].split(",")
		sql['question_ids'] = question_ids
		sql['question_count'] = len(question_ids)
		questions = []
		for question_id in question_ids:
			question = self.question(question_id)
			questions.append(question)
		sql['questions'] = questions
		return sql

	def pkLogDetails(self, user_id,pk_log_id,question_id):
		print "user_id=", user_id
		print "pk_log_id=", pk_log_id
		print "question_id=", question_id
		mysql = MySQL()
		sql = {}
		fields = "user_answer,duration,score_add"
		listfields = fields.split(",")
		query = "SELECT " + fields + " FROM `pk_log_details` WHERE user_id="+str(user_id)+" AND pk_log_id="+str(pk_log_id)+" AND question_id=" + str(question_id)
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]
		return sql

	def question(self, question_id):
		print "question_id=", question_id
		mysql = MySQL()
		sql = {}
		fields = "id,question_type,question_desc,correct_answer,options_desc,correct_answer_desc"
		listfields = fields.split(",")
		query = "SELECT " + fields + " FROM `exam_question`WHERE id=" + str(question_id)
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]

		options_desc = sql['options_desc']
		if "\'" in options_desc:
			print 111
			options_desc = options_desc.replace("\'","\"")
		else:
			pass
		sql['options_desc'] = options_desc

		query_1 = " SELECT * FROM `last_user_question` WHERE question_id=" + str(question_id) + " AND error_num>0"
		query_4 = " SELECT * FROM `last_user_question` WHERE question_id=" + str(question_id)
		query_2 = " SELECT * FROM `last_user_question` WHERE question_id=" + str(question_id) + " AND error_num>=2"
		query_3 = "SELECT error_num,done_sum FROM `last_user_question` WHERE question_id=" + str(question_id)
		errorPeopleCount = mysql.getRowCount(query_1)
		error2TimesPeopleCount = mysql.getRowCount(query_2)
		DonePeopleCount = mysql.getRowCount(query_4)
		sql['errorPeopleCount'] = errorPeopleCount
		sql['error2TimesPeopleCount'] = error2TimesPeopleCount
		sql['DonePeopleCount'] = DonePeopleCount

		result_3 = mysql.getAllRow(query_3)
		if result_3 == "":
			sql['errorRate'] = 0
		else:
			error_num = 0
			done_sum = 0
			for i in range(len(result_3[0])):
				if isinstance(result_3[0][i], int):
					error_num += result_3[0][i]
				if isinstance(result_3[1][i], int):
					done_sum += result_3[1][i]
			errorRate = Function().getPercent(error_num, done_sum, 1)
			sql['errorRate'] = errorRate

		if DonePeopleCount==0:
			int_errorFatherRate = 0
			float_errorFatherRate=0
		else:
			int_errorFatherRate = error2TimesPeopleCount * 5 / DonePeopleCount
			float_errorFatherRate = float(error2TimesPeopleCount) * 5 / float(DonePeopleCount)
		if float_errorFatherRate - int_errorFatherRate < 0.5:
			errorFatherRate = int_errorFatherRate
		else:
			errorFatherRate = int_errorFatherRate + 0.5
		sql['errorFatherRate'] = errorFatherRate

		return sql

	def examTimeInfo(self,begin,end):
		now = datetime.datetime.now()
		now = datetime.datetime(now.year, now.month, now.day)
		begin = datetime.datetime(begin.year, begin.month, begin.day)
		end = datetime.datetime(end.year, end.month, end.day)

		data = {'examDate': '', 'intervalDays': '', 'examType': ''}
		if now < begin:
			if end.month < 10:
				examDate = str(begin.year) + u"年0" + str(begin.month) + u"月" + str(begin.day) + u"日"
			else:
				examDate = str(begin.year) + u"年" + str(begin.month) + u"月" + str(begin.day) + u"日"
			data['examDate'] = examDate
			intervalDays = begin - now
			data['intervalDays'] = intervalDays.days
			data['examType'] = "WAITING"
		elif now > end:
			pass
		else:
			if end.month < 10:
				examDate = str(end.year) + u"年0" + str(end.month) + u"月" + str(end.day) + u"日"
			else:
				examDate = str(end.year) + u"年" + str(end.month) + u"月" + str(end.day) + u"日"
			data['examDate'] = examDate
			intervalDays = end - now
			data['intervalDays'] = intervalDays
			data['examType'] = "NOW"
		return data

	def dailyPractice(self,user_id):
		print "user_id=", user_id
		mysql = MySQL()
		sql = {}
		fields = "exam_type_id,subject_id"
		listfields = fields.split(",")
		query = "SELECT " + fields +" FROM relation_user_exam_type WHERE del_flag=0 AND current=1 AND user_id=" + str(user_id)
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]

		now = datetime.datetime.now()
		year = now.year
		month = now.month
		day = now.day
		subject_id = sql['subject_id']
		fields_clock = "clock_in_details,clock_in_sum,continue_sum"
		listfields_clock = fields_clock.split(",")
		query_clock = "SELECT " + fields_clock + " FROM `user_clock_in` WHERE EXTRACT(MONTH FROM create_date)=EXTRACT(MONTH FROM NOW()) AND user_id=" + str(user_id) + " AND subject_id=" + str(subject_id)
		result_clock = mysql.getFistRow(query_clock)
		for i in range(len(result_clock)):
			sql[listfields_clock[i]] = result_clock[i]

		clock_in_details = sql['clock_in_details'].split(",")
		temp = []
		for i in range(len(clock_in_details)):
			if clock_in_details[i] == "":
				break
			else:
				d = clock_in_details[i].split(":")
				temp.append(d)
		sql['clock_in_details'] = temp

		return sql

	def dailyPracticeAssignment(self,user_id,assignment_id):
		print "user_id=", user_id
		print "assignment_id=", assignment_id
		mysql = MySQL()
		sql = {}
		fields = "subject_id,practice_ids,done_sum,assignment_name,question_sum,today_clock_in_sum,user_ids"
		listfields = fields.split(",")
		query = "SELECT " + fields + " FROM `daily_practice_assignment` WHERE id=" + str(assignment_id)
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]
		practice_ids = sql['practice_ids'].split(",")[:-1]
		sql['practice_ids'] = practice_ids
		user_ids = sql['user_ids'].split(",")[:-1]
		user_ids.reverse()
		sql['user_ids'] = user_ids

		fields_user = "answer_question_sum,is_done"
		listfields_user = fields_user.split(",")
		query_user = "SELECT " + fields_user + " FROM `daily_practice_user_details` WHERE user_id=" + str(user_id) + " AND daily_practice_assignment_id=" + str(assignment_id)
		result_user = mysql.getFistRow(query_user)
		for i in range(len(result_user)):
			sql[listfields_user[i]] = result_user[i]
		is_done = ord(sql['is_done'])
		sql['is_done'] = is_done
		return sql


	def chapter(self,user_id):
		print "user_id=", user_id
		mysql = MySQL()
		sql = {}
		fields = "exam_type_id,subject_id"
		listfields = fields.split(",")
		query = "SELECT " + fields + " FROM relation_user_exam_type WHERE del_flag=0 AND current=1 AND user_id=" + str(
			user_id)
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]

		fields_chapter = "id,chapter_number,chapter_name,done_sum,question_sum"
		listfields_chapter = fields_chapter.split(",")
		query_chapter = "SELECT " + fields_chapter + " FROM `chapter` WHERE del_flag=0 AND subject_id=" + str(sql['subject_id'])
		result_chapter = mysql.getAllRow(query_chapter)
		for i in range(len(result_chapter)):
			sql[listfields_chapter[i]] = result_chapter[i]

		fields_chapter_plan = "question_ids,schedule,step_sum,complete_question_sum,wrong_question_sum"
		listfields_chapter_plan = fields_chapter_plan.split(",")
		for key in listfields_chapter_plan:
			sql[key] = []
		for chapter_id in sql['id']:
			query_chapter_plan = "SELECT " + fields_chapter_plan + " FROM `chapter_practice_plan` WHERE user_id="+str(user_id)+" AND chapter_id=" + str(chapter_id)
			result_chapter_plan = mysql.getFistRow(query_chapter_plan)
			for i in range(len(result_chapter_plan)):
				if i==0:
					question_ids = result_chapter_plan[0].split(",")
					n1 = len(question_ids)
					n2 = n1 / 10
					temp = []
					for n in range(n2):
						ids = []
						for j in range(10):
							k = 10*n+j
							ids.append(question_ids[k])
						str_convert = ','.join(ids)
						result_ids = mysql.getAllRow("SELECT id FROM `exam_question`WHERE id in (" + str_convert + ") ORDER BY question_number")
						temp += result_ids[0]

					if n1%10>0:
						n3 = n1%10
						ids = []
						for n in range(n3):
							k = n2*10+n
							ids.append(question_ids[k])
						str_convert = ','.join(ids)
						result_ids = mysql.getAllRow(
							"SELECT id FROM `exam_question`WHERE id in (" + str_convert + ") ORDER BY question_number")
						temp += result_ids[0]
					result_chapter_plan[i] = temp
				sql[listfields_chapter_plan[i]].append(result_chapter_plan[i])

		fields_collection = "exam_question_id,modifi_date"
		listfields_collection = fields_collection.split(",")
		query_collection = "SELECT " + fields_collection + " FROM `collection_question` WHERE del_flag=0 AND user_id=" + str(user_id) + " ORDER BY modifi_date desc"
		result_collection = mysql.getAllRow(query_collection)
		for i in range(len(result_collection)):
			sql[listfields_collection[i]] = result_collection[i]

		exam_question_id = []
		modifi_date = []
		collection_sum = []
		for question_ids in sql['question_ids']:
			sum = 0
			exam_question_id_1 = []
			modifi_date_1 = []
			for i in range(len(sql['exam_question_id'])) :
				question_id = sql['exam_question_id'][i]
				if question_id in question_ids:
					sum += 1
					exam_question_id_1.append(question_id)
					modifi_date_1.append(Function().convertTimestamp(str(sql['modifi_date'][i])))
			exam_question_id.append(exam_question_id_1)
			modifi_date.append(modifi_date_1)
			collection_sum.append(sum)

		sql['exam_question_id'] = exam_question_id
		sql['modifi_date'] = modifi_date
		sql['collection_sum'] = collection_sum

		return sql

	def lastUserQuestion(self,user_id,chapter_id,question_id=0):
		print "user_id=", user_id
		print "chapter_id=", chapter_id
		print "question_id=", question_id
		mysql = MySQL()
		sql = {}
		if question_id==0:
			fields = "question_id"
			query_only = "SELECT " + fields + " FROM `last_user_question` AS l,`exam_question` AS q  WHERE q.id=l.question_id AND l.answer_correct=0 AND l.user_id=" + str(
				user_id) + " AND l.chapter_id=" + str(chapter_id) +" ORDER BY l.error_num DESC,q.question_number"

			query_my = "SELECT " + fields + " FROM `last_user_question` WHERE answer_correct=0 AND user_id=" + str(
				user_id) + " AND chapter_id=" + str(chapter_id) + " ORDER BY error_num DESC"
			result_only = mysql.getAllRow(query_only)
			result_my = mysql.getAllRow(query_my)
			count = mysql.getRowCount(query_only)
			if result_my=="":
				pass
			else:
				sql['question_id_only'] = result_only[0]
				sql['question_id_my'] = result_my[0]
			sql['errorSum'] = count
		else:
			fields = "answer_correct,answer_desc,error_num,done_sum"
			listfields = fields.split(",")
			query = "SELECT " + fields + " FROM `last_user_question` WHERE user_id=" + str(
				user_id) + " AND chapter_id=" + str(chapter_id) + " AND question_id="+ str(question_id)
			result = mysql.getFistRow(query)
			for i in range(len(result)):
				if i == 0:
					sql[listfields[i]] = ord(result[0])
				else:
					sql[listfields[i]] = result[i]
		return sql

	def examPapers(self,user_id):
		print "user_id=", user_id
		mysql = MySQL()
		sql = {}
		fields = "exam_type_id,subject_id"
		listfields = fields.split(",")
		query = "SELECT " + fields + " FROM relation_user_exam_type WHERE del_flag=0 AND current=1 AND user_id=" + str(
			user_id)
		result = mysql.getFistRow(query)
		for i in range(len(result)):
			sql[listfields[i]] = result[i]

		fields_paper = "id,done_sum,exam_paper_name,type,year,question_sum,score_sum"
		listfields_paper = fields_paper.split(",")
		query_paper = "SELECT " + fields_paper + " FROM `exam_paper` WHERE del_flag=0 AND subject_id=" + str(sql['subject_id']) + " ORDER BY `year` DESC"
		result_paper = mysql.getAllRow(query_paper)
		for i in range(len(result_paper)):
			sql[listfields_paper[i]] = result_paper[i]

		isDone = []
		questonIds = []
		for exam_paper_id in sql['id']:
			query_id = "SELECT * FROM `relation_user_exam_paper` WHERE exam_paper_id=" + str(exam_paper_id) +" AND user_id=" + str(user_id)
			result_id = mysql.getRowCount(query_id)
			isDone.append(result_id)

			query_ques = "SELECT id,question_desc FROM exam_question WHERE del_flag=0 AND id in (SELECT exam_question_id FROM `relation_exam_paper_question` WHERE exam_paper_id=" + str(exam_paper_id) + ") ORDER BY question_number"
			result_ques = mysql.getAllRow(query_ques)
			questonIds.append(result_ques[0])
		sql["isDone"] = isDone
		sql["questonIds"] = questonIds

		fields_collection = "exam_question_id"
		listfields_collection = fields_collection.split(",")
		query_collection = "SELECT " + fields_collection + " FROM `collection_question` WHERE del_flag=0 AND user_id=" + str(user_id)
		result_collection = mysql.getAllRow(query_collection)
		for i in range(len(result_collection)):
			sql[listfields_collection[i]] = result_collection[i]

		fields_answer = "create_date,id,answer_plan_id,duration,answer_sum,exam_paper_id,score"
		listfields_answer = fields_answer.split(",")
		listfields_answer[0] = "create_date"
		query_answer = "SELECT " + fields_answer + " FROM `user_answer` WHERE id IN (SELECT id FROM (SELECT MAX(id) id,exam_paper_id FROM `user_answer` WHERE plan_type='SIMULATION_EXAM' AND user_id=" + str(
			user_id) + " AND exam_paper_id in( SELECT id FROM `exam_paper` WHERE del_flag=0 AND subject_id="+ str(sql['subject_id'])+") GROUP BY exam_paper_id ) as a) ORDER BY id DESC"
		result_answer = mysql.getAllRow(query_answer)
		sql['history'] = {}
		if result_answer == "":
			pass
		else:
			for i in range(len(result_answer)):
				result_answer[i]
				if i==0:
					for j in range(len(result_answer[i])):
						result_answer[0][j] = Function().convertTimestamp(str(result_answer[0][j]))
				sql['history'][listfields_answer[i]]= result_answer[i]
			sql['history']['exam_paper_name'] = []
			for exam_paper_id in sql['history']['exam_paper_id']:
				query_name = "SELECT exam_paper_name FROM `exam_paper` WHERE id=" + str(exam_paper_id)
				result_name = mysql.getFistRow(query_name)
				sql['history']['exam_paper_name'].append(result_name[0])
		return sql


if __name__ == '__main__':
	# aa = GetSQL().lastUserQuestion(3,248363)
	aa = GetSQL().question(14934)
	print aa



