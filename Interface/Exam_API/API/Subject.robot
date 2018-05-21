*** Settings ***
Library           RequestsLibrary
Library           Collections
Variables         ../Common/Variables/Base.py

*** Keywords ***
GET/subjects
    [Arguments]    ${examTypeId}
    [Documentation]    根据考试类型id查询科目列表
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    examTypeId    ${examTypeId}
    ${resp}=    Get Request    exam    /subjects    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}