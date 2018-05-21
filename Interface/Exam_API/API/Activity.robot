*** Settings ***
Library           RequestsLibrary
Library           Collections
Variables         ../Common/Variables/Base.py

*** Keywords ***
GET/activity
    [Documentation]    活动列表
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /activity    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/activity/push
    [Documentation]    活动推送消息
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /activity/push    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/activity/join
    [Documentation]    发起拼团（实际是get）
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${resp}=    POST Request    exam    /activity/join    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/activity/details
    [Arguments]    ${mark}    #表exam_share中sharemark字段
    [Documentation]    拼团详情页
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    mark    ${mark}
    ${resp}=    Get Request    exam    /activity/details    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/activity/goods
    [Arguments]    ${phoneNumber}
    [Documentation]    拼团成功详情页
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    phoneNumber    ${phoneNumber}
    ${resp}=    Get Request    exam    /activity/goods    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/activity/decodeUserInfo
    [Arguments]    ${code}    ${encryptedData}    ${iv}    ${type}
    [Documentation]    微信授权获取手机号（）
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    code    ${code}    encryptedData    ${encryptedData}    iv
    ...    ${iv}    type    ${type}
    ${resp}=    Get Request    exam    /activity/decodeUserInfo    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/activity/draw/details
    [Documentation]    抽签页面详情
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /activity/draw/details    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/activity/draw/join
    [Arguments]    ${DrawType}
    [Documentation]    抽签结果上报
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${params}    Create Dictionary    DrawType    ${DrawType}
    ${resp}=    POST Request    exam    /activity/draw/join    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/activity/draw/shareUser
    [Arguments]    ${mark}
    [Documentation]    分享用户详情
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    mark    ${mark}
    ${resp}=    Get Request    exam    /activity/draw/shareUser    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/activity/draw/help
    [Arguments]    ${mark}
    [Documentation]    好友助力
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${params}    Create Dictionary    mark    ${mark}
    ${resp}=    POST Request    exam    /activity/draw/help    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}


GET/activity/valentines/form
    [Documentation]    配对活动表单
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /activity/valentines/form    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/activity/valentines/form
    [Arguments]    ${selfSex}    ${hopeSex}
    [Documentation]    配对活动表单上传
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${params}    Create Dictionary    selfSex    ${selfSex}    hopeSex    ${hopeSex}
    ${resp}=    POST Request    exam    /activity/valentines/form    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/activity/valentines/details
    [Documentation]    配对成功活动详情
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /activity/valentines/details    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/activity/valentines/ranking
    [Documentation]    配对活动排行榜
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /activity/valentines/ranking    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}

GET/activity/APM/ranking
    [Documentation]    小心心手速排行榜
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /activity/APM/ranking    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/activity/pointQuestion/final
    [Arguments]    ${sum}
    [Documentation]    小心心提交点击次数，返回数据
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    sum    ${sum}
    ${resp}=    Get Request    exam    /activity/pointQuestion/final    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/activity/pointQuestion/home
    [Arguments]    ${shareMark}
    [Documentation]    小心心首页
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    shareMark    ${shareMark}
    ${resp}=    Get Request    exam    /activity/pointQuestion/home    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}
