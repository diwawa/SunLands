*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/PushMessage.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/PushMessage.py
Variables         ../../Datas/Response/PushMessage.py


*** Test Cases ***
pushMessage_formid
	[Documentation]    模版消息 ：参数formId不确定
	[Tags]    Run
	${resp}    post/pushMessage/formid    ${token}    ${pushMessage_formid_param['pushWechatTemplateParam']}
	should be equal as strings    ${resp}    ${pushMessage_formid_resp}

