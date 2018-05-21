*** Settings ***
Library           RequestsLibrary
Library           Collections
Variables         ../Common/Variables/Base.py


*** Keywords ***
POST/userClockIn
    [Arguments]    ${userId}
    [Documentation]    每日打卡
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    userId    ${userId}
    ${resp}=    POST Request    exam    /userClockIn    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}


GET/userClockInRecord
    [Arguments]    ${userId}    ${infoType }
    [Documentation]    获取判题信息,历史答题记录
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    userId     ${userId}    month    ${month}
    ${resp}=    Get Request    exam    /userClockInRecord    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}