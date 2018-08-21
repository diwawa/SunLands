*** Settings ***
Force Tags        DocTest    LEARN
Library           ../../Lib/JsonRead.py
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
get/learnTask/getSingleTask
	[Documentation]    查询单科任务进度
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /learnTask/getSingleTask
	${result}    docmentAssert    get    /learnTask/getSingleTask    ${resp}
	should be true     ${result[0]}     ${result}

get/learnTask/getDayTask
	[Documentation]    查询每日学习计划
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /learnTask/getDayTask
	${result}    docmentAssert    get    /learnTask/getDayTask    ${resp}
	should be true     ${result[0]}     ${result}

get/learnTask/getTotalTask
	[Documentation]    查询总任务进度
	[Tags]    Run
	${params}    getParam_data    LEARN    get/learnTask/getTotalTask
	${resp}    getApiResp    ${token}    get    /learnTask/getTotalTask    ${params}
	${result}    docmentAssert    get    /learnTask/getTotalTask    ${resp}
	should be true     ${result[0]}     ${result}

