*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Library           ../../Common/PrivateMethod.py
Resource          ../../API/Activity.robot
Resource          ../Resource/Activity.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/Activity.py
Variables         ../../Datas/Response/Activity.py


*** Test Cases ***
ctivity_pointQuestion_home
	[Documentation]    小心心首页
	[Tags]    Run
	${resp}    get/activity/pointQuestion/home    ${token}    ${EMPTY}
	${sql_info}    userInfo     ${userId}
	Should Be Equal As Strings    ${resp['nickName']}    ${sql_info['nick_name']}
    Should Be Equal As Strings    ${resp['headImageUrl']}    ${sql_info['head_image_url']}
    ${sql_apm}    userApm     ${userId}
	Should Be Equal As Strings    ${resp['chance']}    ${sql_apm['default_chance']}
    Should Be Equal As Strings    ${resp['highestApm']}    ${sql_apm['highest_apm']}
    Should Be Equal As Strings    ${resp['peopleSum']}    ${sql_apm['peopleSum']}
    Should Be Equal As Strings    ${resp['extraChance']}    ${sql_apm['extra_chance']}
    Should Be Equal As Strings    ${resp['questionSum']}    ${sql_apm['question_sum']}

activity_pointQuestion_final
	[Documentation]    小心心提交点击次数，返回数据,参加2次
	[Tags]    Run
	${sql_apm}    userApm     ${userId}
	:For    ${x}    In Range     ${sql_apm['default_chance']}
	\    ${num}    getRandomInt     0    200
    \    ${resp}    get/activity/pointQuestion/final    ${token}    ${num}   ${True}
    \    ${data}    getApmFinal    ${num}
    \    Should Be Equal As Integers    ${resp['pointSum']}     ${data['pointSum']}
    \    Should Be Equal As Integers    ${resp['question']}     ${data['question']}
    \    Should Be Equal As Strings    ${resp['title']}     ${data['title']}
    ${sql_apm}    userApm     ${userId}
    should be equal as integers     ${sql_apm['default_chance']}    0

users_share_AC
	[Documentation]    小程序分享
	[Tags]    Run
    get/users/share_AC    ${token}
    ${sql_apm}    userApm     ${userId}
    ${extra_chance}    evaluate     ${sql_apm['extra_chance']}+1
    ${sql_share}     examShare    ${userId}
    ${resp}    get/activity/pointQuestion/home    ${token2}    ${sql_share['share_mark']}
    ${sql_apm}    userApm     ${userId}
    should be equal as integers     ${extra_chance}    ${sql_apm['extra_chance']}
	${sql_info}    userInfo     ${userId2}
	Should Be Equal As Strings    ${resp['nickName']}    ${sql_info['nick_name']}
    Should Be Equal As Strings    ${resp['headImageUrl']}    ${sql_info['head_image_url']}
    ${sql_apm}    userApm     ${userId2}
	Should Be Equal As Strings    ${resp['chance']}    ${sql_apm['default_chance']}
    Should Be Equal As Strings    ${resp['highestApm']}    ${sql_apm['highest_apm']}
    Should Be Equal As Strings    ${resp['peopleSum']}    ${sql_apm['peopleSum']}
    Should Be Equal As Strings    ${resp['extraChance']}    ${sql_apm['extra_chance']}
    Should Be Equal As Strings    ${resp['questionSum']}    ${sql_apm['question_sum']}

activity_pointQuestion_final_2
	[Documentation]    小心心提交点击次数，返回数据,分想获得次数
	[Tags]    Run
    ${sql_apm}    userApm     ${userId}
	:For    ${x}    In Range     ${sql_apm['extra_chance']}
	\    ${num}    getRandomInt     0    200
    \    ${resp}    get/activity/pointQuestion/final    ${token}    ${num}   ${True}
    \    ${data}    getApmFinal    ${num}
    \    Should Be Equal As Integers    ${resp['pointSum']}     ${data['pointSum']}
    \    Should Be Equal As Integers    ${resp['question']}     ${data['question']}
    \    Should Be Equal As Strings    ${resp['title']}     ${data['title']}
    ${sql_apm}    userApm     ${userId}
    should be equal as integers     ${sql_apm['extra_chance']}    0

activity_APM_ranking
	[Documentation]    小心心手速排行榜
	[Tags]    Run
	${resp}    get/activity/APM/ranking    ${token}
	${sql_apm}    userApm   ${userId}
	${userInfo}    Get From Dictionary    ${resp}    userInfo
    ${len}    Evaluate    len(${sql_apm})
    : FOR    ${x}    INRANGE    0    100
    \    Should Be Equal As Strings    ${userInfo[${x}]['userId']}    ${sql_apm['user_id_rank'][${x}]}
    \    ${sql_info}    userInfo     ${sql_apm['user_id_rank'][${x}]}
    \    Should Be Equal As Strings    ${userInfo[${x}]['headImgUrl']}    ${sql_info['head_image_url']}
    \    Should Be Equal As Strings    ${userInfo[${x}]['nickName']}    ${sql_info['nick_name']}
    \    Should Be Equal As Strings    ${userInfo[${x}]['title']}     ${sql_apm['title_rank'][${x}]}
    \    Should Be Equal As Strings    ${userInfo[${x}]['questionSum']}     ${sql_apm['question_sum_rank'][${x}]}
    \    Should Be Equal As Strings    ${userInfo[${x}]['apm']}     ${sql_apm['highest_apm_rank'][${x}]}
    \    Should Be Equal As Strings    ${userInfo[${x}]['modifiDate']}    ${sql_apm['modifi_date_rank'][${x}]}
    \    Should Be Equal As Strings    ${userInfo[${x}]['chance']}     ${sql_apm['default_chance_rank'][${x}]}
    \    Should Be Equal As Strings    ${userInfo[${x}]['extraChance']}     ${sql_apm['extra_chance_rank'][${x}]}
    \    Should Be Equal As Strings    ${userInfo[${x}]['todayGain']}     ${sql_apm['today_gain_rank'][${x}]}
    ${meInfo}    Get From Dictionary    ${resp}    meInfo
    Should Be Equal As Strings    ${meInfo['userId']}    ${userId}
    ${sql_info}    userInfo     ${meInfo['userId']}
    Should Be Equal As Strings    ${meInfo['headImgUrl']}    ${sql_info['head_image_url']}
    Should Be Equal As Strings    ${meInfo['nickName']}    ${sql_info['nick_name']}
    should be equal as strings    ${meInfo['title']}    ${sql_apm['title']}
    Should Be Equal As Strings    ${meInfo['questionSum']}    ${sql_apm['question_sum']}
    Should Be Equal As Strings    ${meInfo['apm']}    ${sql_apm['highest_apm']}
    Should Be Equal As Strings    ${meInfo['modifiDate']}    ${sql_apm['modifi_date']}
    Should Be Equal As Strings    ${meInfo['chance']}    ${sql_apm['default_chance']}
    Should Be Equal As Strings    ${meInfo['extraChance']}    ${sql_apm['extra_chance']}
    Should Be Equal As Strings    ${meInfo['todayGain']}    ${sql_apm['today_gain']}
