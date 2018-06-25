*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/userClockInRecord
	[Arguments]    ${token}    ${userId}    ${month}
	[Documentation]    打卡记录
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    userId    ${userId}    month    ${month}    
	${resp}    get request    exam    /userClockInRecord    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/userClockIn
	[Arguments]    ${token}    ${userId}
	[Documentation]    每日打卡
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    userId    ${userId}    
	${resp}    post request    exam    /userClockIn    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


