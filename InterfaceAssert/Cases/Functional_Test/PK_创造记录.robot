*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Resource          ../../API/PkArena.robot
Resource          ../Resource/PkArena.robot
Variables          ../Variables/PkArena.py
Variables         ../../Base.py
Variables         ../../Datas/Params/PkArena.py
Variables         ../../Datas/Response/PkArena.py
Resource          ../../API/Users.robot
Variables         ../../Datas/Response/Users.py


*** Test Cases ***
pkArena_me
	[Documentation]    pk场，显示当前用户信息
	[Tags]    Run
	${resp}    get/pkArena/me    ${token}
	should be equal as integers    ${resp['userId']}    ${userId}
	set suite variable     ${shareMark}    ${resp['shareMark']}
	${sql_info}       userInfo      ${userId}
	should be equal as strings    ${resp['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId}
	set suite variable      ${exam_type_id}    ${sql_alinfo['exam_type_id']}
	should be equal as strings    ${resp['levelNum']}    ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	set suite variable      ${danGradingName}    ${resp['danGradingView']['danGradingName']}
	should be equal as integers    ${resp['danGradingView']['currentStar']}    ${sql_alinfo['current_star']}
	set suite variable      ${beforeStar}    ${resp['danGradingView']['currentStar']}
	should be equal as integers    ${resp['danGradingView']['winSum']}    ${sql_alinfo['win_sum']}
	should be equal as integers    ${resp['danGradingView']['pkSum']}    ${sql_alinfo['pk_sum']}
	${winRate}    getPercent      ${sql_alinfo['win_sum']}    ${sql_alinfo['pk_sum']}    0
	should be equal as integers    ${resp['danGradingView']['winRate']}    ${winRate}

users_share_shareMark
	[Documentation]    分享PK连接
	[Tags]    Run
	${resp}    get/users/share_shareMark    ${token}    PK    ${shareMark}


pkArena_pkMatch
	[Documentation]    匹配对手 / 点击分享链接，创造记录
	[Tags]    Run
	${resp}    get/pkArena/pkMatch    ${token}    ${shareMark}    ${True}
	set suite variable      ${pkLogId}    ${resp['pkLogId']}
	# 当前用户信息
    should be equal as integers    ${resp['currentUserView']['userId']}    ${userId}
    ${sql_info}       userInfo      ${userId}
    should be equal as strings    ${resp['currentUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['currentUserView']['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId}
	Should Be Equal    ${resp['currentUserView']['levelNum']}    ${sql_alinfo['level_num']}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['currentStar']}    ${sql_alinfo['current_star']}

pkArena_pkFinal
	[Documentation]    pk结果
	[Tags]    Run
	${result}    PK_创造记录_结果    ${pkLogId}    ${Create['isCorrect_1']}    ${Create['currentUserDuration_1']}
	${resp}    get/pkArena/pkFinal    ${token}    ${pkLogId}
	should be equal as integers    ${resp['pkLogId']}     ${pkLogId}
	should be equal as integers    ${resp['userId']}    ${userId}
#	${sql_pklog}   pkLog    ${pkLogId}
#	Should Be Equal    ${resp['winRinkingInfo']['surpass']}    ${sql_pklog['surpass']}
#	${len}    evaluate    len(${resp['winRinkingInfo']['headImgUrls']})
#	:For    ${x}    In Range    ${len}
#	\    ${sql_info}     userInfo        ${sql_pklog['head_img_urls'][${x}]}
#	\    Should Be Equal     ${resp['winRinkingInfo']['headImgUrls'][${x}]}    ${sql_info['head_image_url']}
	${sql_info}       userInfo      ${userId}
	should be equal as strings    ${resp['currentUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['currentUserView']['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId}
	should be equal as strings    ${resp['currentUserView']['results']}    ${result[0]}
	should be equal as integers    ${resp['currentUserView']['userScoreSum']}    ${result[1]}
	set suite variable      ${scoreSum}    ${result[1]}
	${grading}    getPKGranding    ${danGradingName}    ${beforeStar}    ${result[0]}
	should be equal as strings    ${resp['currentUserView']['levelNum']}     ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['currentUserView']['danGradingView']['danGradingName']}    ${grading['pkgrading']}
	should be equal as integers    ${resp['currentUserView']['danGradingView']['currentStar']}    ${grading['pkstar']}
	should be equal as integers    ${resp['currentUserView']['danGradingView']['beforeStar']}    ${beforeStar}
	should be equal as integers    ${resp['currentUserView']['userId']}    ${userId}

users_share
	[Documentation]    分享PK结果
	[Tags]    Run
	${resp}    get/users/share   ${token}    PK    ${pkLogId}

pkArena_pkFinal_share
	[Documentation]    pk结果分享
	[Tags]    Run
	${sql_pklog}   pkLog    ${pkLogId}
	${resp}    get/pkArena/pkFinal/share    ${token3}    ${sql_pklog['share_mark']}
	${sql_info}       userInfo      ${userId3}
	should be equal as strings    ${resp['currentUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['currentUserView']['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId3}    ${exam_type_id}
	should be equal as strings    ${resp['currentUserView']['levelNum']}     ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['currentUserView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	should be equal as integers    ${resp['currentUserView']['startNum']}    ${sql_alinfo['current_star']}
	${sql_info}       userInfo      ${userId}
	should be equal as strings    ${resp['shareUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['shareUserView']['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId}
	should be equal as strings    ${resp['shareUserView']['levelNum']}     ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['shareUserView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	should be equal as integers    ${resp['shareUserView']['startNum']}    ${sql_alinfo['current_star']}
	should be equal as integers    ${resp['shareUserView']['scoreSum']}    ${scoreSum}









