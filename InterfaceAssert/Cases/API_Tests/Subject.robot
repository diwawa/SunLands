*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/Subject.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/Subject.py
Variables         ../../Datas/Response/Subject.py


*** Test Cases ***
subjects
	[Documentation]    根据考试类型id查询科目列表
	[Tags]    Run
	${resp}    get/subjects    ${token}    ${subjects_param['examTypeId']}
	${result}    compareResp    ${subjects_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${subjects_resp[0]}    ${resp[0]}
	Should Be True    ${result['status']}    ${result}
