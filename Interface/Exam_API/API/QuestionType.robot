*** Settings ***
Library           RequestsLibrary
Library           Collections
Variables         ../Common/Variables/Base.py

*** Keyword ***
GET/questionTypes/chapters
    [Arguments]    ${planType}
    [Documentation]    章节列表 （章节练习/只做错题/我的收藏/我的错题）
    Create Session    exam    ${url}
    ${header}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    planType     ${planType}
    ${resp}=    Get Request    exam    /questionTypes/chapters    headers=${header}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/questionTypes/myQuestionStem/{chapterId}
    [Arguments]    ${chapterId}    ${planType}
    [Documentation]    我的收藏列表/我的错题列表
    Create Session    exam    ${url}
    ${header}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    planType     ${planType}
    ${resp}=    Get Request    exam    /questionTypes/myQuestionStem/${chapterId}    headers=${header}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}


GET/questionTypes/examPapers
    [Documentation]    套卷模拟列表
    Create Session    exam    ${url}
    ${header}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /questionTypes/examPapers    headers=${header}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}


GET/questionTypes/examPapers/history
    [Documentation]    套卷模拟历史纪录
    Create Session    exam    ${url}
    ${header}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /questionTypes/examPapers/history    headers=${header}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}



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
