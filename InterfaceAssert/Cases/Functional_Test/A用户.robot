*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Resource          ../../API/Users.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/Users.py
Variables         ../../Datas/Response/Users.py

*** Test Cases ***
home_无参数
    ${resp}=    GET/users/home    ${token}
     ${sql_info}    userInfo      ${userId}
    Should Be Equal As Strings    ${resp['nickName']}    ${sql_info['nick_name']}    #赵爽
    Should Be Equal As Strings    ${resp['headImageUrl']}    ${sql_info['head_image_url']}
    # SELECT COUNT(lh.id) count FROM login_history lh,有1小时缓存
    Should Be True    ${resp['totle']}
    #用户注册时间倒序7个，也有缓存,与实时查到得不一致
    Should Not Be Empty    ${resp['icons']}

me_参数为空
    ${resp}    get/users/me    ${token}    ${EMPTY}    ${EMPTY}
    # 个人信息
    ${sql_info}    userInfo      ${userId}
    ${sql_alterinfo}    userAlterableInfo     ${userId}
    Should Be Equal As Strings    ${resp['nickName']}    ${sql_info['nick_name']}    #赵爽
    Should Be Equal As Strings    ${resp['headImageUrl']}    ${sql_info['head_image_url']}
    Should Be Equal As Strings    ${resp['examType']}    ${sql_alterinfo['secondary_categories']}
    should be equal as integers    ${resp['examTypeId']}    ${sql_alterinfo['exam_type_id']}
    Should Be Equal As integers    ${resp['levelNum']}    ${sql_alterinfo['level_num']}
    ${userIntegral}   evaluate    ${sql_alterinfo['user_integral']}-${sql_alterinfo['min_integral']}
    should Be Equal As integers    ${resp['userIntegral']}    ${userIntegral}
    ${maxIntegral}   evaluate    ${sql_alterinfo['max_integral']}-${sql_alterinfo['min_integral']}
    should be equal as integers    ${resp['maxIntegral']}    ${maxIntegral}
    Should Be Equal As Strings    ${resp['currentSubject']}    ${sql_alterinfo['subject_name']}
    ${sql_pkcount}    pkQuestionCount    ${userId}    ${sql_alterinfo['exam_type_id']}
    ${sql_answercount}    answerQuestionCount    ${userId}    ${sql_alterinfo['exam_type_id']}
    ${weeksum}    evaluate      ${sql_answercount['count_week']}+ ${sql_pkcount['count_week']}
    should be equal as integers    ${resp['weekAnswerSum']}    ${weeksum}
    ${weekcorrect}    evaluate      ${sql_answercount['correct_week']}+ ${sql_pkcount['correct_week']}
    should be equal as integers    ${resp['weekAnswerCorrect']}    ${weekcorrect}
    ${r}    getPercentDown     ${weekcorrect}    ${weeksum}
    should be equal as numbers    ${resp['weekAnswerCorrectRate']}    ${r}
    ${p}    getPercentDown    ${resp['userIntegral']}    ${resp['maxIntegral']}
    should be equal as numbers    ${resp['percent']}    ${p}
    # 考试信息
    Should Be Equal As Strings    ${resp['examTimeInfo']['examDate']}     ${sql_alterinfo['examTimeInfo']['examDate']}
    should be equal as numbers   ${resp['examTimeInfo']['intervalDays']}    ${sql_alterinfo['examTimeInfo']['intervalDays']}
    Should Be Equal As Strings    ${resp['examTimeInfo']['examType']}   ${sql_alterinfo['examTimeInfo']['examType']}

me_info_无参数
    ${resp}     GET/users/me/info    ${token}    ${EMPTY}
    ${sql_pkdetails}    PKQUESTIONCOUNT      ${userId}
    ${sql_answerdetails}    ANSWERQUESTIONCOUNT   ${userId}
    ${sum}    evaluate    ${sql_answerdetails['count']}+${sql_pkdetails['count']}
    should be equal as integers    ${resp['answerSum']}    ${sum}
    ${correct}     evaluate    ${sql_answerdetails['correct']}+${sql_pkdetails['correct']}
    ${rate}    getpercentdown    ${correct}    ${sum}
    should be equal as integers    ${resp['userAccuracy']}    ${rate}
    ${sql_cartogram}    userCartogram     ${userId}
    should be equal as integers    ${resp['diligent']}    ${sql_cartogram['diligent']}
    should be equal as integers    ${resp['userScoreRatio']}    ${sql_cartogram['score_ratio']}
    should be equal as integers    ${resp['answerDurationRatio']}    ${sql_cartogram['duration_ratio']}
    should be equal as integers    ${resp['accuracy']}    ${sql_cartogram['accuracy']}
    should be equal as integers    ${resp['answerRation']}    ${sql_cartogram['answer_ration']}
    ${sql_alterinfo}    userAlterableInfo     ${userId}
    should be equal as integers    ${resp['examTypeId']}    ${sql_alterinfo['exam_type_id']}
    ${sql_info}    userInfo      ${userId}
    Should Be Equal As Strings    ${resp['nickName']}    ${sql_info['nick_name']}
    Should Be Equal As Strings    ${resp['headImageUrl']}     ${sql_info['head_image_url']}

me_info_mark
    [Documentation]   B通过A的mark标识，查看A的详情
    get/users/share    ${token}    DATA    ${EMPTY}
    ${sql_share}    examShare      ${userId}
    ${resp}     GET/users/me/info    ${token2}    ${sql_share['share_mark']}
    ${sql_pkdetails}    PKQUESTIONCOUNT      ${userId}
    ${sql_answerdetails}    ANSWERQUESTIONCOUNT   ${userId}
    ${sum}    evaluate    ${sql_answerdetails['count']}+${sql_pkdetails['count']}
    should be equal as integers    ${resp['answerSum']}    ${sum}
    ${correct}     evaluate    ${sql_answerdetails['correct']}+${sql_pkdetails['correct']}
    ${rate}    getpercentdown    ${correct}    ${sum}
    should be equal as integers    ${resp['userAccuracy']}    ${rate}
    ${sql_cartogram}    userCartogram     ${userId}
    should be equal as integers    ${resp['diligent']}    ${sql_cartogram['diligent']}
    should be equal as integers    ${resp['userScoreRatio']}    ${sql_cartogram['score_ratio']}
    should be equal as integers    ${resp['answerDurationRatio']}    ${sql_cartogram['duration_ratio']}
    should be equal as integers    ${resp['accuracy']}    ${sql_cartogram['accuracy']}
    should be equal as integers    ${resp['answerRation']}    ${sql_cartogram['answer_ration']}
    ${sql_alterinfo}    userAlterableInfo     ${userId}
    should be equal as integers    ${resp['examTypeId']}    ${sql_alterinfo['exam_type_id']}
    ${sql_info}    userInfo      ${userId}
    Should Be Equal As Strings    ${resp['nickName']}    ${sql_info['nick_name']}
    Should Be Equal As Strings    ${resp['headImageUrl']}     ${sql_info['head_image_url']}