*** Settings ***
Force Tags        DocTest    PkArena
Library           ../../Lib/JsonRead.py
Library           Collections
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
get/pkArena/me
	[Documentation]    pk场，显示当前用户信息
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /pkArena/me
	set suite variable     ${shareMark}    ${resp['shareMark']}
	set suite variable     ${userId}    ${resp['userId']}
	${result}    docmentAssert    get    /pkArena/me    ${resp}
	should be true     ${result[0]}     ${result}

userShare
    [Documentation]    分享
    [Tags]  Run
    ${params}    getParam_data    PkArena    userShare
    set to dictionary    ${params}    shareMark     ${shareMark}
	getApiResp    ${token}    get    /users/share    ${params}

post/pkArena/join
	[Documentation]    好友对战，加入pk场
	[Tags]    Run
	${params}    getParam_data    PkArena    post/pkArena/join
	set to dictionary    ${params}    shareMark     ${shareMark}
	${resp}    getApiResp    ${token2}    post    /pkArena/join    ${params}
	${result}    docmentAssert    post    /pkArena/join    ${resp}
	should be true     ${result[0]}     ${result}

get/pkArena/target
	[Documentation]    进入pk场,显示对方用户信息
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /pkArena/target
	${result}    docmentAssert    get    /pkArena/target    ${resp}
	should be true     ${result[0]}     ${result}

get/pkArena/pkMatch
	[Documentation]    匹配对手 / 点击分享链接
	[Tags]    Run
	${params}    getParam_data    PkArena    get/pkArena/pkMatch
	set to dictionary    ${params}    shareMark     ${shareMark}
	${resp}    getApiResp    ${token2}    get    /pkArena/pkMatch    ${params}
	set suite variable      ${pkLogId}    ${resp['pkLogId']}
	${result}    docmentAssert    get    /pkArena/pkMatch    ${resp}
	should be true     ${result[0]}     ${result}

get/pkArena/pkQuestions
	[Documentation]    查询pk场下一题信息
	[Tags]    Run
	${params}    getParam_data    PkArena    get/pkArena/pkQuestions
	set to dictionary    ${params}    pkLogId     ${pkLogId}
	${resp}    getApiResp    ${token}    get    /pkArena/pkQuestions    ${params}
	set suite variable     ${questionId}    ${resp['questionId']}
	${result}    docmentAssert    get    /pkArena/pkQuestions    ${resp}
	should be true     ${result[0]}     ${result}

post/pkArena/pkAnswer
	[Documentation]    提交答案
	[Tags]    Run
	${params}    getParam_data    PkArena    post/pkArena/pkAnswer
	set to dictionary      ${params['pkAnswerPostParam']}    questionId    ${questionId}
	set to dictionary      ${params['pkAnswerPostParam']}    pkLogId    ${pkLogId}
	${resp}    getApiResp    ${token}    post    /pkArena/pkAnswer    ${params['pkAnswerPostParam']}
	${result}    docmentAssert    post    /pkArena/pkAnswer    ${resp}
	should be true     ${result[0]}     ${result}

post/pkArena/pkAnswer2
	[Documentation]    提交答案
	[Tags]    Run
	${params}    getParam_data    PkArena    post/pkArena/pkAnswer
	set to dictionary      ${params['pkAnswerPostParam']}    questionId    ${questionId}
	set to dictionary      ${params['pkAnswerPostParam']}    pkLogId    ${pkLogId}
	${resp}    getApiResp    ${token2}    post    /pkArena/pkAnswer    ${params['pkAnswerPostParam']}
	${result}    docmentAssert    post    /pkArena/pkAnswer    ${resp}
	should be true     ${result[0]}     ${result}

get/pkArena/targetAnswerDetail
	[Documentation]    查询对手答题详情
	[Tags]    Run
	${params}    getParam_data    PkArena    get/pkArena/targetAnswerDetail
	set to dictionary      ${params}    questionId    ${questionId}
	set to dictionary      ${params}    pkLogId    ${pkLogId}
	${resp}    getApiResp    ${token}    get    /pkArena/targetAnswerDetail    ${params}
	${result}    docmentAssert    get    /pkArena/targetAnswerDetail    ${resp}
	should be true     ${result[0]}     ${result}

post/pkArena/quit
	[Documentation]    pk场
	[Tags]    Run
	${params}    getParam_data    PkArena    post/pkArena/quit
	set to dictionary      ${params}    pkLogId    ${pkLogId}
	${resp}    getApiResp    ${token}    post    /pkArena/quit    ${params}
	${result}    docmentAssert    post    /pkArena/quit    ${resp}
	should be true     ${result[0]}     ${result}

get/pkArena/danGradingTips
	[Documentation]    段位升降提示
	[Tags]    Run
	${params}    getParam_data    PkArena    get/pkArena/danGradingTips
	set to dictionary      ${params}    pkLogId    ${pkLogId}
	${resp}    getApiResp    ${token}    get    /pkArena/danGradingTips    ${params}
	pass execution if    '${resp}'=='${EMPTY}'     没有升级，所以不提示
	${result}    docmentAssert    get    /pkArena/danGradingTips    ${resp}
	should be true     ${result[0]}     ${result}

get/pkArena/pkDynamicImg/{userId}/{pkLogId}
	[Documentation]    pk结果动态图片
	[Tags]    Run
	${params}    getParam_data    PkArena    get/pkArena/pkDynamicImg/{userId}/{pkLogId}
	set to dictionary      ${params}    pkLogId    ${pkLogId}
	${resp}    getApiResp    ${token}    get    /pkArena/pkDynamicImg/{userId}/{pkLogId}    ${params}
	should be true     ${True}      返回的是图片

get/pkArena/pkFinal
	[Documentation]    pk结果
	[Tags]    Run
	${params}    getParam_data    PkArena    get/pkArena/pkFinal
	set to dictionary      ${params}    pkLogId    ${pkLogId}
	${resp}    getApiResp    ${token}    get    /pkArena/pkFinal    ${params}
	@{fields}    create list      winRinkingInfo
	${result}    docmentAssert2    get    /pkArena/pkFinal    ${resp}    @{fields}
	should be true     ${result[0]}     ${result}

pkShare
    [Documentation]    pk结果分享
    [Tags]  Run
    ${params}    getParam_data    PkArena    pkShare
    set to dictionary    ${params}    pkLogId    ${pkLogId}
	getApiResp    ${token}    get    /users/share    ${params}

get/pkArena/pkFinal/share
	[Documentation]    pk结果分享
	[Tags]    Run
	${params}    getParam_data    PkArena    get/pkArena/pkFinal/share
	${resp}    getApiResp    ${token2}    get    /pkArena/pkFinal/share    ${params}
	${result}    docmentAssert    get    /pkArena/pkFinal/share    ${resp}
	should be true     ${result[0]}     ${result}

