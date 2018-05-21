*** Settings ***
Library           RequestsLibrary
Variables         ../Common/Variables/Base.py
Library           Collections

*** Keywords ***
POST/pushMessage/formid
    [Arguments]    ${messageType}    ${formId}
    [Documentation]    模版消息
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${pushWechatTemplateParam}    Create Dictionary    messageType    ${messageType}    formId    ${formId}
    ${params}    Create Dictionary    pushWechatTemplateParam    ${pushWechatTemplateParam}
    ${resp}=    POST Request    exam    /pushMessage/formid    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}