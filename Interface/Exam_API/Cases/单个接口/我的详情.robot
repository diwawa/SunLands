*** Settings ***
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        我的
Metadata          name    users_me
Resource          ../../API/Users.robot
Library           Collections
Resource          ../../Common/Resource/ComTest.robot
Library           DatabaseLibrary
Resource          ../../API/DailyPractice.robot
Library           ../../Common/Library/Function.py
Variables         ../../AssertJson/Users.py

*** Test Cases ***
断言返回值
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
    ${errorSum}    Get From Dictionary    ${me}    errorSum
    #${passRate}    Get From Dictionary    ${me}    passRate
    #${ranking}    Get From Dictionary    ${me}    ranking
    # 考试信息
    ${examTimeInfo}    Get From Dictionary    ${me}    examTimeInfo
    ${examDate}    Get From Dictionary    ${examTimeInfo}    examDate
    ${intervalDays}    Get From Dictionary    ${examTimeInfo}    intervalDays
    ${examType}    Get From Dictionary    ${examTimeInfo}    examType
    # 活动信息
    ${activityInfo}    Get From Dictionary    ${me}    activityInfo
    ${remainingTime}    Get From Dictionary    ${activityInfo}    remainingTime
    ${status}    Get From Dictionary    ${activityInfo}    status
