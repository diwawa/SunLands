*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/userAnswer/{userAnswerId}
	[Arguments]    ${token}    ${userAnswerId}    ${infoType}
	[Documentation]    获取判题信息,历史答题记录
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    infoType    ${infoType}    
	${resp}    get request    exam    /userAnswer/${userAnswerId}    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/userAnswer
	[Arguments]    ${token}    ${userAnswerPostParam}
	[Documentation]    判题请求
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    set variable    ${userAnswerPostParam}    
	${resp}    post request    exam    /userAnswer    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


