*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Resource          ../../API/PkArena.robot
Resource          ../Resource/PkArena.robot
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
	set suite variable     ${shareMark}    ${resp['shareMark']}
	should be equal as integers    ${resp['userId']}    ${userId}
	${sql_info}       userInfo      ${userId}
	should be equal as strings    ${resp['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId}
	set suite variable      ${exam_type_id}    ${sql_alinfo['exam_type_id']}
	should be equal as strings    ${resp['levelNum']}    ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
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

pkArena_join
	[Documentation]    好友对战，加入pk场
	[Tags]    Run
	${resp}    post/pkArena/join    ${token2}    ${shareMark}
	should be equal as strings    ${resp['status']}    FRIEND
	# 分享者信息
	should be equal as integers    ${resp['targetUserView']['userId']}    ${userId}
	${sql_info}       userInfo      ${userId}
	should be equal as strings    ${resp['targetUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['targetUserView']['headImgUrl']}   ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId}
	should be equal as strings    ${resp['targetUserView']['levelNum']}    ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['targetUserView']['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	should be equal as integers    ${resp['targetUserView']['danGradingView']['currentStar']}    ${sql_alinfo['current_star']}
	# 当前用户信息
    should be equal as integers    ${resp['currentUserView']['userId']}    ${userId2}
    ${sql_info}       userInfo      ${userId2}
    should be equal as strings    ${resp['currentUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['currentUserView']['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId2}    ${exam_type_id}
	Should Be Equal    ${resp['currentUserView']['levelNum']}    ${sql_alinfo['level_num']}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['currentStar']}    ${sql_alinfo['current_star']}

pkArena_target
	[Documentation]    进入pk场,显示对方用户信息
	[Tags]    Run
	${resp}    get/pkArena/target    ${token}
	should be equal as integers    ${resp['userId']}    ${userId2}
	${sql_info}       userInfo      ${userId2}
	should be equal as strings    ${resp['nickName']}     ${sql_info['nick_name']}
	should be equal as strings    ${resp['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId2}    ${exam_type_id}
	should be equal as strings    ${resp['levelNum']}    ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	should be equal as integers    ${resp['danGradingView']['currentStar']}    ${sql_alinfo['current_star']}
	should be equal as integers    ${resp['danGradingView']['winSum']}    ${sql_alinfo['win_sum']}
	should be equal as integers    ${resp['danGradingView']['pkSum']}    ${sql_alinfo['pk_sum']}
	${winRate}    getPercent      ${sql_alinfo['win_sum']}    ${sql_alinfo['pk_sum']}    0
	should be equal as integers    ${resp['danGradingView']['winRate']}    ${winRate}

pkArena_pkMatch
	[Documentation]    匹配对手 / 点击分享链接
	[Tags]    Run
	${resp}    get/pkArena/pkMatch    ${token2}    ${shareMark}    ${False}
	set suite variable      ${pkLogId}    ${resp['pkLogId']}
	# 分享者信息
	should be equal as integers    ${resp['targetUserView']['userId']}    ${userId}
	${sql_info}       userInfo      ${userId}
	should be equal as strings    ${resp['targetUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['targetUserView']['headImgUrl']}   ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId}
	should be equal as strings    ${resp['targetUserView']['levelNum']}    ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['targetUserView']['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	should be equal as integers    ${resp['targetUserView']['danGradingView']['currentStar']}    ${sql_alinfo['current_star']}
	# 当前用户信息
    should be equal as integers    ${resp['currentUserView']['userId']}    ${userId2}
    ${sql_info}       userInfo      ${userId2}
    should be equal as strings    ${resp['currentUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['currentUserView']['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId2}    ${exam_type_id}
	Should Be Equal    ${resp['currentUserView']['levelNum']}    ${sql_alinfo['level_num']}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['currentStar']}    ${sql_alinfo['current_star']}

pkArena_pkQuestions
	[Documentation]    查询pk场下一题信息,第一题
	[Tags]    Run
	${resp}    get/pkArena/pkQuestions    ${token}    ${pkLogId}    ${EMPTY}
	should be equal as integers    ${resp['questionCurrentNum']}    1
	${sql_pklog}    pklog      ${pkLogId}
	should be equal as integers    ${resp['questionId']}    ${sql_pklog['question_ids'][0]}
	set suite variable      ${questionId}    ${resp['questionId']}
	should be equal as integers    ${resp['questionSum']}    ${sql_pklog['question_count']}
	${sql_question}    question      ${sql_pklog['question_ids'][0]}
	should be equal as strings    ${resp['questionType']}    ${sql_question['question_type']}
	should be equal as strings    ${resp['questionDesc']}    ${sql_question['question_desc']}
    ${len}    evaluate      len(${sql_question['options_desc']})
    ${sql_question['options_desc']}    to json      ${sql_question['options_desc']}
    ${keys}     get dictionary keys      ${sql_question['options_desc']}
    :For    ${x}    In Range    ${len}
    \    Should Be Equal    ${resp['options'][${x}]['option']}    ${keys[${x}]}
    \    ${optionDesc}     get from dictionary      ${sql_question['options_desc']}    ${keys[${x}]}
    \    Should Be Equal    ${resp['options'][${x}]['optionDesc']}    ${optionDesc}
	should not be true    ${resp['currentUserScoreSum']}
	should not be true    ${resp['targetUserScore']}
	should not be true    ${resp['targetUserDuration']}
	should not be true    ${resp['targetUserScoreSum']}


pkArena_pkAnswer
	[Documentation]    提交答案：自己
	[Tags]    Run
	${sql_pklog}    pklog      ${pkLogId}
	${pkAnswerPostParam}    copy dictionary       ${pkArena_pkAnswer_param['pkAnswerPostParam']}
	set to dictionary      ${pkAnswerPostParam}    questionId    ${sql_pklog['question_ids'][0]}
	set to dictionary      ${pkAnswerPostParam}    pkLogId    ${pkLogId}
	${sql_question}    question      ${questionId}
	set suite variable      ${currentUserAnswer}      ${sql_question['correct_answer']}
	set to dictionary      ${pkAnswerPostParam}    currentUserAnswer     ${currentUserAnswer}
	${resp}    post/pkArena/pkAnswer    ${token}    ${pkAnswerPostParam}
	should be equal as integers    ${resp['currentUserScore']}    10
	should not be true    ${resp['targetUserAnswer']}
	should be equal as strings    ${resp['currentUserScoreSum']}    10
	should be equal as strings    ${resp['correctAnswer']}    ${sql_question['correct_answer']}


pkArena_pkAnswer2
	[Documentation]    提交答案：好友
	[Tags]    Run
    ${sql_pklog}    pklog      ${pkLogId}
	${pkAnswerPostParam}    copy dictionary       ${pkArena_pkAnswer_param['pkAnswerPostParam']}
	set to dictionary      ${pkAnswerPostParam}    questionId    ${sql_pklog['question_ids'][0]}
	set to dictionary      ${pkAnswerPostParam}    pkLogId    ${pkLogId}
	${sql_question}    question      ${questionId}
	${options_desc}    to json     ${sql_question['options_desc']}
	${keys}     get dictionary keys      ${options_desc}
	remove values from list      ${keys}    ${sql_question['correct_answer']}
	${targetUserAnswer}    getRandomStr      ${keys}
	set suite variable      ${targetUserAnswer}
	set to dictionary      ${pkAnswerPostParam}    currentUserAnswer    ${targetUserAnswer}
	${resp}    post/pkArena/pkAnswer    ${token2}    ${pkAnswerPostParam}
	should be equal as integers    ${resp['currentUserScore']}    0
	should not be true   ${resp['targetUserAnswer']}
	should be equal as strings    ${resp['currentUserScoreSum']}    0
	should be equal as strings    ${resp['correctAnswer']}    ${sql_question['correct_answer']}

pkArena_targetAnswerDetail
	[Documentation]    查询对手答题详情
	[Tags]    Run
	${resp}    get/pkArena/targetAnswerDetail    ${token}    ${pkLogId}    ${questionId}
	should be equal as strings    ${resp['targetUserAnswer']}    ${targetUserAnswer}
	should be equal as integers    ${resp['targetUserScore']}    0
	should be equal as integers    ${resp['targetUserDuration']}    2
	should be equal as strings    ${resp['correctAnswer']}     ${currentUserAnswer}
	should be equal as integers    ${resp['targetUserScoreSum']}   0

pkArena_targetAnswerDetail2
	[Documentation]    对手查询自己答题详情
	[Tags]    Run
	${resp}    get/pkArena/targetAnswerDetail    ${token2}    ${pkLogId}    ${questionId}
	should be equal as strings     ${resp['targetUserAnswer']}    ${currentUserAnswer}
	should be equal as integers    ${resp['targetUserScore']}    10
	should be equal as integers    ${resp['targetUserDuration']}    2
	should be equal as strings    ${resp['correctAnswer']}     ${currentUserAnswer}
	should be equal as integers    ${resp['targetUserScoreSum']}   10

pkArena_quit
	[Documentation]    pk场
	[Tags]    Run
	${resp}    post/pkArena/quit    ${token}    ${pkLogId}
	should be equal as integers    ${resp['userId']}    ${userId}
	${sql_info}       userInfo      ${userId}
	should be equal as strings    ${resp['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId}
	should be equal as strings    ${resp['levelNum']}    ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	should be equal as integers    ${resp['danGradingView']['currentStar']}    ${sql_alinfo['current_star']}
	should be equal as integers    ${resp['danGradingView']['winSum']}    ${sql_alinfo['win_sum']}
	should be equal as integers    ${resp['danGradingView']['pkSum']}    ${sql_alinfo['pk_sum']}
	${winRate}    getPercent      ${sql_alinfo['win_sum']}    ${sql_alinfo['pk_sum']}    0
	should be equal as integers    ${resp['danGradingView']['winRate']}    ${winRate}

pkArena_pkFinal
	[Documentation]    pk结果
	[Tags]    Run
	${resp}    get/pkArena/pkFinal    ${token}    ${pkLogId}
	should be equal as integers    ${resp['pkLogId']}     ${pkLogId}
	should be equal as integers    ${resp['userId']}    ${userId}
#	Should Be Equal     ${resp['winRinkingInfo']['headImgUrls'][0]}    ${sql}
#	Should Be Equal    ${resp['winRinkingInfo']['surpass']}    ${sql}
	${sql_info}       userInfo      ${userId}
	should be equal as strings    ${resp['currentUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['currentUserView']['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId}
	should be equal as strings    ${resp['currentUserView']['levelNum']}     ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['currentUserView']['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	should be equal as integers    ${resp['currentUserView']['danGradingView']['currentStar']}    ${sql_alinfo['current_star']}
	should be equal as integers    ${resp['currentUserView']['danGradingView']['beforeStar']}    ${beforeStar}
	should be equal as integers    ${resp['currentUserView']['userId']}    ${userId}
	should be equal as integers    ${resp['currentUserView']['userScoreSum']}    10
	should be equal as strings    ${resp['currentUserView']['results']}    LOSE
	${sql_info}       userInfo      ${userId2}
	should be equal as strings    ${resp['targetUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['targetUserView']['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId2}    ${exam_type_id}
	should be equal as strings    ${resp['targetUserView']['levelNum']}     ${sql_alinfo['level_num']}
	should be equal as strings    ${resp['targetUserView']['danGradingView']['danGradingName']}    ${sql_alinfo['dan_grading_name']}
	should be equal as integers    ${resp['targetUserView']['danGradingView']['currentStar']}    ${sql_alinfo['current_star']}
	should be equal as integers    ${resp['targetUserView']['userId']}    ${userId2}
	should be equal as integers    ${resp['targetUserView']['userScoreSum']}    0

users_share
	[Documentation]    分享PK结果
	[Tags]    Run
	${resp}    get/users/share   ${token}    PK    ${pkLogId}

pkArena_pkFinal_share
	[Documentation]    pk结果分享
	[Tags]    Run
	${sql_pklog}   pkLog    ${pkLogId}
	${resp}    get/pkArena/pkFinal/share    ${token2}    ${sql_pklog['share_mark']}
	${sql_info}       userInfo      ${userId2}
	should be equal as strings    ${resp['currentUserView']['nickName']}    ${sql_info['nick_name']}
	should be equal as strings    ${resp['currentUserView']['headImgUrl']}    ${sql_info['head_image_url']}
	${sql_alinfo}       userAlterableInfo      ${userId2}    ${exam_type_id}
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
	should be equal as integers    ${resp['shareUserView']['scoreSum']}    10









