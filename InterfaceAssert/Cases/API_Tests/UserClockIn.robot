*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/UserClockIn.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/UserClockIn.py
Variables         ../../Datas/Response/UserClockIn.py


*** Test Cases ***
userClockInRecord
	[Documentation]    打卡记录：已废弃
	[Tags]    NotRun
	${resp}    get/userClockInRecord    ${token}    ${userClockInRecord_param['userId']}    ${userClockInRecord_param['month']}
	${result}    compareResp    ${userClockInRecord_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

userClockIn
	[Documentation]    每日打卡：已废弃
	[Tags]    NotRun
	${resp}    post/userClockIn    ${token}    ${userClockIn_param['userId']}
	should be equal as strings    ${resp}    ${userClockIn_resp}

