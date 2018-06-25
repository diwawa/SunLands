*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/answerPlans
	[Arguments]    ${token}
	[Documentation]    个人答题计划生成确认
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /answerPlans    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


