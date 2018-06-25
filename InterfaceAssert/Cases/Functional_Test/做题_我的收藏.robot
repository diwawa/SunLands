*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Library           DateTime
Resource          ../../API/QuestionType.robot
Resource          ../Resource/Question.robot
Variables         ../../Base.py
Resource          ../../API/UserAnswer.robot
Resource          ../../API/Users.robot


*** Keywords ***
断言选项
    [Arguments]      ${options}    ${questionId}
    ${sql_question}    question    ${questionId}
    ${len_options}    evaluate     len(${options})
    ${options_desc}    to json     ${sql_question['options_desc']}
    ${option_keys}    get dictionary keys    ${options_desc}
    ${sql_last_2}    lastUserQuestion    ${userId}    ${chapterId}    ${questionId}
    sort list    ${option_keys}
    :FOR    ${x}    IN RANGE     ${len_options}
    \    should be equal as strings      ${options[${x}]['option']}   ${option_keys[${x}]}
    \    ${sql_optionDesc}      get from dictionary       ${options_desc}      ${option_keys[${x}]}
    \    should be equal as strings      ${options[${x}]['optionDesc']}     ${sql_optionDesc}
    \    should be equal      ${options[${x}]['selected']}    ${False}
    \    ${stutus}    set variable if       "${options[${x}]['option']}" in "${sql_question['correct_answer']}"      CORRECT    NOTHING
    \   should be equal as strings      ${options[${x}]['stutus']}     ${stutus}

*** Test Cases ***
users_conllects_questionId_1
	[Documentation]    用户收藏，取消第一章全部收藏题目
	[Tags]    Run
	${sql_chapter}    chapter    ${userId}
	${questionIds}      set variable      ${sql_chapter['exam_question_id'][0]}
	${len}    evaluate  len(${questionIds})
	:For    ${x}    In Range    ${len}
	\    ${questionId}     set variable    ${questionIds[${x}]}
	\    post/users/conllects/{questionId}    ${token}    ${questionId}

users_conllects_questionId_2
	[Documentation]    用户收藏，点击收藏
	[Tags]    Run
	${sql_chapter}    chapter    ${userId}
	${questionIds}    getRandomList     ${sql_chapter['question_ids'][0]}
	${len}    evaluate  len(${questionIds})
	:For    ${x}    In Range    ${len}
	\    ${questionId}     set variable    ${questionIds[${x}]}
	\    post/users/conllects/{questionId}    ${token}    ${questionId}
    \    sleep    1
    set suite variable      ${questionId_0}     ${questionIds[0]}

users_conllects_questionId_3
	[Documentation]    用户收藏，取消收藏后在重新收藏
	[Tags]    Run
	post/users/conllects/{questionId}    ${token}    ${questionId_0}
	sleep    1
	post/users/conllects/{questionId}    ${token}    ${questionId_0}
	${date}    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
	${now}    converttimestamp     ${date}
	sleep    2
	${sql_chapter}    chapter    ${userId}
	should be equal as integers      ${questionId_0}    ${sql_chapter['exam_question_id'][0][0]}
	${modifi_date}     set variable      ${sql_chapter['modifi_date'][0][0]}
	should be true      ${now}-${modifi_date}<5

questionTypes_chapters
	[Documentation]    章节列表 （章节练习/只做错题/我的收藏/我的错题）
	[Tags]    Run
	${resp}    get/questionTypes/chapters    ${token}    MY_COLLECT
	${sql_chapter}    chapter    ${userId}
    ${len}    evaluate   len(${resp['chapters']})
    ${errorSum}    set variable    0
    :For    ${x}    In Range    ${len}
	\    should be equal as integers    ${resp['chapters'][${x}]['collectNum']}    ${sql_chapter['collection_sum'][${x}]}
	\    should be equal as integers    ${resp['chapters'][${x}]['chapterId']}    ${sql_chapter['id'][${x}]}
	\    should be equal as strings    ${resp['chapters'][${x}]['chapterName']}    ${sql_chapter['chapter_name'][${x}]}

questionTypes_myQuestionStem_chapterId
	[Documentation]    我的收藏列表/我的错题列表
	[Tags]    Run
	${sql_chapter}    chapter    ${userId}
	set suite variable      ${chapterId}    ${sql_chapter['id'][0]}
	${resp}    get/questionTypes/myQuestionStem/{chapterId}    ${token}    ${chapterId}    MY_COLLECT
	set suite variable      ${questionId}    ${resp[0]['questionId']}
    ${len}    evaluate    len(${resp})
    :For    ${x}    In Range     ${len}
    \    ${date}    convertTimestamp      ${resp[${x}]['date']}
    \    should be equal as integers    ${date}    ${sql_chapter['modifi_date'][0][${x}]}
    \    should be equal as strings    ${resp[${x}]['questionId']}    ${sql_chapter['exam_question_id'][0][${x}]}
    \    ${sql_question}    question     ${resp[${x}]['questionId']}
    \    should be equal as strings    ${resp[${x}]['questionDesc']}    ${sql_question['question_desc']}


questionTypes_examQuestion
	[Documentation]    题目详情 (8种类型)
	[Tags]    Run
	${sql_chapter}    chapter    ${userId}
	${resp}    get/questionTypes/examQuestion    ${token}    MY_COLLECT    1    0    0    ${questionId}
	${len}    evaluate    len(${resp})
	:For    ${x}    In Range    ${len}
	\    should be equal as integers    ${resp[${x}]['questionId']}    ${sql_chapter['exam_question_id'][0][${x}]}
	\    ${sql_question}    question    ${resp[${x}]['questionId']}
	\    should be equal as strings    ${resp[${x}]['questionType']}    ${sql_question['question_type']}
	\    should be equal as strings    ${resp[${x}]['questionDesc']}    ${sql_question['question_desc']}
	\    should be equal as integers    ${resp[${x}]['number']}    ${x+1}
	\    should be true    ${resp[${x}]['collect']}
	\    should be equal as strings    ${resp[${x}]['answer']['correctAnswerDesc']}    ${sql_question['correct_answer_desc']}
	\    should be equal as strings    ${resp[${x}]['answer']['correctAnswer']}     ${sql_question['correct_answer']}
    \    ${sql_last_1}    lastUserQuestion    ${userId}    ${chapterId}    ${resp[${x}]['questionId']}
	\    should be equal    ${resp[${x}]['answer']['newestCorrect']}    ${sql_last_1['answer_correct']}
	\    should be equal as integers    ${resp[${x}]['answer']['errorNum']}    ${sql_last_1['error_num']}
	\    should be equal as integers    ${resp[${x}]['answer']['errorPeople']}    ${sql_question['errorPeopleCount']}
	\    Should Be Equal    ${resp[${x}]['answer']['errorRate']}    ${sql_question['errorRate']}
	\    Should Be Equal    ${resp[${x}]['answer']['errorFatherRate']}    ${sql_question['errorFatherRate']}
	\    断言选项       ${resp[${x}]["options"]}    ${resp[${x}]['questionId']}
