*** Settings ***
Force Tags        DocTest    DailyPractice
Library           ../../Lib/JsonRead.py
Library           Collections
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
get/dailyPractice/calendar
	[Documentation]    每日一练日历
	[Tags]    Run
	${params}    getParam_data    DailyPractice    get/dailyPractice/calendar
	${resp}    getApiResp    ${token}    get    /dailyPractice/calendar    ${params}
	${result}    docmentAssert    get    /dailyPractice/calendar    ${resp}
	should be true     ${result[0]}     ${result}

get/dailyPractice/examPapers
	[Documentation]    每日一练任务列表
	[Tags]    Run
	${params}    getParam_data    DailyPractice    get/dailyPractice/examPapers
	${yyyy}    ${mm}     ${dd}    Get Time    year,month,day
	set to dictionary    ${params}    year    ${yyyy}
	set to dictionary    ${params}    month    ${mm}
	set to dictionary    ${params}    number    ${dd}
	${resp}    getApiResp    ${token}    get    /dailyPractice/examPapers    ${params}
	set suite variable      ${clockIn}    ${resp['clockIn']}
	set suite variable      ${assignmentId}    ${resp['assignmentList'][0]['assignmentId']}
	set suite variable      ${current}    ${resp['assignmentList'][0]['current']}
	set suite variable      ${total}    ${resp['assignmentList'][0]['total']}
	${result}    docmentAssert    get    /dailyPractice/examPapers    ${resp}
	should be true     ${result[0]}     ${result}

getQuestionList
	[Documentation]    题目详情 (8种类型)
	[Tags]    Run
	${params}    getParam_data    DailyPractice    getQuestionList
	set to dictionary      ${params}    stratumId    ${assignmentId}
	${resp}    getApiResp    ${token}    get    /questionTypes/examQuestion    ${params}
	set suite variable      ${questionlist}    ${resp}

userAnswer
	[Documentation]    判题请求
	[Tags]    Run
	pass execution if     ${current}==${total}    题已经答过了
	${params}    getParam_data    DailyPractice    userAnswer
	${params}    copy dictionary    ${params['userAnswerPostParam']}
	set to dictionary      ${params}    assignmentId    ${assignmentId}
	${resp}    getApiResp    ${token}    get    /answerPlans
	set to dictionary      ${params}    answerPlanId    ${resp['answerPlanId']}
	:For    ${x}    In Range    ${total}
	\     ${questionid}    set variable     ${questionlist[${x}]['questionId']}
	\     set to dictionary      ${params['questions'][${x}]}    questionId    ${questionid}
	\     ${num}    evaluate      int(${x})+1
	\     exit for loop if      ${num}==${total}
	\     ${question0}    copy dictionary     ${params['questions'][0]}
	\     insert into list      ${params['questions']}    ${num}    ${question0}
	${resp}    getApiResp    ${token}    post    /userAnswer    ${params}
	${result}    docmentAssert    post    /userAnswer    ${resp}
	should be true     ${result[0]}     ${result}

post/dailyPractice/userClockIn
	[Documentation]    今日打卡
	[Tags]    Run
	${resp}    getApiResp    ${token}    post    /dailyPractice/userClockIn
	${result}    docmentAssert    post    /dailyPractice/userClockIn    ${resp}
	should be true     ${result[0]}     ${result}

get/dailyPractice/clockInSum
	[Documentation]    打卡总数
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /dailyPractice/clockInSum
	${result}    docmentAssert    get    /dailyPractice/clockInSum    ${resp}
	should be true     ${result[0]}     ${result}

