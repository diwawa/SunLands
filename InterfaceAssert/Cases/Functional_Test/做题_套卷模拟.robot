*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Resource          ../../API/QuestionType.robot
Resource          ../Resource/Question.robot
Variables         ../../Base.py
Resource          ../../API/UserAnswer.robot

*** Test Cases ***
questionTypes_examPapers
    [Documentation]    套卷模拟列表
    [Tags]    Run
    ${resp}    get/questionTypes/examPapers    ${token}
    ${sql_paper}    examPapers    ${userId}
    ${len}    Get Length    ${resp}
    : FOR    ${x}    IN RANGE    ${len}
    \    should be equal as integers    ${resp[${x}]['totle']}    ${sql_paper['question_sum'][${x}]}
    \    should be equal as integers    ${resp[${x}]['people']}    ${sql_paper['done_sum'][${x}]}
    \    should be equal as integers    ${resp[${x}]['examPapersId']}    ${sql_paper['id'][${x}]}
    \    should be equal as strings    ${resp[${x}]['examPaperName']}    ${sql_paper['exam_paper_name'][${x}]}
    \    ${current}    set variable if    ${sql_paper['isDone'][${x}]}==0    0    ${sql_paper['question_sum'][${x}]}
    \    should be equal as integers    ${resp[${x}]['current']}    ${current}
    #    Should Be Equal    ${resp[${x}]['finish']}    ${sql_paper['isDone'][${x}]}    # 冗余

questionTypes_examQuestion
    [Documentation]    题目详情 (8种类型)
    [Tags]    Run
    ${sql_paper}    examPapers    ${userId}
    set suite variable    ${examPapersId}    ${sql_paper['id'][0]}
    ${resp}    get/questionTypes/examQuestion    ${token}    SIMULATION_EXAM    0    0    0
    ...    ${examPapersId}
    ${len}    Get Length    ${resp}
    : FOR    ${x}    IN RANGE    ${len}
    \    should be equal as integers    ${resp[${x}]['questionId']}    ${sql_paper['questonIds'][0][${x}]}
    \    ${sql_question}    Question    ${resp[${x}]['questionId']}
    \    Should Be Equal    ${resp[${x}]['questionType']}    ${sql_question['question_type']}
    \    Should Be Equal    ${resp[${x}]['questionDesc']}    ${sql_question['question_desc']}
    \    Should Be Equal    ${resp[${x}]['number']}    ${x+1}
    \    ${collect}    set variable if    ${resp[${x}]['questionId']}in${sql_paper['exam_question_id']}    ${True}    ${False}
    \    Should Be Equal    ${resp[${x}]['collect']}    ${collect}
    \    断言选项    ${resp[${x}]["options"]}    ${resp[${x}]['questionId']}

userAnswer_userAnswerId
    [Documentation]    获取判题信息,历史答题记录
    [Tags]    Run
    ${data}    RE_SIMULATION_EXAM    ${examPapersId}
    ${questions}    Set Variable    ${data[1]['questions']}
    ${userAnswerId}    set variable    ${data[0]['userAnswerId']}
    Comment    ${userAnswerId}    set variable    ${data['userAnswerId']}
    ${resp}    get/userAnswer/{userAnswerId}    ${token}    ${userAnswerId}    answerDone
    should be equal as integers    ${resp['userAnswerId']}    ${userAnswerId}
    should be equal as integers    ${resp['userId']}    ${userId}
    should be equal as integers    ${resp['examPaperId']}    ${examPapersId}
    should be equal as strings    ${resp['planType']}    SIMULATION_EXAM
    ${sql_alinfo}    userAlterableInfo    ${userId}
    ${currentIntegral}    evaluate    ${sql_alinfo['user_integral']}-${sql_alinfo['min_integral']}
    should be equal as integers    ${resp['levelView']['currentIntegral']}    ${currentIntegral}
    ${maxIntegral}    evaluate    ${sql_alinfo['max_integral']}-${sql_alinfo['min_integral']}
    should be equal as integers    ${resp['levelView']['maxIntegral']}    ${maxIntegral}
    should be equal as strings    ${resp['levelView']['levelNum']}    ${sql_alinfo['level_num']}
    should be equal as strings    ${resp['levelView']['levelName']}    ${sql_alinfo['level_name']}
    ${sql_paper}    examPapers    ${userId}
    ${questionIds}    set variable    ${sql_paper['questonIds'][0]}
    ${len}    set variable    ${sql_paper['question_sum'][0]}
    ${correctnum}    set variable    ${0}
    : FOR    ${x}    IN RANGE    ${len}
    \    ${answerDate}    convertTimestamp    ${resp['questions'][${x}]['answerDate']}
    \    Comment    should be equal as integers    ${answerDate}    1528449161
    \    should be equal as integers    ${resp['questions'][${x}]['questionId']}    ${questionIds[${x}]}
    \    ${sql_question}    Question    ${resp['questions'][${x}]['questionId']}
    \    Should Be Equal    ${resp['questions'][${x}]['correctAnswer']}    ${sql_question['correct_answer']}
    \    should be equal as strings    ${resp['questions'][${x}]['correctAnswerDesc']}    ${sql_question['correct_answer_desc']}
    \    should be equal as strings    ${resp['questions'][${x}]['answerDesc']}    ${questions[${x}]['answerDesc']}
    \    should be equal as integers    ${resp['questions'][${x}]['duration']}    2
    \    ${answerCorrect}    set variable if    "${sql_question['correct_answer']}"=="${questions[${x}]['answerDesc']}"    ${True}    ${False}
    \    Should Be Equal    ${resp['questions'][${x}]['answerCorrect']}    ${answerCorrect}
    \    ${correctnum_1}    evaluate    ${correctnum}+1
    \    ${correctnum}    set variable if    ${answerCorrect}    ${correctnum_1}    ${correctnum}
    should be equal as integers    ${resp['duration']}    50
    ${wrongCount}    evaluate    ${len}-(${correctnum})
    should be equal as integers    ${resp['wrongCount']}    ${wrongCount}
    ${correctRate}    getPercent    ${correctnum}    ${len}    0
    should be equal as integers    ${resp['correctRate']}    ${correctRate}
    ${wrongRate}    evaluate    100-${correctRate}
    should be equal as integers    ${resp['wrongRate']}    ${wrongRate}

questionTypes_examPapers_history
    [Documentation]    套卷模拟历史纪录
    [Tags]    Run
    ${resp}    get/questionTypes/examPapers/history    ${token}
    ${sql_paper}    examPapers    ${userId}
    ${len}    Get Length    ${resp}
    : FOR    ${x}    IN RANGE    ${len}
    \    ${finishTime}    convertseconds    ${resp[${x}]['finishTime']}
    \    should be equal as integers    ${finishTime}    ${sql_paper['history']['duration'][${x}]}
    \    should be equal as integers    ${resp[${x}]['userAnswerId']}    ${sql_paper['history']['id'][${x}]}
    \    should be equal as integers    ${resp[${x}]['examPapersId']}    ${sql_paper['history']['exam_paper_id'][${x}]}
    \    #    should be equal as integers    ${resp[${x}]['score']}    ${sql_paper['history']['score'][${x}]}
    \    should be equal as integers    ${resp[${x}]['unfinishedNum']}    0
    \    ${date}    convertTimestamp    ${resp[${x}]['date']}
    \    should be equal as integers    ${date}    ${sql_paper['history']['create_date'][${x}]}
    \    should be equal as strings    ${resp[${x}]['examPaperName']}    ${sql_paper['history']['exam_paper_name'][${x}]}

*** Keywords ***
断言选项
    [Arguments]    ${options}    ${questionId}
    ${sql_question}    Question    ${questionId}
    ${len_options}    Get Length    ${options}
    ${options_desc}    set variable    ${sql_question['options_desc']}
    ${option_keys}    get dictionary keys    ${options_desc}
    sort list    ${option_keys}
    : FOR    ${x}    IN RANGE    ${len_options}
    \    should be equal as strings    ${options[${x}]['option']}    ${option_keys[${x}]}
    \    ${sql_optionDesc}    get from dictionary    ${options_desc}    ${option_keys[${x}]}
    \    should be equal as strings    ${options[${x}]['optionDesc']}    ${sql_optionDesc}
    \    should not be true    ${options[${x}]['selected']}
    \    should be equal as strings    ${options[${x}]['stutus']}    NOTHING
