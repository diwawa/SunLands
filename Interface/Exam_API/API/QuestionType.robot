*** Settings ***
Library           RequestsLibrary
Variables         ../Common/Variables/Base.py

*** keyword ***
GET/questionTypes/examQuestion
    [Arguments]    ${planType}    ${needAnswer}    ${needHistory}    ${needError}    ${stratumId}
    [Documentation]    获取题目信息
    Create Session    exam    ${url}
    ${header}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    planType    ${planType}    needAnswer    ${needAnswer}    needHistory
    ...    ${needHistory}    needError    ${needError}    stratumId    ${stratumId}
    ${resp}=    Get Request    exam    /questionTypes/examQuestion    headers=${header}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}
