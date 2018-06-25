*** Settings ***
Library           ../../Common/GetSQL.py
Resource          ../../API/QuestionType.robot
Variables         ../../Base.py
Resource          ../../API/UserAnswer.robot
Variables         ../../Datas/Params/UserAnswer.py
Variables         ../../Datas/Response/UserAnswer.py
Resource          ../../API/AnswerPlan.robot


*** Keywords ***
RE_DailyPractice
	[Documentation]    每日一练答题
	[Arguments]      ${assignmentList}
	${answerPlans}    get/answerPlans    ${token}
	${bodyParams}    copy dictionary      ${userAnswer_param['userAnswerPostParam']}
	${len}    evaluate     len(${assignmentList})
	:FOR    ${x}    IN RANGE     ${len}
	\    set to dictionary    ${bodyParams}    userId    ${userId}
	\    set to dictionary    ${bodyParams}    answerPlanId    ${answerPlans['answerPlanId']}
	\    set to dictionary    ${bodyParams}    planType    DAILY_PRACTICE
	\    ${assignmentId}    get from dictionary      ${assignmentList[${x}]}    assignmentId
    \    set to dictionary    ${bodyParams}    assignmentId    ${assignmentId}
    \    ${examQuestion}    get/questionTypes/examQuestion    ${token}    DAILY_PRACTICE    0    0    0    ${assignmentId}
    \    ${questions}    RE_Questions   ${examQuestion}
    \    set to dictionary    ${bodyParams}    questions    ${questions}
    \    log     ${bodyParams}
    \    ${resp}    post/userAnswer    ${token}    ${bodyParams}

RE_SIMULATION_EXAM
	[Documentation]    套卷模拟
	[Arguments]      ${examPapersId}
	${answerPlans}    get/answerPlans    ${token}
	${bodyParams}    copy dictionary      ${userAnswer_param['userAnswerPostParam']}
	set to dictionary    ${bodyParams}    userId    ${userId}
	set to dictionary    ${bodyParams}    answerPlanId    ${answerPlans['answerPlanId']}
	set to dictionary    ${bodyParams}    planType    SIMULATION_EXAM
    set to dictionary    ${bodyParams}    examPaperId    ${examPapersId}
    ${examQuestion}    get/questionTypes/examQuestion    ${token}    SIMULATION_EXAM   0    0    0    ${examPapersId}
    ${questions}    RE_Questions   ${examQuestion}
    set to dictionary    ${bodyParams}    questions    ${questions}
    log     ${bodyParams}
    ${resp}    post/userAnswer    ${token}    ${bodyParams}
    [Return]    ${resp}

RE_CHAPTER_PRACTICE
	[Documentation]   章节练习
	[Arguments]      ${chapterId}
	${answerPlans}    get/answerPlans    ${token}
	${bodyParams}    copy dictionary      ${userAnswer_param['userAnswerPostParam']}
	set to dictionary    ${bodyParams}    userId    ${userId}
	set to dictionary    ${bodyParams}    answerPlanId    ${answerPlans['answerPlanId']}
	set to dictionary    ${bodyParams}    planType    CHAPTER_PRACTICE
    set to dictionary    ${bodyParams}    chapterId    ${chapterId}
    ${examQuestion}    get/questionTypes/examQuestion    ${token}    CHAPTER_PRACTICE   0    0    0    ${chapterId}
    ${questions}    RE_Questions   ${examQuestion}
    set to dictionary    ${bodyParams}    questions    ${questions}
    log     ${bodyParams}
    ${resp}    post/userAnswer    ${token}    ${bodyParams}
    [Return]    ${resp}

RE_ONLY_WRONG_PRACTICE
	[Documentation]   只做错题
	[Arguments]      ${chapterId}
	${answerPlans}    get/answerPlans    ${token}
	${bodyParams}    copy dictionary      ${userAnswer_param['userAnswerPostParam']}
	set to dictionary    ${bodyParams}    userId    ${userId}
	set to dictionary    ${bodyParams}    answerPlanId    ${answerPlans['answerPlanId']}
	set to dictionary    ${bodyParams}    planType    ONLY_WRONG_PRACTICE
    set to dictionary    ${bodyParams}    chapterId    ${chapterId}
    ${examQuestion}    get/questionTypes/examQuestion    ${token}    ONLY_WRONG_PRACTICE   0    0    0    ${chapterId}
    ${questions}    RE_Questions   ${examQuestion}
    set to dictionary    ${bodyParams}    questions    ${questions}
    log     ${bodyParams}
    ${resp}    post/userAnswer    ${token}    ${bodyParams}
    [Return]    ${resp}

RE_Questions
	[Documentation]    问题及答案
	[Arguments]     ${examQuestion}
	${len}    evaluate      len(${examQuestion})
	${questions}    copy list   ${userAnswer_param['userAnswerPostParam']['questions']}
	:FOR    ${x}    IN RANGE    ${len}
	\    set to dictionary      ${questions[${x}]}    questionId    ${examQuestion[${x}]['questionId']}
	\    ${question}    copy dictionary     ${userAnswer_param['userAnswerPostParam']['questions'][0]}
	\    exit for loop if      ${x}==${len-1}
	\    insert into list      ${questions}      ${x+1}    ${question}
	[Return]    ${questions}


