*** Settings ***
Library           RequestsLibrary
Variables         ../Common/Variables/Base.py
Library           Collections

*** Keywords ***
GET/users/home
    [Documentation]    欢迎页详情
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /users/home    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/users/me
    [Arguments]    ${lat}    ${lon}    #地点坐标，百度地图上找即可
    [Documentation]    首页我的详情
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    lat    ${lat}    lon    ${lon}
    ${resp}=    Get Request    exam    /users/me    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/users/me/info
    [Documentation]    获取我的数据
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /users/me/info    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/users/share
    [Arguments]    ${shareType}    ${pkLogId}    #分享类型(PK,DATA)；pk结果id
    [Documentation]    小程序分享
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    shareType    ${shareType}    pkLogId    ${pkLogId}
    ${resp}=    Get Request    exam    /users/share    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/users/share_shareMark
    [Arguments]    ${shareType}    ${shareMark}    #分享类型(PK,DATA)；pk结果id
    [Documentation]    小程序分享
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    shareType    ${shareType}    shareMark    ${shareMark}
    ${resp}=    Get Request    exam    /users/share    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/users/examPapers
    [Documentation]    首页试卷列表，获取首页详情
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /users/examPapers    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/users/push
    [Documentation]    首页推送消息集合
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /users/push    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

PUT/users/examTypes
    [Arguments]    ${examTypeId}    ${recomment}    #考试类型二级id；接受系统推荐考试类型 true ：接受 false和不填写为不接受
    [Documentation]    修改用户考试类型
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    examTypeId    ${examTypeId}    recomment    ${recomment}
    ${resp}=    PUT Request    exam    /users/examTypes    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

PUT/users/subjects
    [Arguments]    ${subjectId}    #科目id
    [Documentation]    修改用户科目
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    subjectId    ${subjectId}
    ${resp}=    PUT Request    exam    /users/subjects    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/users/collects/{questionId}
    [Arguments]    ${questionId}    ${type}
    [Documentation]    用户收藏
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    type    ${type}
    ${resp}=    POST Request    exam    /users/conllects/${questionId}    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/users/advice
    [Arguments]    ${content}
    [Documentation]    用户意见反馈
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${params}    Create Dictionary    content    ${content}
    ${resp}=    POST Request    exam    /users/advice    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

POST/users/survey
    [Arguments]    ${answers}
    [Documentation]    用户测试数据提交，首次进入，问卷调查
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${questions}    Create List
    : FOR    ${num}    IN RANGE    5
    \    ${question}    Create Dictionary    questionId    ${num}    answerDesc    ${answers[${num}]}
    \    Insert Into List    ${questions}    ${num}    ${question}
    ${params}    Create Dictionary    questions    ${questions}
    ${resp}=    POST Request    exam    /users/survey    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/users/posters
    [Arguments]    ${writingsType}
    [Documentation]    用户打卡图片集
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${params}    Create Dictionary    writingsType    ${writingsType}
    ${resp}=    Get Request    exam    /users/posters    headers=${headers}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}


POST/users/unchainPaper
    [Arguments]    ${encryptedData}    ${iv}    ${code}
    [Documentation]    授权解锁 模拟试卷
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json
    ${userCodeView}    Create Dictionary    encryptedData    ${encryptedData}    iv    ${iv}    code    ${code}
    ${params}    Create Dictionary    userCodeView    ${userCodeView}
    ${resp}=    POST Request    exam    /users/unchainPaper    headers=${headers}    data=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}

GET/users/support
    [Documentation]    题库数据支持
    Create Session    exam    ${url}
    ${headers}    Create Dictionary    Authorization    ${token}
    ${resp}=    Get Request    exam    /users/support    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${data}    to json    ${resp.content}
    [Return]    ${data}