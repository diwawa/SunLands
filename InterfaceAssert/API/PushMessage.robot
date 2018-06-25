*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
post/pushMessage/formid
	[Arguments]    ${token}    ${pushWechatTemplateParam}
	[Documentation]    模版消息
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    set variable    ${pushWechatTemplateParam}    
	${resp}    post request    exam    /pushMessage/formid    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


