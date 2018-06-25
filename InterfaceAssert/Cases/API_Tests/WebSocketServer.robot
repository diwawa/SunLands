*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/WebSocketServer.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/WebSocketServer.py
Variables         ../../Datas/Response/WebSocketServer.py


*** Test Cases ***
webSocketServer_pk
	[Documentation]    pk在线状态，等待匹配对手：后台自用
	[Tags]    NotRun
	${resp}    get/webSocketServer/pk    ${token}
	${result}    compareResp    ${webSocketServer_pk_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

