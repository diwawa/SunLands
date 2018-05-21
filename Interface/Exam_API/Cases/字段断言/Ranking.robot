*** Settings ***
Documentation     用户下 有返回值得接口断言与接口文档是否一致
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        对比文档
Metadata          name    Key_Ranking
Resource          ../../Common/Resource/ComTest.robot
Library           ../../Common/Library/Function.py
Resource          ../../API/Ranking.robot
Variables         ../../AssertJson/Ranking.py


*** Test Cases ***
pkArena
    ${data}=    GET/ranking/pkArena    friends
    ${jsonkeys}    Compare Jsonkeys    ${pkArena}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${pkArena}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_userView}    Compare Jsonkeys    ${pkArena['userView']}    ${data['userView']}
    Should be true    ${jsonkeys_userView['assertStatus']}    ${jsonkeys_userView}
    ${jsonvalues_userView}    compareJsonvaluesTpye     ${pkArena['userView']}    ${data['userView']}
    Should be true    ${jsonvalues_userView['assertStatus']}    ${jsonvalues_userView}
    ${jsonkeys_danGradingView}    Compare Jsonkeys    ${pkArena['danGradingView']}    ${data['danGradingView']}
    Should be true    ${jsonkeys_danGradingView['assertStatus']}    ${jsonkeys_danGradingView}
    ${jsonvalues_danGradingView}    compareJsonvaluesTpye    ${pkArena['danGradingView']}    ${data['danGradingView']}
    Should be true    ${jsonvalues_danGradingView['assertStatus']}    ${jsonvalues_danGradingView}


persional
    ${data}=    GET/ranking/persional    local
    ${jsonkeys}    Compare Jsonkeys    ${persional}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${persional}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_currentUser}    Compare Jsonkeys    ${persional['currentUser']}    ${data['currentUser']}
    Should be true    ${jsonkeys_currentUser['assertStatus']}    ${jsonkeys_currentUser}
    ${jsonvalues_currentUser}    compareJsonvaluesTpye    ${persional['currentUser']}    ${data['currentUser']}
    Should be true    ${jsonvalues_currentUser['assertStatus']}    ${jsonvalues_currentUser}
    ${jsonkeys_userViewList}    Compare Jsonkeys    ${persional['userViewList']}    ${data['userViewList']}
    Should be true    ${jsonkeys_userViewList['assertStatus']}    ${jsonkeys_userViewList}
    ${jsonvalues_userViewList}    compareJsonvaluesTpye    ${persional['userViewList']}    ${data['userViewList']}
    Should be true    ${jsonvalues_userViewList['assertStatus']}    ${jsonvalues_userViewList}


provice_list
    ${data}=    GET/ranking/provice/list
    ${jsonkeys}    Compare Jsonkeys    ${provice_list}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${provice_list}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}