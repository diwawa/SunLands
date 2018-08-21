*** Settings ***
Force Tags        DocTest    LearningPlan
Library           ../../Lib/JsonRead.py
Library           Collections
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
get/learningPlan/provinces
	[Documentation]    学习计划省份列表
	[Tags]    Run
	${params}    getParam_data    LearningPlan    get/learningPlan/provinces
	${resp}    getApiResp    ${token}    get    /learningPlan/provinces    ${params}
	${result}    docmentAssert    get    /learningPlan/provinces    ${resp}
	should be true     ${result[0]}     ${result}

get/learningPlan/examTimes
	[Documentation]    考试时间列表
	[Tags]    Run
	${params}    getParam_data    LearningPlan    get/learningPlan/examTimes
	${resp}    getApiResp    ${token}    get    /learningPlan/examTimes    ${params}
	${result}    docmentAssert    get    /learningPlan/examTimes    ${resp}
	should be true     ${result[0]}     ${result}

get/learningPlan/dailyPlanQuestions
	[Documentation]    根据课程动态查询问题信息
	[Tags]    Run
	${params}    getParam_data    LearningPlan    get/learningPlan/dailyPlanQuestions
	${resp}    getApiResp    ${token}    get    /learningPlan/dailyPlanQuestions    ${params}
	${result}    docmentAssert    get    /learningPlan/dailyPlanQuestions    ${resp}
	should be true     ${result[0]}     ${result}

post/learningPlan
	[Documentation]    创建学习计划
	[Tags]    NotRun
	${params}    getParam_data    LearningPlan    post/learningPlan
	${resp}    getApiResp    ${token}    post    /learningPlan    ${params['learningPlanParam']}
	${result}    docmentAssert    post    /learningPlan    ${resp}
	should be true     ${result[0]}     ${result}

get/learningPlan/dailyCoin
	[Documentation]    个人学习计划可获得的最大青豆数量
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /learningPlan/dailyCoin
	${result}    docmentAssert    get    /learningPlan/dailyCoin    ${resp}
	should be true     ${result[0]}     ${result}

get/learningPlan/info
	[Documentation]    查看学习计划
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /learningPlan/info
	set suite variable      ${learningPlanId}     ${resp['id']}
	${result}    docmentAssert    get    /learningPlan/info    ${resp}
	should be true     ${result[0]}     ${result}

put/learningPlan/update
	[Documentation]    修改学习计划
	[Tags]    Run
	${params}    getParam_data    LearningPlan    put/learningPlan/update
    set to dictionary    ${params['learningPlanParam']}    learningPlanId    ${learningPlanId}
	${resp}    getApiResp    ${token}    put    /learningPlan/update    ${params['learningPlanParam']}
	${result}    docmentAssert    put    /learningPlan/update    ${resp}
	should be true     ${result[0]}     ${result}

get/learningPlan/progress
	[Documentation]    查看个人学习计划执行情况
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /learningPlan/progress
	${result}    docmentAssert    get    /learningPlan/progress    ${resp}
	should be true     ${result[0]}     ${result}


