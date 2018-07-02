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
    ${resp}    get/questionTypes/chapters    ${token}    MY_WRONG
    ${sql_chapter}    chapter    ${userId}
    ${len}    evaluate    len(${resp['chapters']})
    ${errorSum}    set variable    0
    : FOR    ${x}    IN RANGE    ${len}
    \    should be equal as integers    ${resp['chapters'][${x}]['chapterId']}    ${sql_chapter['id'][${x}]}
    \    should be equal as strings    ${resp['chapters'][${x}]['chapterName']}    ${sql_chapter['chapter_name'][${x}]}
    \    ${sql_last}    lastUserQuestion    ${userId}    ${resp['chapters'][${x}]['chapterId']}
    \    should be equal as integers    ${resp['chapters'][${x}]['errorNum']}    ${sql_last['errorSum']}
    \    ${errorSum}    evaluate    ${errorSum}+${resp['chapters'][${x}]['errorNum']}
    should be equal as integers    ${resp['errorSum']}    ${errorSum}

questionTypes_myQuestionStem_chapterId
    [Documentation]    我的收藏列表/我的错题列表
    [Tags]    Run
    ${sql_chapter}    chapter    ${userId}
    set suite variable    ${chapterId}    ${sql_chapter['id'][0]}
    ${resp}    get/questionTypes/myQuestionStem/{chapterId}    ${token}    ${chapterId}    MY_WRONG
    set suite variable    ${questionId}    ${resp[0]['questionId']}
    ${len}    evaluate    len(${resp})
    ${sql_last}    lastUserQuestion    ${userId}    ${chapterId}
    : FOR    ${x}    IN RANGE    ${len}
    \    should be equal as strings    ${resp[${x}]['questionId']}    ${sql_last['question_id_my'][${x}]}
    \    ${sql_last_2}    lastUserQuestion    ${userId}    ${chapterId}    ${resp[${x}]['questionId']}
    \    Should Be Equal    ${resp[${x}]['errorNum']}    ${sql_last_2['error_num']}
    \    ${sql_question}    Question    ${resp[${x}]['questionId']}
    \    Should Be Equal    ${resp[${x}]['questionDesc']}    ${sql_question['question_desc']}
    #    Should Be Equal    ${resp[${x}]['collectNum']}    ${sql_chapter['collection_sum'][0]}

questionTypes_examQuestion
    [Documentation]    题目详情 (8种类型)
    [Tags]    Run
    ${sql_chapter}    chapter    ${userId}
    ${sql_last}    lastUserQuestion    ${userId}    ${chapterId}
    ${resp}    get/questionTypes/examQuestion    ${token}    MY_WRONG    1    1    1
    ...    ${questionId}
    ${len}    evaluate    len(${resp})
    : FOR    ${x}    IN RANGE    ${len}
    \    should be equal as integers    ${resp[${x}]['questionId']}    ${sql_last['question_id_my'][${x}]}
    \    ${sql_question}    Question    ${resp[${x}]['questionId']}
    \    should be equal as strings    ${resp[${x}]['questionType']}    ${sql_question['question_type']}
    \    should be equal as strings    ${resp[${x}]['questionDesc']}    ${sql_question['question_desc']}
    \    should be equal as integers    ${resp[${x}]['number']}    ${x+1}
    \    ${collect}    set variable if    ${resp[${x}]['questionId']}in${sql_chapter['exam_question_id'][0]}    ${True}    ${False}
    \    Should Be Equal    ${resp[${x}]['collect']}    ${collect}
    \    should be equal as strings    ${resp[${x}]['answer']['correctAnswerDesc']}    ${sql_question['correct_answer_desc']}
    \    should be equal as strings    ${resp[${x}]['answer']['correctAnswer']}    ${sql_question['correct_answer']}
    \    ${sql_last_1}    lastUserQuestion    ${userId}    ${chapterId}    ${resp[${x}]['questionId']}
    \    should be equal    ${resp[${x}]['answer']['newestCorrect']}    ${sql_last_1['answer_correct']}
    \    should be equal as integers    ${resp[${x}]['answer']['errorNum']}    ${sql_last_1['error_num']}
    \    should be equal as integers    ${resp[${x}]['answer']['errorPeople']}    ${sql_question['errorPeopleCount']}
    \    Should Be Equal    ${resp[${x}]['answer']['errorRate']}    ${sql_question['errorRate']}
    \    Should Be Equal    ${resp[${x}]['answer']['errorFatherRate']}    ${sql_question['errorFatherRate']}
    \    断言选项    ${resp[${x}]["options"]}    ${resp[${x}]['questionId']}

*** Keywords ***
断言选项
    [Arguments]    ${options}    ${questionId}
    ${sql_question}    Question    ${questionId}
    ${len_options}    evaluate    len(${options})
    ${options_desc}    set variable    ${sql_question['options_desc']}
    ${option_keys}    get dictionary keys    ${options_desc}
    ${sql_last_2}    lastUserQuestion    ${userId}    ${chapterId}    ${questionId}
    sort list    ${option_keys}
    : FOR    ${x}    IN RANGE    ${len_options}
    \    should be equal as strings    ${options[${x}]['option']}    ${option_keys[${x}]}
    \    ${sql_optionDesc}    get from dictionary    ${options_desc}    ${option_keys[${x}]}
    \    should be equal as strings    ${options[${x}]['optionDesc']}    ${sql_optionDesc}
    \    ${selected}    set variable if    "${options[${x}]['option']}"in"${sql_last_2['answer_desc']}"    ${True}    ${False}
    \    should be equal    ${options[${x}]['selected']}    ${selected}
    \    ${stutus_1}    set variable if    "${options[${x}]['option']}" in "${sql_question['correct_answer']}"    CORRECT    NOTHING
    \    ${stutus_2}    set variable if    ${selected} and "${options[${x}]['option']}" not in "${sql_question['correct_answer']}"    ERROR    ${stutus_1}
    \    ${stutus}    set variable if    ${selected} and "${options[${x}]['option']}" in "${sql_question['correct_answer']}"    HALF_CORRECT    ${stutus_2}
    \    should be equal as strings    ${options[${x}]['stutus']}    ${stutus}
