*** Settings ***
Resource          ../../API/QuestionType.robot
Variables         ../../Base.py
Resource          ../../API/UserAnswer.robot
Variables         ../../Datas/Params/UserAnswer.py
Variables         ../../Datas/Response/UserAnswer.py
Resource          ../../API/AnswerPlan.robot
Library           ../../Common/GetSQL.py
Library           ../../Common/Function.py
Library           ../../Common/PrivateMethod.py

*** Keywords ***
RE_DailyPractice
    [Arguments]    ${assignmentList}
    [Documentation]    每日一练答题
    ${answerPlans}    get/answerPlans    ${token}
    ${bodyParams}    copy dictionary    ${userAnswer_param['userAnswerPostParam']}
    ${len}    Get Length    ${assignmentList}
    : FOR    ${x}    IN RANGE    ${len}
    \    set to dictionary    ${bodyParams}    userId    ${userId}
    \    set to dictionary    ${bodyParams}    answerPlanId    ${answerPlans['answerPlanId']}
    \    set to dictionary    ${bodyParams}    planType    DAILY_PRACTICE
    \    ${assignmentId}    get from dictionary    ${assignmentList[${x}]}    assignmentId
    \    set to dictionary    ${bodyParams}    assignmentId    ${assignmentId}
    \    ${examQuestion}    get/questionTypes/examQuestion    ${token}    DAILY_PRACTICE    0    0
    \    ...    0    ${assignmentId}
    \    ${questions}    RE_Questions    ${examQuestion}
    \    set to dictionary    ${bodyParams}    questions    ${questions}
    \    log    ${bodyParams}
    \    ${resp}    post/userAnswer    ${token}    ${bodyParams}
    [Return]    ${bodyParams}

RE_SIMULATION_EXAM
    [Arguments]    ${examPapersId}
    [Documentation]    套卷模拟
    ${answerPlans}    get/answerPlans    ${token}
    ${bodyParams}    copy dictionary    ${userAnswer_param['userAnswerPostParam']}
    set to dictionary    ${bodyParams}    userId    ${userId}
    set to dictionary    ${bodyParams}    answerPlanId    ${answerPlans['answerPlanId']}
    set to dictionary    ${bodyParams}    planType    SIMULATION_EXAM
    set to dictionary    ${bodyParams}    examPaperId    ${examPapersId}
    ${examQuestion}    get/questionTypes/examQuestion    ${token}    SIMULATION_EXAM    0    0    0
    ...    ${examPapersId}
    ${questions}    RE_Questions    ${examQuestion}
    set to dictionary    ${bodyParams}    questions    ${questions}
    log    ${bodyParams}
    ${resp}    post/userAnswer    ${token}    ${bodyParams}
    [Return]    ${resp}    ${bodyParams}

RE_CHAPTER_PRACTICE
    [Arguments]    ${chapterId}
    [Documentation]    章节练习
    ${answerPlans}    get/answerPlans    ${token}
    ${bodyParams}    copy dictionary    ${userAnswer_param['userAnswerPostParam']}
    set to dictionary    ${bodyParams}    userId    ${userId}
    set to dictionary    ${bodyParams}    answerPlanId    ${answerPlans['answerPlanId']}
    set to dictionary    ${bodyParams}    planType    CHAPTER_PRACTICE
    set to dictionary    ${bodyParams}    chapterId    ${chapterId}
    ${examQuestion}    get/questionTypes/examQuestion    ${token}    CHAPTER_PRACTICE    0    0    0
    ...    ${chapterId}
    ${questions}    RE_Questions    ${examQuestion}
    set to dictionary    ${bodyParams}    questions    ${questions}
    log    ${bodyParams}
    ${resp}    post/userAnswer    ${token}    ${bodyParams}
    [Return]    ${resp}    ${bodyParams}

RE_ONLY_WRONG_PRACTICE
    [Arguments]    ${chapterId}
    [Documentation]    只做错题
    ${answerPlans}    get/answerPlans    ${token}
    ${bodyParams}    copy dictionary    ${userAnswer_param['userAnswerPostParam']}
    set to dictionary    ${bodyParams}    userId    ${userId}
    set to dictionary    ${bodyParams}    answerPlanId    ${answerPlans['answerPlanId']}
    set to dictionary    ${bodyParams}    planType    ONLY_WRONG_PRACTICE
    set to dictionary    ${bodyParams}    chapterId    ${chapterId}
    ${examQuestion}    get/questionTypes/examQuestion    ${token}    ONLY_WRONG_PRACTICE    0    0    0
    ...    ${chapterId}
    ${questions}    RE_Questions    ${examQuestion}
    set to dictionary    ${bodyParams}    questions    ${questions}
    log    ${bodyParams}
    ${resp}    post/userAnswer    ${token}    ${bodyParams}
    [Return]    ${resp}    ${bodyParams}

RE_Questions
    [Arguments]    ${examQuestion}
    [Documentation]    问题及答案
    ${len}    Get Length    ${examQuestion}
    ${questions}    copy list    ${userAnswer_param['userAnswerPostParam']['questions']}
    : FOR    ${x}    IN RANGE    ${len}
    \    set to dictionary    ${questions[${x}]}    questionId    ${examQuestion[${x}]['questionId']}
    \    ${question}    copy dictionary    ${userAnswer_param['userAnswerPostParam']['questions'][0]}
    \    ${sql}    Exam Question    ${questions[${x}]['questionId']}
    \    ${keys}    Evaluate    ${sql['options_desc']}.keys()
    \    ${option}    Evaluate    sorted(${keys})    #答案
    \    ${single}    Get Random Str    ${option}
    \    ${multiple}    Get Random List    ${option}
    \    sort list      ${multiple}
    \    ${answer}    Set Variable If    "${sql['question_type']}"=="MULTIPLE_ANSWER"    ${multiple}    ${single}
    \    ${answers}    List To String    ${answer}
    \    set to dictionary    ${questions[${x}]}    answerDesc    ${answers}
    \    ${answerDa}    Evaluate    time.time( )    time
    \    ${answerDate}    Evaluate    int(${answerDa})
    \    set to dictionary    ${questions[${x}]}    answerDate    ${answerDate}
    \    Log    ${questions}
    \    exit for loop if    ${x}==${len-1}
    \    insert into list    ${questions}    ${x+1}    ${question}
    [Return]    ${questions}
