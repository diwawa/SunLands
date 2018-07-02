*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Resource          ../../API/QuestionType.robot
Resource          ../Resource/Question.robot
Variables         ../../Base.py
Resource          ../../API/UserAnswer.robot

*** Test Cases ***
questionTypes_chapters
    [Documentation]    章节列表 （章节练习/只做错题/我的收藏/我的错题）
    [Tags]    Run
    ${resp}    get/questionTypes/chapters    ${token}    CHAPTER_PRACTICE
    should be equal as integers    ${resp['errorSum']}    0
    ${sql_chapter}    chapter    ${userId}
    ${len}    evaluate    len(${resp['chapters']})
    : FOR    ${x}    IN RANGE    ${len}
    \    should be equal as integers    ${resp['chapters'][${x}]['totle']}    ${sql_chapter['question_sum'][${x}]}
    \    should be equal as integers    ${resp['chapters'][${x}]['people']}    ${sql_chapter['done_sum'][${x}]}
    \    should be equal as integers    ${resp['chapters'][${x}]['current']}    ${sql_chapter['complete_question_sum'][${x}]}
    \    should be equal as integers    ${resp['chapters'][${x}]['chapterId']}    ${sql_chapter['id'][${x}]}
    \    should be equal as strings    ${resp['chapters'][${x}]['chapterName']}    ${sql_chapter['chapter_name'][${x}]}

questionTypes_examQuestion
    [Documentation]    题目详情 (8种类型)
    [Tags]    Run
    ${sql_chapter}    chapter    ${userId}
    set suite variable    ${chapterId}    ${sql_chapter['id'][0]}
    ${resp}    get/questionTypes/examQuestion    ${token}    CHAPTER_PRACTICE    0    0    0
    ...    ${chapterId}
    Comment    ${len}    evaluate    len(${resp})
    ${len}    Get Length    ${resp}
    ${questionIds}    create list
    : FOR    ${x}    IN RANGE    ${len}
    \    ${schedule}    evaluate    ${sql_chapter['schedule'][0]}+${x}
    \    should be equal as integers    ${resp[${x}]['questionId']}    ${sql_chapter['question_ids'][0][${schedule}]}
    \    insert into list    ${questionIds}    ${x}    ${resp[${x}]['questionId']}
    \    ${sql_question}    Question    ${resp[${x}]['questionId']}
    \    should be equal as strings    ${resp[${x}]['questionType']}    ${sql_question['question_type']}
    \    should be equal as strings    ${resp[${x}]['questionDesc']}    ${sql_question['question_desc']}
    \    should be equal as integers    ${resp[${x}]['number']}    ${x+1}
    \    ${collect}    set variable if    ${resp[${x}]['questionId']}in${sql_chapter['exam_question_id'][0]}    ${True}    ${False}
    \    Should Be Equal    ${resp[${x}]['collect']}    ${collect}
    \    断言选项    ${resp[${x}]["options"]}    ${resp[${x}]['questionId']}
    set suite variable    ${questionIds}

userAnswer_userAnswerId
    [Documentation]    获取判题信息,历史答题记录
    [Tags]    Run
    ${data}    RE_CHAPTER_PRACTICE    ${chapterId}
    Log    ${data}
    ${questions}    Set Variable    ${data[1]['questions']}
    ${userAnswerId}    set variable    ${data[0]['userAnswerId']}
    ${resp}    get/userAnswer/{userAnswerId}    ${token}    ${userAnswerId}    answerDone
    should be equal as integers    ${resp['userAnswerId']}    ${userAnswerId}
    should be equal as integers    ${resp['userId']}    ${userId}
    should be equal as strings    ${resp['planType']}    CHAPTER_PRACTICE
    ${sql_alinfo}    userAlterableInfo    ${userId}
    ${currentIntegral}    evaluate    ${sql_alinfo['user_integral']}-${sql_alinfo['min_integral']}
    should be equal as integers    ${resp['levelView']['currentIntegral']}    ${currentIntegral}
    ${maxIntegral}    evaluate    ${sql_alinfo['max_integral']}-${sql_alinfo['min_integral']}
    should be equal as integers    ${resp['levelView']['maxIntegral']}    ${maxIntegral}
    should be equal as strings    ${resp['levelView']['levelNum']}    ${sql_alinfo['level_num']}
    should be equal as strings    ${resp['levelView']['levelName']}    ${sql_alinfo['level_name']}
    ${len}    Get Length    ${resp['questions']}
    ${correctnum}    set variable    0
    : FOR    ${x}    IN RANGE    ${len}
    \    ${answerDate}    convertTimestamp    ${resp['questions'][${x}]['answerDate']}
    \    Comment    Should Be Equal As Strings    ${answerDate}    1528449161
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
