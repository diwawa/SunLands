*** Settings ***
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Library           ../../Common/PrivateMethod.py
Resource          ../../API/PkArena.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/PkArena.py


*** Keywords ***
PK_答题_结果
    [Arguments]   ${pkLogId}    ${isCorrect_1}    ${isCorrect_2}    ${currentUserDuration_1}    ${currentUserDuration_2}
    [Documentation]     pk日志 ,是否回答正确（list），用时（list），返回pk结果
    ${sql_pklog}    pklog      ${pkLogId}
    ${questionId}    set variable      ${EMPTY}
    ${scoreSum_1}    set variable     0
    ${scoreSum_2}    set variable     0
    ${scoreList_1}    create list
    ${scoreList_2}    create list
    :For    ${x}    In Range    ${sql_pklog['question_count']}
    \    ${questionId}    set variable if   ${x}==0    ${EMPTY}    ${sql_pklog['question_ids'][${x}-1]}
    \    ${resp}    get/pkArena/pkQuestions    ${token}    ${pkLogId}    ${questionId}
    \    should be equal as integers    ${resp['questionSum']}    ${sql_pklog['question_count']}
    \    ${questionCurrentNum}    evaluate     ${x}+1
    \    should be equal as integers    ${resp['questionCurrentNum']}    ${questionCurrentNum}
    \    should be equal as integers    ${resp['questionId']}    ${sql_pklog['question_ids'][${x}]}
    \    ${questionId}    set variable      ${resp['questionId']}
    \    ${result_1}    PK_每题_得分    ${token}    ${pkLogId}    ${x}    ${isCorrect_1[${x}]}    ${currentUserDuration_1[${x}]}    ${scoreSum_1}
    \    ${scoreSum_1}    set variable      ${result_1[0]}
    \    insert into list      ${scoreList_1}    ${x}    ${result_1[1]}
    \    ${result_2}    PK_每题_得分    ${token2}    ${pkLogId}    ${x}    ${isCorrect_2[${x}]}    ${currentUserDuration_2[${x}]}    ${scoreSum_2}
    \    ${scoreSum_2}    set variable      ${result_2[0]}
    \    insert into list      ${scoreList_2}    ${x}    ${result_2[1]}
    \    ${resp}    get/pkArena/targetAnswerDetail    ${token}    ${pkLogId}    ${questionId}
    \    should be equal as strings    ${resp['targetUserAnswer']}    ${result_2[2]}
    \    should be equal as integers    ${resp['targetUserScore']}    ${result_2[1]}
    \    should be equal as integers    ${resp['targetUserDuration']}    ${currentUserDuration_2[${x}]}
    \    should be equal as strings    ${resp['correctAnswer']}     ${result_2[3]}
    \    should be equal as integers    ${resp['targetUserScoreSum']}   ${result_2[0]}
    \    ${resp}    get/pkArena/targetAnswerDetail    ${token2}    ${pkLogId}    ${questionId}
    \    should be equal as strings    ${resp['targetUserAnswer']}    ${result_1[2]}
    \    should be equal as integers    ${resp['targetUserScore']}    ${result_1[1]}
    \    should be equal as integers    ${resp['targetUserDuration']}    ${currentUserDuration_1[${x}]}
    \    should be equal as strings    ${resp['correctAnswer']}     ${result_1[3]}
    \    should be equal as integers    ${resp['targetUserScoreSum']}   ${result_1[0]}
    log    ${scoreList_1}
    log    ${scoreList_2}
    ${result}    getPKresult    ${scoreList_1}    ${scoreList_2}
    ${response}    create list     ${result}    ${scoreSum_1}    ${scoreSum_2}
    [Return]   ${response}

PK_随机匹配_结果
    [Arguments]   ${user_id}    ${pkLogId}    ${isCorrect_1}    ${currentUserDuration_1}
    [Documentation]     随机匹配者的id，pk日志 ,是否回答正确（list），用时（list），返回pk结果
    ${sql_pklog}    pklog      ${pkLogId}
    ${questionId}    set variable      ${EMPTY}
    ${scoreSum_1}    set variable     0
    ${scoreSum_2}    set variable     0
    ${scoreList_1}    create list
    ${scoreList_2}    create list
    :For    ${x}    In Range    ${sql_pklog['question_count']}
    \    ${questionId}    set variable if   ${x}==0    ${EMPTY}    ${sql_pklog['question_ids'][${x}-1]}
    \    ${resp}    get/pkArena/pkQuestions    ${token}    ${pkLogId}    ${questionId}
    \    should be equal as integers    ${resp['questionSum']}    ${sql_pklog['question_count']}
    \    ${questionCurrentNum}    evaluate     ${x}+1
    \    should be equal as integers    ${resp['questionCurrentNum']}    ${questionCurrentNum}
    \    should be equal as integers    ${resp['questionId']}    ${sql_pklog['question_ids'][${x}]}
    \    ${questionId}    set variable      ${resp['questionId']}
    \    ${result_1}    PK_每题_得分    ${token}    ${pkLogId}    ${x}    ${isCorrect_1[${x}]}    ${currentUserDuration_1[${x}]}    ${scoreSum_1}
    \    ${scoreSum_1}    set variable      ${result_1[0]}
    \    insert into list      ${scoreList_1}    ${x}    ${result_1[1]}
    \    ${sql_pklogd}    pkLogDetails    ${user_id}    ${pkLogId}    ${questionId}
    \    insert into list      ${scoreList_2}    ${x}    ${sql_pklogd['score_add']}
    \    ${scoreSum_2}    evaluate    ${scoreSum_2}+${sql_pklogd['score_add']}
    log    ${scoreList_1}
    log    ${scoreList_2}
    ${result}    getPKresult    ${scoreList_1}    ${scoreList_2}
    ${response}    create list     ${result}    ${scoreSum_1}    ${scoreSum_2}
    [Return]   ${response}

PK_创造记录_结果
    [Arguments]   ${pkLogId}    ${isCorrect_1}    ${currentUserDuration_1}
    [Documentation]     pk日志 ,是否回答正确（list），用时（list），返回pk结果
    ${sql_pklog}    pklog      ${pkLogId}
    ${questionId}    set variable      ${EMPTY}
    ${scoreSum_1}    set variable     0
    ${scoreList_1}    create list
    :For    ${x}    In Range    ${sql_pklog['question_count']}
    \    ${questionId}    set variable if   ${x}==0    ${EMPTY}    ${sql_pklog['question_ids'][${x}-1]}
    \    ${resp}    get/pkArena/pkQuestions    ${token}    ${pkLogId}    ${questionId}
    \    should be equal as integers    ${resp['questionSum']}    ${sql_pklog['question_count']}
    \    ${questionCurrentNum}    evaluate     ${x}+1
    \    should be equal as integers    ${resp['questionCurrentNum']}    ${questionCurrentNum}
    \    should be equal as integers    ${resp['questionId']}    ${sql_pklog['question_ids'][${x}]}
    \    ${questionId}    set variable      ${resp['questionId']}
    \    ${result_1}    PK_每题_得分    ${token}    ${pkLogId}    ${x}    ${isCorrect_1[${x}]}    ${currentUserDuration_1[${x}]}    ${scoreSum_1}
    \    ${scoreSum_1}    set variable      ${result_1[0]}
    \    insert into list      ${scoreList_1}    ${x}    ${result_1[1]}
    ${response}    create list     COMPLETE    ${scoreSum_1}    ${scoreList_1}
    [Return]   ${response}


PK_每题_得分
    [Arguments]      ${token}    ${pkLogId}    ${questionNum}    ${isCorrect}    ${currentUserDuration}    ${currentUserScoreSum}
    [Documentation]      pk日志，第几题从0开始，是否回答正确，用时，当前总分， 返回得分
	${pkAnswerPostParam}    copy dictionary       ${pkArena_pkAnswer_param['pkAnswerPostParam']}
	set to dictionary      ${pkAnswerPostParam}    pkLogId    ${pkLogId}
	set to dictionary      ${pkAnswerPostParam}    currentUserDuration    ${currentUserDuration}
	${sql_pklog}    pklog      ${pkLogId}
	${questionId}    set variable     ${sql_pklog['question_ids'][${questionNum}]}
	set to dictionary      ${pkAnswerPostParam}    questionId    ${questionId}
	${sql_question}    question      ${questionId}
	${options_desc}    set variable     ${sql_question['options_desc']}
	${keys}     get dictionary keys      ${options_desc}
	remove values from list      ${keys}    ${sql_question['correct_answer']}
	${error_answer}    getRandomStr      ${keys}
	${correct_answer}    set variable     ${sql_question['correct_answer']}
	${currentUserAnswer}    set variable if     ${isCorrect}==1    ${correct_answer}    ${error_answer}
	set to dictionary      ${pkAnswerPostParam}    currentUserAnswer     ${currentUserAnswer}
	${resp}    post/pkArena/pkAnswer    ${token}    ${pkAnswerPostParam}
	should be equal as strings    ${resp['correctAnswer']}    ${correct_answer}
	${num}    evaluate      ${questionNum}+1
	${isLast}    set variable if     ${num}==${sql_pklog['question_count']}    ${True}      ${False}
	${currentUserScore}    getPkScore    ${correct_answer}    ${currentUserAnswer}    ${currentUserDuration}    ${isLast}
	should be equal as integers    ${resp['currentUserScore']}    ${currentUserScore}
	${currentUserScoreSum}    evaluate      ${currentUserScoreSum}+${currentUserScore}
	should be equal as strings    ${resp['currentUserScoreSum']}    ${currentUserScoreSum}
	${result}    create list       ${currentUserScoreSum}    ${currentUserScore}    ${currentUserAnswer}    ${correct_answer}
	[Return]    ${result}

get/users/share_shareMark
	[Arguments]    ${token}    ${shareType}    ${shareMark}
	[Documentation]    小程序分享：接口文档中没有此接口
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    shareType    ${shareType}    shareMark    ${shareMark}
	${resp}    get request    exam    /users/share    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}