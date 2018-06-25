*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/ranking/pkArena
	[Arguments]    ${token}    ${filter}
	[Documentation]    排行榜-pk场
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    filter    ${filter}    
	${resp}    get request    exam    /ranking/pkArena    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/ranking/persional
	[Arguments]    ${token}    ${filter}
	[Documentation]    排行榜-个人
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    filter    ${filter}    
	${resp}    get request    exam    /ranking/persional    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/ranking/provice/list
	[Arguments]    ${token}
	[Documentation]    排名-省份目录
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /ranking/provice/list    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


