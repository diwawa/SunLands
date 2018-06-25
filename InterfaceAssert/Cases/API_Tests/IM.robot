*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/IM.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/IM.py
Variables         ../../Datas/Response/IM.py


*** Test Cases ***
commodity_api_v1_IM_join
	[Documentation]    聊天室加入
	[Tags]    Run
	${resp}    post/commodity/api/v1/IM/join    ${token}    ${commodity_api_v1_IM_join_param['imId']}
	${result}    compareResp    ${commodity_api_v1_IM_join_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

commodity_api_v1_IM_quit
	[Documentation]    聊天室退出
	[Tags]    Run
	${resp}    post/commodity/api/v1/IM/quit    ${token}    ${commodity_api_v1_IM_quit_param['imId']}
	should be equal as strings    ${resp}    ${commodity_api_v1_IM_quit_resp}

