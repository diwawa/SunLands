*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/activity
	[Arguments]    ${token}
	[Documentation]    活动列表
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/APM/ranking
	[Arguments]    ${token}
	[Documentation]    小心心手速排行榜
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity/APM/ranking    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/decodeUserInfo
	[Arguments]    ${token}    ${code}    ${encryptedData}    ${iv}    ${type}
	[Documentation]    微信授权获取手机号
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    code    ${code}    encryptedData    ${encryptedData}    iv    ${iv}    type    ${type}    
	${resp}    get request    exam    /activity/decodeUserInfo    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/details
	[Arguments]    ${token}    ${mark}
	[Documentation]    拼团详情页
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    mark    ${mark}    
	${resp}    get request    exam    /activity/details    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/draw/details
	[Arguments]    ${token}
	[Documentation]    抽签页面详情
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity/draw/details    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/activity/draw/help
	[Arguments]    ${token}    ${mark}
	[Documentation]    好友助力
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    mark    ${mark}    
	${resp}    post request    exam    /activity/draw/help    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/activity/draw/join
	[Arguments]    ${token}    ${DrawType}
	[Documentation]    抽签结果上报
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    DrawType    ${DrawType}    
	${resp}    post request    exam    /activity/draw/join    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/draw/shareUser
	[Arguments]    ${token}    ${mark}
	[Documentation]    分享用户详情
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    mark    ${mark}    
	${resp}    get request    exam    /activity/draw/shareUser    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/goods
	[Arguments]    ${token}    ${phoneNumber}
	[Documentation]    拼团成功详情页
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    phoneNumber    ${phoneNumber}    
	${resp}    get request    exam    /activity/goods    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/activity/join
	[Arguments]    ${token}
	[Documentation]    发起拼团
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${resp}    post request    exam    /activity/join    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/pointQuestion/final
	[Arguments]    ${token}    ${sum}
	[Documentation]    小心心提交点击次数，返回数据
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    sum    ${sum}
	${resp}    get request    exam    /activity/pointQuestion/final    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/pointQuestion/home
	[Arguments]    ${token}    ${shareMark}
	[Documentation]    小心心首页
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    shareMark    ${shareMark}    
	${resp}    get request    exam    /activity/pointQuestion/home    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/push
	[Arguments]    ${token}
	[Documentation]    活动推送消息
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity/push    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/valentines/details
	[Arguments]    ${token}
	[Documentation]    配对成功活动详情
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity/valentines/details    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/activity/valentines/form
	[Arguments]    ${token}    ${selfSex}    ${hopeSex}
	[Documentation]    配对活动表单上传
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    selfSex    ${selfSex}    hopeSex    ${hopeSex}    
	${resp}    post request    exam    /activity/valentines/form    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


get/activity/valentines/ranking
	[Arguments]    ${token}
	[Documentation]    配对活动排行榜
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity/valentines/ranking    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/worldCup/barrage
	[Arguments]    ${token}
	[Documentation]    弹幕
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity/worldCup/barrage    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/worldCup/cancelMatch
	[Arguments]    ${token}
	[Documentation]    取消匹配
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity/worldCup/cancelMatch    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/activity/worldCup/invite
	[Arguments]    ${token}    ${selfSex}
	[Documentation]    世界杯配对活动邀请匹配
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    selfSex    ${selfSex}    
	${resp}    post request    exam    /activity/worldCup/invite    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/activity/worldCup/join
	[Arguments]    ${token}    ${mark}
	[Documentation]    加入好友邀请
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${params}    Create Dictionary    mark    ${mark}    
	${resp}    post request    exam    /activity/worldCup/join    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/activity/worldCup/kickOut
	[Arguments]    ${token}
	[Documentation]    踢队友
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${resp}    post request    exam    /activity/worldCup/kickOut    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


get/activity/worldCup/match
	[Arguments]    ${token}    ${selfSex}
	[Documentation]    世界杯配对活动随机匹配
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    selfSex    ${selfSex}    
	${resp}    get request    exam    /activity/worldCup/match    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/worldCup/peopleSum
	[Arguments]    ${token}
	[Documentation]    参与人数
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity/worldCup/peopleSum    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/worldCup/ranking
	[Arguments]    ${token}
	[Documentation]    世界杯配对活动排行榜
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity/worldCup/ranking    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/activity/worldCup/remindTeammates
	[Arguments]    ${token}
	[Documentation]    提醒队友
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
	${resp}    post request    exam    /activity/worldCup/remindTeammates    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


get/activity/worldCup/share
	[Arguments]    ${token}    ${mark}
	[Documentation]    世界杯配对活动点击气泡详情
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    mark    ${mark}    
	${resp}    get request    exam    /activity/worldCup/share    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/worldCup/teamDetails
	[Arguments]    ${token}    ${teamId}
	[Documentation]    世界配对成功活动详情
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    teamId    ${teamId}    
	${resp}    get request    exam    /activity/worldCup/teamDetails    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


get/activity/worldCup/userDetails
	[Arguments]    ${token}
	[Documentation]    世界配对成功活动详情
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${resp}    get request    exam    /activity/worldCup/userDetails    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


