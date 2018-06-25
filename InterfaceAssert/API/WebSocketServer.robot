*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/webSocketServer/pk
	[Arguments]    ${token}
	[Documentation]    pk在线状态，等待匹配对手
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /webSocketServer/pk    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


