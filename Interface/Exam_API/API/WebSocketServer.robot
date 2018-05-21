*** Settings ***
Library           RequestsLibrary
Variables         ../Common/Variables/Base.py
Library           Collections

*** Keywords ***
GET/webSocketServer/pk
    [Documentation]    pk在线状态，等待匹配对手
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /webSocketServer/pk    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}
