*** Settings ***
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        断言响应数据
Metadata          name    users
Library           Collections
Library           DatabaseLibrary
Library           ../../Common/Library/Function.py
Resource          ../../API/Users.robot
Resource          ../../Common/Resource/ComTest.robot

*** Test Cases ***
home_无参数
    ${query}    Query    SELECT nick_name,head_image_url FROM `user` WHERE id=${id}
    ${home}=    GET/users/home
    ${nickName}    Get From Dictionary    ${home}    nickName
    ${headImageUrl}    Get From Dictionary    ${home}    headImageUrl
    ${totle}    Get From Dictionary    ${home}    totle
    ${icons}    Get From Dictionary    ${home}    icons
    Should Be Equal As Strings    ${nickName}    ${query[0][0]}    #赵爽
    Should Be Equal As Strings    ${headImageUrl}    ${query[0][1]}
    Should Be True    ${totle}
    Should Not Be Empty    ${icons}

me_参数为空
    ${me}=    GET/users/me    ${EMPTY}    ${EMPTY}
    # 个人信息
    ${headImageUrl}    Get From Dictionary    ${me}    headImageUrl
    ${nickName}    Get From Dictionary    ${me}    nickName
    ${examType}    Get From Dictionary    ${me}    examType
    ${examTypeId}    Get From Dictionary    ${me}    examTypeId
    ${levelNum}    Get From Dictionary    ${me}    levelNum
    ${userIntegral}    Get From Dictionary    ${me}    userIntegral
    ${maxIntegral}    Get From Dictionary    ${me}    maxIntegral
    ${currentSubject}    Get From Dictionary    ${me}    currentSubject
    ${weekAnswerSum}    Get From Dictionary    ${me}    weekAnswerSum
    ${weekAnswerCorrect}    Get From Dictionary    ${me}    weekAnswerCorrect
    ${weekAnswerCorrectRate}    Get From Dictionary    ${me}    weekAnswerCorrectRate
    ${percent}    Get From Dictionary    ${me}    percent
    #${errorSum}    Get From Dictionary    ${me}    errorSum
    #${passRate}    Get From Dictionary    ${me}    passRate
    #${ranking}    Get From Dictionary    ${me}    ranking
    # 考试信息
    ${examTimeInfo}    Get From Dictionary    ${me}    examTimeInfo
    ${examDate}    Get From Dictionary    ${examTimeInfo}    examDate
    ${intervalDays}    Get From Dictionary    ${examTimeInfo}    intervalDays
    ${examType}    Get From Dictionary    ${examTimeInfo}    examType
    # 活动信息
#    ${activityInfo}    Get From Dictionary    ${me}    activityInfo
#    ${remainingTime}    Get From Dictionary    ${activityInfo}    remainingTime
#    ${status}    Get From Dictionary    ${activityInfo}    status

