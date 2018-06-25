*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/dailyPractice/examPapers
	[Arguments]    ${token}    ${year}    ${month}    ${number}
	[Documentation]    每日一练任务列表
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    year    ${year}    month    ${month}    number    ${number}    
	${resp}    get request    exam    /dailyPractice/examPapers    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/dailyPractice/calendar
	[Arguments]    ${token}    ${year}    ${month}
	[Documentation]    每日一练日历
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    year    ${year}    month    ${month}    
	${resp}    get request    exam    /dailyPractice/calendar    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/dailyPractice/userClockIn
	[Arguments]    ${token}
	[Documentation]    今日打卡
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${resp}    post request    exam    /dailyPractice/userClockIn    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/dailyPractice/clockInSum
	[Arguments]    ${token}
	[Documentation]    打卡总数
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /dailyPractice/clockInSum    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


