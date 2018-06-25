*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/pkArena/pkFinal/share
	[Arguments]    ${token}    ${shareMark}
	[Documentation]    pk结果分享
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    shareMark    ${shareMark}    
	${resp}    get request    exam    /pkArena/pkFinal/share    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/pkArena/target
	[Arguments]    ${token}
	[Documentation]    进入pk场,显示对方用户信息
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /pkArena/target    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/pkArena/pkDynamicImg/{userId}/{pkLogId}
	[Arguments]    ${token}    ${userId}    ${pkLogId}
	[Documentation]    pk结果动态图片
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    
	${resp}    get request    exam    /pkArena/pkDynamicImg/${userId}/${pkLogId}    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


get/pkArena/targetAnswerDetail
	[Arguments]    ${token}    ${pkLogId}    ${questionId}
	[Documentation]    查询对手答题详情
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    pkLogId    ${pkLogId}    questionId    ${questionId}    
	${resp}    get request    exam    /pkArena/targetAnswerDetail    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/pkArena/pkAnswer
	[Arguments]    ${token}    ${pkAnswerPostParam}
	[Documentation]    提交答案
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    set variable    ${pkAnswerPostParam}    
	${resp}    post request    exam    /pkArena/pkAnswer    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/pkArena/quit
	[Arguments]    ${token}    ${pkLogId}
	[Documentation]    pk场
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    pkLogId    ${pkLogId}    
	${resp}    post request    exam    /pkArena/quit    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/pkArena/join
	[Arguments]    ${token}    ${shareMark}
	[Documentation]    好友对战，加入pk场
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    shareMark    ${shareMark}    
	${resp}    post request    exam    /pkArena/join    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/pkArena/pkFinal
	[Arguments]    ${token}    ${pkLogId}
	[Documentation]    pk结果
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    pkLogId    ${pkLogId}    
	${resp}    get request    exam    /pkArena/pkFinal    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/pkArena/danGradingTips
	[Arguments]    ${token}    ${pkLogId}
	[Documentation]    段位升降提示
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    pkLogId    ${pkLogId}    
	${resp}    get request    exam    /pkArena/danGradingTips    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/pkArena/pkQuestions
	[Arguments]    ${token}    ${pkLogId}    ${questionId}
	[Documentation]    查询pk场下一题信息
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    pkLogId    ${pkLogId}    questionId    ${questionId}    
	${resp}    get request    exam    /pkArena/pkQuestions    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/pkArena/me
	[Arguments]    ${token}
	[Documentation]    pk场，显示当前用户信息
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /pkArena/me    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/pkArena/pkMatch
	[Arguments]    ${token}    ${shareMark}    ${selfPlay}
	[Documentation]    匹配对手 / 点击分享链接
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    shareMark    ${shareMark}    selfPlay    ${selfPlay}    
	${resp}    get request    exam    /pkArena/pkMatch    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


