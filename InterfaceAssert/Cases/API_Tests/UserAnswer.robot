*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/UserAnswer.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/UserAnswer.py
Variables         ../../Datas/Response/UserAnswer.py


*** Test Cases ***
userAnswer_userAnswerId
	[Documentation]    获取判题信息,历史答题记录: 在QuestionType中执行
	[Tags]    NotRun
	${resp}    get/userAnswer/{userAnswerId}    ${token}    ${userAnswer_userAnswerId_param['userAnswerId']}    ${userAnswer_userAnswerId_param['infoType']}
	${result}    compareResp    ${userAnswer_userAnswerId_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${userAnswer_userAnswerId_resp['levelView'][0]}    ${resp['levelView'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${userAnswer_userAnswerId_resp['questions'][0]}    ${resp['questions'][0]}
	Should Be True    ${result['status']}    ${result}

userAnswer
	[Documentation]    判题请求: 在QuestionType中执行
	[Tags]    NotRun
	${resp}    post/userAnswer    ${token}    ${userAnswer_param['userAnswerPostParam']}
	${result}    compareResp    ${userAnswer_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

