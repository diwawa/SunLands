*** Settings ***
Library           RequestsLibrary
Variables         ../Common/Variables/Base.py
Library           Collections

*** Keywords ***
GET/ranking/pkArena
    [Arguments]    ${filter}
    [Documentation]    排行榜-pk场
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    filter    ${filter}
    ${resp}=    Get Request    exam    /ranking/pkArena    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/ranking/persional
    [Arguments]    ${filter}
    [Documentation]    排行榜-个人
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    filter    ${filter}
    ${resp}=    Get Request    exam    /ranking/persional    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/ranking/provice/list
    [Documentation]    排名-省份目录
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /ranking/provice/list    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}