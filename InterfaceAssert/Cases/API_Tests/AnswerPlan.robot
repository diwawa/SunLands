*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/AnswerPlan.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/AnswerPlan.py
Variables         ../../Datas/Response/AnswerPlan.py


*** Test Cases ***
answerPlans
	[Documentation]    个人答题计划生成确认  : 在QuestionType中执行
	[Tags]    NotRun
	${resp}    get/answerPlans    ${token}
	${result}    compareResp    ${answerPlans_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

