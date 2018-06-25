*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/PkArena.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/PkArena.py
Variables         ../../Datas/Response/PkArena.py
Resource          ../../API/Users.robot
Variables         ../../Datas/Response/Users.py

*** Keywords ***
get/users/share_shareMark
	[Arguments]    ${token}    ${shareType}    ${shareMark}
	[Documentation]    小程序分享：接口文档中没有此接口
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    shareType    ${shareType}    shareMark    ${shareMark}
	${resp}    get request    exam    /users/share    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}

*** Test Cases ***
pkArena_me
	[Documentation]    pk场，显示当前用户信息
	[Tags]    Run
	${resp}    get/pkArena/me    ${token}
	set suite variable     ${shareMark}    ${resp['shareMark']}
	set suite variable     ${userId}    ${resp['userId']}
	${result}    compareResp    ${pkArena_me_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_me_resp['danGradingView']}    ${resp['danGradingView']}
	Should Be True    ${result['status']}    ${result}

users_share
	[Documentation]    分享PK连接
	[Tags]    Run
	${resp}    get/users/share_shareMark    ${token}    PK    ${shareMark}
	should be equal as strings    ${resp}    ${users_share_resp}

pkArena_join
	[Documentation]    好友对战，加入pk场
	[Tags]    Run
	${resp}    post/pkArena/join    ${token2}    ${shareMark}
	${result}    compareResp    ${pkArena_join_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_join_resp['targetUserView']}    ${resp['targetUserView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_join_resp['targetUserView']['danGradingView']}    ${resp['targetUserView']['danGradingView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_join_resp['currentUserView']}    ${resp['currentUserView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_join_resp['currentUserView']['danGradingView']}    ${resp['currentUserView']['danGradingView']}
	Should Be True    ${result['status']}    ${result}

pkArena_target
	[Documentation]    进入pk场,显示对方用户信息
	[Tags]    Run
	${resp}    get/pkArena/target    ${token}
	${result}    compareResp    ${pkArena_target_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_target_resp['danGradingView']}    ${resp['danGradingView']}
	Should Be True    ${result['status']}    ${result}

pkArena_pkMatch
	[Documentation]    匹配对手 / 点击分享链接
	[Tags]    Run
	${resp}    get/pkArena/pkMatch    ${token2}    ${shareMark}    ${False}
	set suite variable      ${pkLogId}    ${resp['pkLogId']}
	${result}    compareResp    ${pkArena_pkMatch_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkMatch_resp['targetUserView']}    ${resp['targetUserView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkMatch_resp['targetUserView']['danGradingView']}    ${resp['targetUserView']['danGradingView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkMatch_resp['currentUserView']}    ${resp['currentUserView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkMatch_resp['currentUserView']['danGradingView']}    ${resp['currentUserView']['danGradingView']}
	Should Be True    ${result['status']}    ${result}

pkArena_pkQuestions
	[Documentation]    查询pk场下一题信息
	[Tags]    Run
	${resp}    get/pkArena/pkQuestions    ${token}    ${pkLogId}    ${EMPTY}
	set suite variable     ${questionId}    ${resp['questionId']}
	${result}    compareResp    ${pkArena_pkQuestions_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

pkArena_pkAnswer
	[Documentation]    提交答案：自己
	[Tags]    Run
	set to dictionary      ${pkArena_pkAnswer_param['pkAnswerPostParam']}    questionId    ${questionId}
	set to dictionary      ${pkArena_pkAnswer_param['pkAnswerPostParam']}    pkLogId    ${pkLogId}
	${resp}    post/pkArena/pkAnswer    ${token}    ${pkArena_pkAnswer_param['pkAnswerPostParam']}
	${result}    compareResp    ${pkArena_pkAnswer_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

pkArena_pkAnswer2
	[Documentation]    提交答案：好友
	[Tags]    Run
	set to dictionary      ${pkArena_pkAnswer_param['pkAnswerPostParam']}    questionId    ${questionId}
	set to dictionary      ${pkArena_pkAnswer_param['pkAnswerPostParam']}    pkLogId    ${pkLogId}
	${resp}    post/pkArena/pkAnswer    ${token2}    ${pkArena_pkAnswer_param['pkAnswerPostParam']}
	${result}    compareResp    ${pkArena_pkAnswer_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

pkArena_targetAnswerDetail
	[Documentation]    查询对手答题详情
	[Tags]    Run
	${resp}    get/pkArena/targetAnswerDetail    ${token}    ${pkLogId}    ${questionId}
	${result}    compareResp    ${pkArena_targetAnswerDetail_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

pkArena_quit
	[Documentation]    pk场
	[Tags]    Run
	${resp}    post/pkArena/quit    ${token}    ${pkLogId}
	${result}    compareResp    ${pkArena_quit_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_quit_resp['danGradingView']}    ${resp['danGradingView']}
	Should Be True    ${result['status']}    ${result}

pkArena_danGradingTips
	[Documentation]    段位升降提示 ： 升级才会有提示
	[Tags]    NotRun
	${resp}    get/pkArena/danGradingTips    ${token}    ${pkLogId}
	${result}    compareResp    ${pkArena_danGradingTips_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

pkArena_pkDynamicImg_userId_pkLogId
	[Documentation]    pk结果动态图片：返回的是图片
	[Tags]    NotRun
	${resp}    get/pkArena/pkDynamicImg/{userId}/{pkLogId}    ${token}    ${userId}    ${pkLogId}
	should be equal as strings    ${resp}    ${pkArena_pkDynamicImg_userId_pkLogId_resp}

pkArena_pkFinal
	[Documentation]    pk结果
	[Tags]    Run
	${resp}    get/pkArena/pkFinal    ${token}    ${pkLogId}
	${result}    compareResp    ${pkArena_pkFinal_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkFinal_resp['winRinkingInfo']}    ${resp['winRinkingInfo']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkFinal_resp['targetUserView']}    ${resp['targetUserView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkFinal_resp['targetUserView']['danGradingView']}    ${resp['targetUserView']['danGradingView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkFinal_resp['currentUserView']}    ${resp['currentUserView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkFinal_resp['currentUserView']['danGradingView']}    ${resp['currentUserView']['danGradingView']}
	Should Be True    ${result['status']}    ${result}

users_share2
	[Documentation]    分享PK结果
	[Tags]    Run
	${resp}    get/users/share   ${token}    PK    ${pkLogId}
	should be equal as strings    ${resp}    ${users_share_resp}

pkArena_pkFinal_share
	[Documentation]    pk结果分享
	[Tags]    Run
	${resp}    get/pkArena/pkFinal/share    ${token3}    ${pkArena_pkFinal_share_param['shareMark']}
	${result}    compareResp    ${pkArena_pkFinal_share_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkFinal_share_resp['shareUserView']}    ${resp['shareUserView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${pkArena_pkFinal_share_resp['currentUserView']}    ${resp['currentUserView']}
	Should Be True    ${result['status']}    ${result}











