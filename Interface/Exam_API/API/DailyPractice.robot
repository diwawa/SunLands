*** Settings ***
Library           RequestsLibrary
Library           Collections
Variables         ../Common/Variables/Base.py

*** Keywords ***
GET/dailyPractice/examPapers
    [Arguments]    ${year}    ${month}    ${number}
    [Documentation]    每日一练 任务列表：参数空代表当前时间
    Create Session    exam    ${url}
    ${header}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    year    ${year}    month    ${month}    number    ${number}
    ${resp}=    Get Request    exam    /dailyPractice/examPapers    headers=${header}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/dailyPractice/calendar
    [Arguments]    ${year}    ${month}
    [Documentation]    查看打卡日历
    Create Session    exam    ${url}
    ${header}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    year    ${year}    month    ${month}
    ${resp}=    Get Request    exam    /dailyPractice/calendar    headers=${header}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/dailyPractice/userClockIn
    [Documentation]    点击打卡 \ 文档中是PUT方式
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${resp}=    POST Request    exam    /dailyPractice/userClockIn    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/dailyPractice/clockInSum
    [Documentation]    获取总打卡次数
    Create Session    exam    ${url}
    ${header}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /dailyPractice/clockInSum    headers=${header}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}
