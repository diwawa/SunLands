*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/examTypes
	[Arguments]    ${token}
	[Documentation]    查询考试类型列表
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /examTypes    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


