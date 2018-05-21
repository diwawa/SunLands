*** Settings ***
Documentation     有返回值得接口断言与接口文档是否一致
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        对比文档
Metadata          name    Key_PkArena
Resource          ../../Common/Resource/ComTest.robot
Library           ../../Common/Library/Function.py
Resource          ../../API/PkArena.robot
Variables         ../../AssertJson/PkArena.py
Resource          ../../API/Users.robot

*** Test Cases ***
me
    ${data}    GET/pkArena/me
    SET SUITE VARIABLE    ${shareMark}    ${data['shareMark']}
    ${jsonkeys}    Compare Jsonkeys    ${me}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${me}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_danGradingView}    Compare Jsonkeys    ${me['danGradingView']}    ${data['danGradingView']}
    Should be true    ${jsonkeys_danGradingView['assertStatus']}    ${jsonkeys_danGradingView}
    ${jsonvalues_danGradingView}    compareJsonvaluesTpye    ${me['danGradingView']}    ${data['danGradingView']}
    Should be true    ${jsonvalues_danGradingView['assertStatus']}    ${jsonvalues_danGradingView}

join
    GET/users/share_shareMark     PK    ${shareMark}
    ${data}    POST/pkArena/join    ${shareMark}
    ${jsonkeys}    Compare Jsonkeys    ${join}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${join}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}

target
    ${data}    GET/pkArena/target
    ${jsonkeys}    Compare Jsonkeys    ${target}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${target}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_danGradingView}    Compare Jsonkeys    ${target['danGradingView']}    ${data['danGradingView']}
    Should be true    ${jsonkeys_danGradingView['assertStatus']}    ${jsonkeys_danGradingView}
    ${jsonvalues_danGradingView}    compareJsonvaluesTpye    ${target['danGradingView']}    ${data['danGradingView']}
    Should be true    ${jsonvalues_danGradingView['assertStatus']}    ${jsonvalues_danGradingView}

pkMatch
    ${data}    GET/pkArena/pkMatch    ${shareMark}    False
    SET SUITE VARIABLE   ${pkLogId}    ${data['pkLogId']}
    ${jsonkeys}    Compare Jsonkeys    ${pkMatch}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${pkMatch}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_targetUserView}    Compare Jsonkeys    ${pkMatch["targetUserView"]}    ${data["targetUserView"]}
    Should be true    ${jsonkeys_targetUserView['assertStatus']}    ${jsonkeys_targetUserView}
    ${jsonvalues_targetUserView}    compareJsonvaluesTpye    ${pkMatch["targetUserView"]}    ${data["targetUserView"]}
    Should be true    ${jsonvalues_targetUserView['assertStatus']}    ${jsonvalues_targetUserView}
    ${jsonkeys_targetUserView_danGradingView}    Compare Jsonkeys    ${pkMatch["targetUserView"]["danGradingView']}    ${data["targetUserView"]["danGradingView']}
    Should be true    ${jsonkeys_targetUserView_danGradingView['assertStatus']}    ${jsonkeys_targetUserView_danGradingView}
    ${jsonvalues_targetUserView_danGradingView}    compareJsonvaluesTpye    ${pkMatch["targetUserView"]["danGradingView']}    ${data["targetUserView"]["danGradingView']}
    Should be true    ${jsonvalues_targetUserView_danGradingView['assertStatus']}    ${jsonvalues_targetUserView_danGradingView}
    ${jsonkeys_currentUserView}    Compare Jsonkeys    ${pkMatch["currentUserView"]}    ${data["currentUserView"]}
    Should be true    ${jsonkeys_currentUserView['assertStatus']}    ${jsonkeys_currentUserView}
    ${jsonvalues_currentUserView}    compareJsonvaluesTpye    ${pkMatch["currentUserView"]}    ${data["currentUserView"]}
    Should be true    ${jsonvalues_currentUserView['assertStatus']}    ${jsonvalues_currentUserView}
    ${jsonkeys_currentUserView_danGradingView}    Compare Jsonkeys    ${pkMatch["currentUserView"]["danGradingView']}    ${data["currentUserView"]["danGradingView']}
    Should be true    ${jsonkeys_currentUserView_danGradingView['assertStatus']}    ${jsonkeys_currentUserView_danGradingView}
    ${jsonvalues_currentUserView_danGradingView}    compareJsonvaluesTpye    ${pkMatch["currentUserView"]["danGradingView']}    ${data["currentUserView"]["danGradingView']}
    Should be true    ${jsonvalues_currentUserView_danGradingView['assertStatus']}    ${jsonvalues_currentUserView_danGradingView}

pkQuestions
    [Documentation]    请求第一题
    #请求第一题
    ${data}    GET/pkArena/pkQuestions    ${pkLogId}    ${EMPTY}
    SET SUITE VARIABLE    ${questionId}    ${data['questionId']}
    ${jsonkeys}    Compare Jsonkeys    ${pkQuestions}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${pkQuestions}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_options}    Compare Jsonkeys    ${pkQuestions['options']}    ${data['options']}
    Should be true    ${jsonkeys_options['assertStatus']}    ${jsonkeys_options}
    ${jsonvalues_options}    compareJsonvaluesTpye    ${pkQuestions['options']}    ${data['options']}
    Should be true    ${jsonvalues_options['assertStatus']}    ${jsonvalues_options}

pkAnswer
    ${data}    POST/pkArena/pkAnswer    ${pkLogId}    ${questionId}    A    3
    ${jsonkeys}    Compare Jsonkeys    ${pkAnswer}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${pkAnswer}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}

targetAnswerDetail
    ${data}    GET/pkArena/targetAnswerDetail    ${pkLogId}    ${questionId}
    ${jsonkeys}    Compare Jsonkeys    ${targetAnswerDetail}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${targetAnswerDetail}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}

quit
    ${data}    POST/pkArena/quit    ${pkLogId}
    ${jsonkeys}    Compare Jsonkeys    ${quit}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${quit}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_danGradingView}    Compare Jsonkeys    ${quit["danGradingView"]}    ${data["danGradingView"]}
    Should be true    ${jsonkeys_danGradingView['assertStatus']}    ${jsonkeys_danGradingView}
    ${jsonvalues_danGradingView}    compareJsonvaluesTpye    ${quit["danGradingView"]}    ${data["danGradingView"]}
    Should be true    ${jsonvalues_danGradingView['assertStatus']}    ${jsonvalues_danGradingView}

pkFinal
    ${data}    GET/pkArena/pkFinal    ${pkLogId}
    ${jsonkeys}    Compare Jsonkeys    ${pkFinal}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${pkFinal}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_targetUserView}    Compare Jsonkeys    ${pkFinal['targetUserView']}    ${data['targetUserView']}
    Should be true    ${jsonkeys_targetUserView['assertStatus']}    ${jsonkeys_targetUserView}
    ${jsonvalues_targetUserView}    compareJsonvaluesTpye    ${pkFinal['targetUserView']}    ${data['targetUserView']}
    Should be true    ${jsonvalues_targetUserView['assertStatus']}    ${jsonvalues_targetUserView}
    ${jsonkeys_targetUserView_danGradingView}    Compare Jsonkeys    ${pkFinal['targetUserView']['danGradingView']}    ${data['targetUserView']['danGradingView']}
    Should be true    ${jsonkeys_targetUserView_danGradingView['assertStatus']}    ${jsonkeys_targetUserView_danGradingView}
    ${jsonvalues_targetUserView_danGradingView}    compareJsonvaluesTpye    ${pkFinal['targetUserView']['danGradingView']}    ${data['targetUserView']['danGradingView']}
    Should be true    ${jsonvalues_targetUserView_danGradingView['assertStatus']}    ${jsonvalues_targetUserView_danGradingView}
    ${jsonkeys_currentUserView}    Compare Jsonkeys    ${pkFinal['currentUserView']}    ${data['currentUserView']}
    Should be true    ${jsonkeys_currentUserView['assertStatus']}    ${jsonkeys_currentUserView}
    ${jsonvalues_currentUserView}    compareJsonvaluesTpye    ${pkFinal['currentUserView']}    ${data['currentUserView']}
    Should be true    ${jsonvalues_currentUserView['assertStatus']}    ${jsonvalues_currentUserView}
    ${jsonkeys_currentUserView_danGradingView}    Compare Jsonkeys    ${pkFinal['currentUserView']['danGradingView']}    ${data['currentUserView']['danGradingView']}
    Should be true    ${jsonkeys_currentUserView_danGradingView['assertStatus']}    ${jsonkeys_currentUserView_danGradingView}
    ${jsonvalues_currentUserView_danGradingView}    compareJsonvaluesTpye     ${pkFinal['currentUserView']['danGradingView']}    ${data['currentUserView']['danGradingView']}
    Should be true    ${jsonvalues_currentUserView_danGradingView['assertStatus']}    ${jsonvalues_currentUserView_danGradingView}


pkFinal_share
    GET/users/share   PK     ${pkLogId}
    ${shareMark}    Query    SELECT share_mark FROM relation_pk_share WHERE pk_log_id=${pkLogId}
    ${data}    GET/pkArena/pkFinal/share    ${shareMark[0][0]}
    ${jsonkeys}    compareJsonkeys    ${pkFinal_share}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${pkFinal_share}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_shareUserView}    compareJsonkeys    ${pkFinal_share['shareUserView']}    ${data['shareUserView']}
    Should be true    ${jsonkeys_shareUserView['assertStatus']}    ${jsonkeys_shareUserView}
    ${jsonvalues_shareUserView}    compareJsonvaluesTpye    ${pkFinal_share['shareUserView']}    ${data['shareUserView']}
    Should be true    ${jsonvalues_shareUserView['assertStatus']}    ${jsonvalues_shareUserView}
    ${jsonkeys_currentUserView}    compareJsonkeys    ${pkFinal_share['currentUserView']}    ${data['currentUserView']}
    Should be true    ${jsonkeys_currentUserView['assertStatus']}    ${jsonkeys_currentUserView}
    ${jsonvalues_currentUserView}    compareJsonvaluesTpye    ${pkFinal_share['currentUserView']}    ${data['currentUserView']}
    Should be true    ${jsonvalues_currentUserView['assertStatus']}    ${jsonvalues_currentUserView}

