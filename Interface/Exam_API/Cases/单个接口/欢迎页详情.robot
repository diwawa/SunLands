*** Settings ***
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        欢迎页
Metadata          name    users_home
Library           Collections
Library           DatabaseLibrary
Resource          ../../API/Users.robot
Resource          ../../Common/Resource/ComTest.robot

*** Test Cases ***
断言返回值
    ${query}    Query    SELECT nick_name,head_image_url FROM `user` WHERE id=${id}
    ${home}=    GET/users/home
    ${length}    Get Length    ${home}
    ${nickName}    Get From Dictionary    ${home}    nickName
    ${headImageUrl}    Get From Dictionary    ${home}    headImageUrl
    ${totle}    Get From Dictionary    ${home}    totle
    ${icons}    Get From Dictionary    ${home}    icons
    Should Be Equal As Integers    ${length}    4
    Should Be Equal As Strings    ${nickName}    ${query[0][0]}    #赵爽
    Should Be Equal As Strings    ${headImageUrl}    ${query[0][1]}
    Should Be True    ${totle}
    Should Not Be Empty    ${icons}
