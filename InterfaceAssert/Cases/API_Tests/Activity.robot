*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/Activity.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/Activity.py
Variables         ../../Datas/Response/Activity.py


*** Test Cases ***
activity
	[Documentation]    活动列表
	[Tags]    Run
	${resp}    get/activity    ${token}
	${result}    compareResp    ${activity_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_push
	[Documentation]    活动推送消息
	[Tags]    Run
	${resp}    get/activity/push    ${token}
	${result}    compareResp    ${activity_push_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_pointQuestion_home
	[Documentation]    小心心首页
	[Tags]    Run
	${resp}    get/activity/pointQuestion/home    ${token}    ${activity_pointQuestion_home_param['shareMark']}
	${result}    compareResp    ${activity_pointQuestion_home_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_pointQuestion_home_resp['usersHeadImageUrl'][0]}    ${resp['usersHeadImageUrl'][0]}
	Should Be True    ${result['status']}    ${result}

activity_pointQuestion_final
	[Documentation]    小心心提交点击次数，返回数据
	[Tags]    Run
	${resp}    get/activity/pointQuestion/final    ${token}    ${activity_pointQuestion_final_param['sum']}
	${result}    compareResp    ${activity_pointQuestion_final_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_APM_ranking
	[Documentation]    小心心手速排行榜
	[Tags]    Run
	${resp}    get/activity/APM/ranking    ${token}
	${result}    compareResp    ${activity_APM_ranking_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_APM_ranking_resp['meInfo']}    ${resp['meInfo']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_APM_ranking_resp['userInfo'][0]}    ${resp['userInfo'][0]}
	Should Be True    ${result['status']}    ${result}

activity_worldCup_peopleSum
	[Documentation]    参与人数
	[Tags]    Run
	${resp}    get/activity/worldCup/peopleSum    ${token}
	${result}    compareResp    ${activity_worldCup_peopleSum_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_worldCup_match
	[Documentation]    世界杯配对活动随机匹配
	[Tags]    Run
	${resp}    get/activity/worldCup/match    ${token}    ${activity_worldCup_match_param['selfSex']}
	${result}    compareResp    ${activity_worldCup_match_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_worldCup_cancelMatch
	[Documentation]    取消匹配
	[Tags]    Run
	${resp}    get/activity/worldCup/cancelMatch    ${token}
	${result}    compareResp    ${activity_worldCup_cancelMatch_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_worldCup_invite
	[Documentation]    世界杯配对活动邀请匹配
	[Tags]    Run
	${resp}    post/activity/worldCup/invite    ${token}    ${activity_worldCup_invite_param['selfSex']}
	${result}    compareResp    ${activity_worldCup_invite_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_worldCup_share
	[Documentation]    世界杯配对活动点击气泡详情
	[Tags]    Run
	${resp}    get/activity/worldCup/share    ${token2}    ${activity_worldCup_share_param['mark']}
	${result}    compareResp    ${activity_worldCup_share_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_worldCup_join
	[Documentation]    加入好友邀请
	[Tags]    Run
	${resp}    post/activity/worldCup/join    ${token2}    ${activity_worldCup_join_param['mark']}
	${result}    compareResp    ${activity_worldCup_join_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_worldCup_teamDetails
	[Documentation]    世界配对成功活动详情
	[Tags]    Run
	${resp}    get/activity/worldCup/teamDetails    ${token2}    ${activity_worldCup_teamDetails_param['teamId']}
	${result}    compareResp    ${activity_worldCup_teamDetails_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_worldCup_teamDetails_resp['userInfo']}    ${resp['userInfo']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_worldCup_teamDetails_resp['otherUserInfo']}    ${resp['otherUserInfo']}
	Should Be True    ${result['status']}    ${result}

activity_worldCup_remindTeammates
	[Documentation]    提醒队友
	[Tags]    Run
	${resp}    post/activity/worldCup/remindTeammates    ${token2}
	should be equal as strings    ${resp}    ${activity_worldCup_remindTeammates_resp}

activity_worldCup_ranking
	[Documentation]    世界杯配对活动排行榜
	[Tags]    Run
	${resp}    get/activity/worldCup/ranking    ${token}
	${result}    compareResp    ${activity_worldCup_ranking_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_worldCup_barrage
	[Documentation]    弹幕
	[Tags]    Run
	${resp}    get/activity/worldCup/barrage    ${token}
	${result}    compareResp    ${activity_worldCup_barrage_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_worldCup_kickOut
	[Documentation]    踢队友
	[Tags]    Run
	${resp}    post/activity/worldCup/kickOut    ${token}
	should be equal as strings    ${resp}    ${activity_worldCup_kickOut_resp}

activity_worldCup_userDetails
	[Documentation]    世界配对成功活动详情：此接口已废弃
	[Tags]    NotRun
	${resp}    get/activity/worldCup/userDetails    ${token}
	${result}    compareResp    ${activity_worldCup_userDetails_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_worldCup_userDetails_resp['otherUserInfo']}    ${resp['otherUserInfo']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_worldCup_userDetails_resp['userInfo']}    ${resp['userInfo']}
	Should Be True    ${result['status']}    ${result}

activity_join
	[Documentation]    发起拼团
	[Tags]    NotRun
	${resp}    post/activity/join    ${token}
	${result}    compareResp    ${activity_join_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_details
	[Documentation]    拼团详情页
	[Tags]    NotRun
	${resp}    get/activity/details    ${token}    ${activity_details_param['mark']}
	${result}    compareResp    ${activity_details_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_details_resp['userList'][0]}    ${resp['userList'][0]}
	Should Be True    ${result['status']}    ${result}

activity_goods
	[Documentation]    拼团成功详情页
	[Tags]    NotRun
	${resp}    get/activity/goods    ${token}    ${activity_goods_param['phoneNumber']}
	${result}    compareResp    ${activity_goods_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_goods_resp['goodsList'][0]}    ${resp['goodsList'][0]}
	Should Be True    ${result['status']}    ${result}

activity_decodeUserInfo
	[Documentation]    微信授权获取手机号
	[Tags]    NotRun
	${resp}    get/activity/decodeUserInfo    ${token}    ${activity_decodeUserInfo_param['code']}    ${activity_decodeUserInfo_param['encryptedData']}    ${activity_decodeUserInfo_param['iv']}    ${activity_decodeUserInfo_param['type']}
	${result}    compareResp    ${activity_decodeUserInfo_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_draw_details
	[Documentation]    抽签页面详情
	[Tags]    NotRun
	${resp}    get/activity/draw/details    ${token}
	${result}    compareResp    ${activity_draw_details_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_draw_details_resp['helpList'][0]}    ${resp['helpList'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_draw_details_resp['goodsList'][0]}    ${resp['goodsList'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_draw_details_resp['drawInfo']}    ${resp['drawInfo']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_draw_details_resp['wxInfo']}    ${resp['wxInfo']}
	Should Be True    ${result['status']}    ${result}

activity_draw_join
	[Documentation]    抽签结果上报
	[Tags]    NotRun
	${resp}    post/activity/draw/join    ${token}    ${activity_draw_join_param['DrawType']}
	${result}    compareResp    ${activity_draw_join_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_draw_help
	[Documentation]    好友助力
	[Tags]    NotRun
	${resp}    post/activity/draw/help    ${token}    ${activity_draw_help_param['mark']}
	${result}    compareResp    ${activity_draw_help_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

activity_draw_shareUser
	[Documentation]    分享用户详情
	[Tags]    NotRun
	${resp}    get/activity/draw/shareUser    ${token}    ${activity_draw_shareUser_param['mark']}
	${result}    compareResp    ${activity_draw_shareUser_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_draw_shareUser_resp['helpList'][0]}    ${resp['helpList'][0]}
	Should Be True    ${result['status']}    ${result}

activity_valentines_form
	[Documentation]    配对活动表单上传
	[Tags]    NotRun
	${resp}    post/activity/valentines/form    ${token}    ${activity_valentines_form_param['selfSex']}    ${activity_valentines_form_param['hopeSex']}
	should be equal as strings    ${resp}    ${activity_valentines_form_resp}

activity_valentines_details
	[Documentation]    配对成功活动详情
	[Tags]    NotRun
	${resp}    get/activity/valentines/details    ${token}
	${result}    compareResp    ${activity_valentines_details_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_valentines_details_resp['otherUserInfo']}    ${resp['otherUserInfo']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_valentines_details_resp['userInfo']}    ${resp['userInfo']}
	Should Be True    ${result['status']}    ${result}

activity_valentines_ranking
	[Documentation]    配对活动排行榜
	[Tags]    NotRun
	${resp}    get/activity/valentines/ranking    ${token}
	${result}    compareResp    ${activity_valentines_ranking_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_valentines_ranking_resp['userInfo']}    ${resp['userInfo']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${activity_valentines_ranking_resp['otherUserInfo']}    ${resp['otherUserInfo']}
	Should Be True    ${result['status']}    ${result}
