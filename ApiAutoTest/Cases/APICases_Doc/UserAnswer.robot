*** Settings ***
Force Tags        DocTest    UserAnswer
Library           ../../Lib/JsonRead.py
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
post/userAnswer
	[Documentation]    判题请求，DailyPractice用例执行
	[Tags]    NotRun
	${params}    getParam_data    UserAnswer    post/userAnswer
	${resp}    getApiResp    ${token}    post    /userAnswer    ${params}
	${result}    docmentAssert    post    /userAnswer    ${resp}
	should be true     ${result[0]}     ${result}

get/userAnswer/{userAnswerId}
	[Documentation]    获取判题信息,历史答题记录
	[Tags]    Run
	${params}    getParam_data    UserAnswer    get/userAnswer/{userAnswerId}
	${resp}    getApiResp    ${token}    get    /userAnswer/{userAnswerId}    ${params}
	${result}    docmentAssert    get    /userAnswer/{userAnswerId}    ${resp}
	should be true     ${result[0]}     ${result}

