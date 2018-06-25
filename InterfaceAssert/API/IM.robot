*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
post/commodity/api/v1/IM/join
	[Arguments]    ${token}    ${imId}
	[Documentation]    聊天室加入
	Create Session    exam    https://exam.zmgongzuoshi.top
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    imId    ${imId}    
	${resp}    post request    exam    /commodity/api/v1/IM/join    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/commodity/api/v1/IM/quit
	[Arguments]    ${token}    ${imId}
	[Documentation]    聊天室退出
	Create Session    exam    https://exam.zmgongzuoshi.top
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    imId    ${imId}    
	${resp}    post request    exam    /commodity/api/v1/IM/quit    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


