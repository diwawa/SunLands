*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/subjects
	[Arguments]    ${token}    ${examTypeId}
	[Documentation]    根据考试类型id查询科目列表
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    examTypeId    ${examTypeId}    
	${resp}    get request    exam    /subjects    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


