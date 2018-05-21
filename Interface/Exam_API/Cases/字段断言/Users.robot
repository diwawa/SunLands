*** Settings ***
Documentation     用户下 有返回值得接口断言与接口文档是否一致
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        对比文档
Metadata          name    Key_Users
Resource          ../../Common/Resource/ComTest.robot
Library           ../../Common/Library/Function.py
Resource          ../../API/Users.robot
Variables         ../../AssertJson/Users.py


*** Test Cases ***
home
    ${data}    GET/users/home
    ${jsonkeys}    Compare Jsonkeys    ${home}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${home}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_icons}    Compare Jsonkeys    ${home["icons"]}    ${data["icons"]}
    Should be true    ${jsonkeys_icons['assertStatus']}    ${jsonkeys_icons}
    ${jsonvalues_icons}    compareJsonvaluesTpye    ${home["icons"]}    ${data["icons"]}
    Should be true    ${jsonvalues_icons['assertStatus']}    ${jsonvalues_icons}

me
    ${data}=    GET/users/me    ${EMPTY}    ${EMPTY}
    ${jsonkeys}    Compare Jsonkeys    ${me}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${me}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_examTimeInfo}    Compare Jsonkeys    ${me["examTimeInfo"]}    ${data["examTimeInfo"]}
    Should be true    ${jsonkeys_examTimeInfo['assertStatus']}    ${jsonkeys_examTimeInfo}
    ${jsonvalues_examTimeInfo}    compareJsonvaluesTpye    ${me["examTimeInfo"]}    ${data["examTimeInfo"]}
    Should be true    ${jsonvalues_examTimeInfo['assertStatus']}    ${jsonvalues_examTimeInfo}
    ${jsonkeys_activityInfo}    Compare Jsonkeys    ${me["activityInfo"]}    ${data["activityInfo"]}
    Should be true    ${jsonkeys_activityInfo['assertStatus']}    ${jsonkeys_activityInfo}
    ${jsonvalues_activityInfo}    compareJsonvaluesTpye    ${me["activityInfo"]}    ${data["activityInfo"]}
    Should be true    ${jsonvalues_activityInfo['assertStatus']}    ${jsonvalues_activityInfo}

me_info
    ${data}    GET/users/me/info
    ${jsonkeys}    Compare Jsonkeys    ${me_info}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${me_info}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}

examPapers
    ${data}    GET/users/examPapers
    ${jsonkeys}    Compare Jsonkeys    ${examPapers}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${examPapers}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}

push
    ${data}    GET/users/push
    ${jsonkeys}    Compare Jsonkeys    ${push}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${push}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
