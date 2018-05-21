*** Settings ***
Library           RequestsLibrary
Variables         ../Common/Variables/Base.py
Library           Collections

*** Keywords ***
GET/pkArena/me
    [Documentation]    pk场，显示当前用户信息
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /pkArena/me    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/pkArena/join
    [Arguments]    ${shareMark}
    [Documentation]    好友对战，加入pk场
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token2}    Content-Type    application/json
    ${params}    Create Dictionary    shareMark    ${shareMark}
    ${resp}=    POST Request    exam    /pkArena/join    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/pkArena/target
    [Documentation]    进入pk场,显示对方用户信息
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /pkArena/target    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/pkArena/pkMatch
    [Arguments]    ${shareMark}    ${selfPlay}
    [Documentation]    首页我的详情.匹配对手 或 点击分享链接，显示当前用户、分享者的信息(首次登录需要授权)
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token2}
    ${params}    Create Dictionary    shareMark    ${shareMark}    selfPlay    ${selfPlay}
    ${resp}=    Get Request    exam    /pkArena/pkMatch    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/pkArena/quit
    [Arguments]    ${pkLogId}
    [Documentation]    pk场
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${params}    Create Dictionary    pkLogId    ${pkLogId}
    ${resp}=    POST Request    exam    /pkArena/quit    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/pkArena/pkQuestions
    [Arguments]    ${pkLogId}    ${questionId}
    [Documentation]    查询pk场下一题信息
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    pkLogId    ${pkLogId}    questionId    ${questionId}
    ${resp}=    Get Request    exam    /pkArena/pkQuestions    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/pkArena/pkAnswer
    [Arguments]    ${pkLogId}    ${questionId}    ${currentUserAnswer}    ${currentUserDuration}
    [Documentation]    提交答案
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${params}    Create Dictionary    pkLogId    ${pkLogId}    questionId    ${questionId}    currentUserAnswer
    ...    ${currentUserAnswer}    currentUserDuration    ${currentUserDuration}
    ${resp}=    POST Request    exam    /pkArena/pkAnswer    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/pkArena/targetAnswerDetail
    [Arguments]    ${pkLogId}    ${questionId}
    [Documentation]    查询对手答题详情
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    pkLogId    ${pkLogId}    questionId    ${questionId}
    ${resp}=    Get Request    exam    /pkArena/targetAnswerDetail    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/pkArena/danGradingTips
    [Arguments]    ${pkLogId}
    [Documentation]    段位升降提示
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    pkLogId    ${pkLogId}
    ${resp}=    Get Request    exam    /pkArena/danGradingTips    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/pkArena/pkDynamicImg/{userId}/{pkLogId}
    [Arguments]    ${userId}    ${pkLogId}
    [Documentation]    pk结果动态图片
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /pkArena/pkDynamicImg/${userId}/${pkLogId}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/pkArena/pkFinal
    [Arguments]    ${pkLogId}
    [Documentation]    pk结果
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    pkLogId    ${pkLogId}
    ${resp}=    Get Request    exam    /pkArena/pkFinal    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/pkArena/pkFinal/share
    [Arguments]    ${shareMark}
    [Documentation]    pk结果分享
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    shareMark    ${shareMark}
    ${resp}=    Get Request    exam    /pkArena/pkFinal/share    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}
