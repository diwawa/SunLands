*** Settings ***
Library           RequestsLibrary
Variables         ../Common/Variables/Base.py
Library           Collections
Library           DateTime
Library           ../Common/Library/Function.py

*** Keywords ***
POST/userAnswer
    [Arguments]    ${answerPlanId}    ${planType}    ${duration}    ${assignmentId}    ${total}    ${questionIds}
    [Documentation]    答题
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${params}    Create Dictionary
    Set to Dictionary    ${params}    answerPlanId    ${answerPlanId}    planType    ${planType}    duration
    ...    ${duration}
    Set to Dictionary    ${params}    chapterId    ${assignmentId}    assignmentId    ${assignmentId}    examPaperId
    ...    ${assignmentId}
    ${questions}    Create List
    : FOR    ${num}    IN RANGE    ${total}
    \    ${date}    Get Current Date    exclude_millis=True
    \    ${answerDate}    convertTimestamp    ${date}
    \    ${question}    Create Dictionary    questionId    ${questionIds[${num}]}    answerDesc    C
    \    ...    answerDate    ${answerDate}    duration    1
    \    Insert Into List    ${questions}    ${num}    ${question}
    Set to Dictionary    ${params}    questions    ${questions}
    ${resp}=    POST Request    exam    /userAnswer    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/userAnswer/userAnswerId
    [Arguments]    ${userAnswerId}    ${infoType}
    [Documentation]    获取判题信息,历史答题记录
    Create Session    exam    ${url}
    ${header}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    infoType    ${infoType}
    ${resp}=    Get Request    exam    /userAnswer/${userAnswerId}    headers=${header}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}
