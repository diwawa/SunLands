*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
post/questionTypes/next
	[Arguments]    ${token}    ${planType}    ${chapterId}
	[Documentation]    题目下一阶段
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    planType    ${planType}    chapterId    ${chapterId}    
	${resp}    post request    exam    /questionTypes/next    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


get/questionTypes/examQuestion
	[Arguments]    ${token}    ${planType}    ${needAnswer}    ${needHistory}    ${needError}    ${stratumId}
	[Documentation]    题目详情 (8种类型)
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    planType    ${planType}    needAnswer    ${needAnswer}    needHistory    ${needHistory}    needError    ${needError}    stratumId    ${stratumId}    
	${resp}    get request    exam    /questionTypes/examQuestion    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/questionTypes/examPapers/history
	[Arguments]    ${token}
	[Documentation]    套卷模拟历史纪录
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /questionTypes/examPapers/history    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/questionTypes/myQuestionStem/{chapterId}
	[Arguments]    ${token}    ${chapterId}    ${planType}
	[Documentation]    我的收藏列表/我的错题列表
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    planType    ${planType}    
	${resp}    get request    exam    /questionTypes/myQuestionStem/${chapterId}    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/questionTypes/chapters
	[Arguments]    ${token}    ${planType}
	[Documentation]    章节列表 （章节练习/只做错题/我的收藏/我的错题）
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    planType    ${planType}    
	${resp}    get request    exam    /questionTypes/chapters    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/questionTypes/examPapers
	[Arguments]    ${token}
	[Documentation]    套卷模拟列表
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /questionTypes/examPapers    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


