*** Settings ***
Force Tags        DocTest    PushMessage
Library           ../../Lib/JsonRead.py
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
post/pushMessage/formid
	[Documentation]    模版消息
	[Tags]    Run
	${params}    getParam_data    PushMessage    post/pushMessage/formid
	${resp}    getApiResp    ${token}    post    /pushMessage/formid    ${params['pushWechatTemplateParam']}
	${result}    docmentAssert    post    /pushMessage/formid    ${resp}
	should be true     ${result[0]}     ${result}

