*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/Users.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/Users.py
Variables         ../../Datas/Response/Users.py


*** Test Cases ***
users_unchainPaper
	[Documentation]    授权解锁 模拟试卷
	[Tags]    NotRun
	${resp}    post/users/unchainPaper    ${token}    ${users_unchainPaper_param['userCodeView']}
	should be equal as strings    ${resp}    ${users_unchainPaper_resp}

users_home
	[Documentation]    欢迎页详情
	[Tags]    Run
	${resp}    get/users/home    ${token}
	${result}    compareResp    ${users_home_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

users_survey
	[Documentation]    用户测试数据提交  :第一次登陆才会调用
	[Tags]    NotRun
	${resp}    post/users/survey    ${token}    ${users_survey_param['userSurveyView']}
	${result}    compareResp    ${users_survey_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

users_me
	[Documentation]    首页我的详情
	[Tags]    Run
	${resp}    get/users/me    ${token}    ${users_me_param['lat']}    ${users_me_param['lon']}
	${result}    compareResp    ${users_me_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${users_me_resp['examTimeInfo']}    ${resp['examTimeInfo']}
	Should Be True    ${result['status']}    ${result}

users_share
	[Documentation]    小程序分享
	[Tags]    Run
	${resp}    get/users/share    ${token}    ${users_share_param['shareType']}    ${users_share_param['pkLogId']}
	should be equal as strings    ${resp}    ${users_share_resp}

users_examTypes
	[Documentation]    修改用户考试类型
	[Tags]    Run
	${resp}    put/users/examTypes    ${token}    ${users_examTypes_param['examTypeId']}    ${users_examTypes_param['recomment']}
	should be equal as strings    ${resp}    ${users_examTypes_resp}

users_push
	[Documentation]    首页推送消息集合
	[Tags]    Run
	${resp}    get/users/push    ${token}
	${result}    compareResp    ${users_push_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

users_me_info
	[Documentation]    我的数据
	[Tags]    Run
	${resp}    get/users/me/info    ${token}    ${users_me_info_param['mark']}
	${result}    compareResp    ${users_me_info_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

users_advice
	[Documentation]    用户意见反馈
	[Tags]    Run
	${resp}    post/users/advice    ${token}    ${users_advice_param['content']}    ${users_advice_param['userIp']}
	should be equal as strings    ${resp}    ${users_advice_resp}

users_conllects_questionId
	[Documentation]    用户收藏
	[Tags]    Run
	${resp}    post/users/conllects/{questionId}    ${token}    ${users_conllects_questionId_param['questionId']}
	should be equal as strings    ${resp}    ${users_conllects_questionId_resp}

users_token_refresh
	[Documentation]    换取新的尚德token对 ：token手动填写，目前获取不到
	[Tags]    NotRun
	${resp}    get/users/token/refresh    ${token}    ${users_token_refresh_param['token']}    ${users_token_refresh_param['refreshToken']}
	${result}    compareResp    ${users_token_refresh_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

users_token
	[Documentation]    微信登陆获取尚德token对 ：token手动填写，目前获取不到
	[Tags]    NotRun
	${resp}    get/users/token    ${token}    ${users_token_param['code']}    ${users_token_param['encryptedData']}    ${users_token_param['iv']}
	${result}    compareResp    ${users_token_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

users_examPapers
	[Documentation]    首页试卷列表  ： 这个接口已经不用了
	[Tags]    NotRun
	${resp}    get/users/examPapers    ${token}
	${result}    compareResp    ${users_examPapers_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

users_subjects
	[Documentation]    修改用户科目
	[Tags]    Run
	${resp}    put/users/subjects    ${token}    ${users_subjects_param['subjectId']}
	should be equal as strings    ${resp}    ${users_subjects_resp}

users_posters
	[Documentation]    用户打卡图片集 ： 目前还没用
	[Tags]    NotRun
	${resp}    get/users/posters    ${token}    ${users_posters_param['writingsType']}
	${result}    compareResp    ${users_posters_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${users_posters_resp['RARE'][0]}    ${resp['RARE'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${users_posters_resp['RARE'][0]['clockInlist'][0]}    ${resp['RARE'][0]['clockInlist'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${users_posters_resp['LEGEND'][0]}    ${resp['LEGEND'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${users_posters_resp['LEGEND'][0]['clockInlist'][0]}    ${resp['LEGEND'][0]['clockInlist'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${users_posters_resp['UNCOMMON'][0]}    ${resp['UNCOMMON'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${users_posters_resp['UNCOMMON'][0]['clockInlist'][0]}    ${resp['UNCOMMON'][0]['clockInlist'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${users_posters_resp['GENERAL'][0]}    ${resp['GENERAL'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${users_posters_resp['GENERAL'][0]['clockInlist'][0]}    ${resp['GENERAL'][0]['clockInlist'][0]}
	Should Be True    ${result['status']}    ${result}

users_support
	[Documentation]    题库数据支持
	[Tags]    Run
	${resp}    get/users/support    ${token}
	${result}    compareResp    ${users_support_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${users_support_resp['activityInfo']}    ${resp['activityInfo']}
	Should Be True    ${result['status']}    ${result}

