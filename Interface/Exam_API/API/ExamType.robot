*** Settings ***
Library           RequestsLibrary
Library           Collections
Variables         ../Common/Variables/Base.py

*** Keywords ***
GET/examTypes
    [Documentation]    查询考试类型列表
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /examTypes    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}