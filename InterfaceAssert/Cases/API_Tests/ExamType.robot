*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/ExamType.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/ExamType.py
Variables         ../../Datas/Response/ExamType.py


*** Test Cases ***
examTypes
	[Documentation]    查询考试类型列表
	[Tags]    Run
	${resp}    get/examTypes    ${token}
	${result}    compareResp    ${examTypes_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${examTypes_resp['item'][0]}    ${resp['item'][0]}
	Should Be True    ${result['status']}    ${result}

