*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
post/users/unchainPaper
	[Arguments]    ${token}    ${userCodeView}
	[Documentation]    授权解锁 模拟试卷
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    set variable    ${userCodeView}    
	${resp}    post request    exam    /users/unchainPaper    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


get/users/home
	[Arguments]    ${token}
	[Documentation]    欢迎页详情
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /users/home    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/users/survey
	[Arguments]    ${token}    ${userSurveyView}
	[Documentation]    用户测试数据提交
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    set variable    ${userSurveyView}    
	${resp}    post request    exam    /users/survey    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/users/me
	[Arguments]    ${token}    ${lat}    ${lon}
	[Documentation]    首页我的详情
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    lat    ${lat}    lon    ${lon}    
	${resp}    get request    exam    /users/me    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/users/share
	[Arguments]    ${token}    ${shareType}    ${pkLogId}
	[Documentation]    小程序分享
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    shareType    ${shareType}    pkLogId    ${pkLogId}    
	${resp}    get request    exam    /users/share    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


put/users/examTypes
	[Arguments]    ${token}    ${examTypeId}    ${recomment}
	[Documentation]    修改用户考试类型
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    examTypeId    ${examTypeId}    recomment    ${recomment}    
	${resp}    put request    exam    /users/examTypes    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


get/users/push
	[Arguments]    ${token}
	[Documentation]    首页推送消息集合
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /users/push    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/users/me/info
	[Arguments]    ${token}    ${mark}
	[Documentation]    我的数据
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    mark    ${mark}    
	${resp}    get request    exam    /users/me/info    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/users/advice
	[Arguments]    ${token}    ${content}    ${userIp}
	[Documentation]    用户意见反馈
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    content    ${content}    userIp    ${userIp}    
	${resp}    post request    exam    /users/advice    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


post/users/conllects/{questionId}
	[Arguments]    ${token}    ${questionId}
	[Documentation]    用户收藏
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    
	${resp}    post request    exam    /users/conllects/${questionId}    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


get/users/token/refresh
	[Arguments]    ${token}    ${token}    ${refreshToken}
	[Documentation]    换取新的尚德token对
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    token    ${token}    refreshToken    ${refreshToken}    
	${resp}    get request    exam    /users/token/refresh    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/users/token
	[Arguments]    ${token}    ${code}    ${encryptedData}    ${iv}
	[Documentation]    微信登陆获取尚德token对
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    code    ${code}    encryptedData    ${encryptedData}    iv    ${iv}    
	${resp}    get request    exam    /users/token    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/users/examPapers
	[Arguments]    ${token}
	[Documentation]    首页试卷列表
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /users/examPapers    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


put/users/subjects
	[Arguments]    ${token}    ${subjectId}
	[Documentation]    修改用户科目
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    subjectId    ${subjectId}    
	${resp}    put request    exam    /users/subjects    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


get/users/posters
	[Arguments]    ${token}    ${writingsType}
	[Documentation]    用户打卡图片集
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    writingsType    ${writingsType}    
	${resp}    get request    exam    /users/posters    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/users/support
	[Arguments]    ${token}
	[Documentation]    题库数据支持
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /users/support    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


