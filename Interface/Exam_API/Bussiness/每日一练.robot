*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource          ../API/DailyPractice.robot
Library           DateTime
Resource          ../API/Users.robot
Resource          ../API/AnswerPlan.robot
Resource          ../API/UserAnswer.robot
Resource          ../API/QuestionType.robot
Library           DatabaseLibrary

*** Keywords ***
打卡
    [Documentation]    每日打卡流程
    ${examPapers}=    GET/dailyPractice/examPapers    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ${clockIn}    Get From Dictionary    ${examPapers}    clockIn    #打卡状态
    ${assignmentList}    Get From Dictionary    ${examPapers}    assignmentList
    ${totals}    Create List    #每个任务题的总量
    : FOR    ${num}    IN RANGE    3
    \    ${total}    Get From Dictionary    ${assignmentList[${num}]}    total
    \    Insert Into List    ${totals}    ${num}    ${total}
    ${currents}    Create List    #每个任务已答题数量
    : FOR    ${num}    IN RANGE    3
    \    ${current}    Get From Dictionary    ${assignmentList[${num}]}    current
    \    Insert Into List    ${currents}    ${num}    ${current}
    ${assignmentIds}    Create List    #每个任务id
    : FOR    ${num}    IN RANGE    3
    \    ${assignmentId}    Get From Dictionary    ${assignmentList[${num}]}    assignmentId
    \    Insert Into List    ${assignmentIds}    ${num}    ${assignmentId}
    ${answerPlans}=    GET/answerPlans
    ${answerPlanId}    Get From Dictionary    ${answerPlans}    answerPlanId
    run keyword if    ${clockIn}==2    clockIn=2    ${answerPlanId}    ${assignmentIds}    ${totals}    ${currents}
    run keyword if    ${clockIn}==1    POST/dailyPractice/userClockIn
    [Return]    ${clockIn}

clockIn=2
    [Arguments]    ${answerPlanId}    ${assignmentIds}    ${totals}    ${currents}
    [Documentation]    去打卡，但是不可以打卡，需要先答题
    : FOR    ${num}    IN RANGE    3
    \    run keyword if    ${currents[${num}]}==0    答题    ${answerPlanId}    ${assignmentIds[${num}]}    ${totals[${num}]}
    POST/dailyPractice/userClockIn

答题
    [Arguments]    ${answerPlanId}    ${assignmentId}    ${total}
    [Documentation]    提交答案
    ${examQuestion}    GET/questionTypes/examQuestion    DAILY_PRACTICE    0    0    0    ${assignmentId}
    ${questionIds}    Create List
    : FOR    ${num}    IN RANGE    ${total}
    \    ${questionId}    Get From Dictionary    ${examQuestion[${num}]}    questionId
    \    Insert Into List    ${questionIds}    ${num}    ${questionId}
    ${userAnswer}    POST/userAnswer    ${answerPlanId}    DAILY_PRACTICE    5    ${assignmentId}    ${total}
    ...    ${questionIds}
    ${userAnswerId}    Get From Dictionary    ${userAnswer}    userAnswerId
    GET/userAnswer/userAnswerId    ${userAnswerId}    answerDone
