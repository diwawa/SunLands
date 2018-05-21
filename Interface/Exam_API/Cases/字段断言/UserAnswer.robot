*** Settings ***
Documentation     有返回值得接口断言与接口文档是否一致
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        对比文档
Metadata          name    Key_UserAnswer
Resource          ../../Common/Resource/ComTest.robot
Library           ../../Common/Library/Function.py
Resource          ../../API/UserAnswer.robot
Variables         ../../AssertJson/UserAnswer.py

*** Test Cases ***
userAnswer_userAnswerId
    ${data}    GET/userAnswer/userAnswerId    2552    answerDone
    ${jsonkeys}    Compare Jsonkeys    ${userAnswer_userAnswerId}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${userAnswer_userAnswerId}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_levelView}    Compare Jsonkeys    ${userAnswer_userAnswerId['levelView']}    ${data['levelView']}
    Should be true    ${jsonkeys_levelView['assertStatus']}    ${jsonkeys_levelView}
    ${jsonvalues_levelView}    compareJsonvaluesTpye    ${userAnswer_userAnswerId['levelView']}    ${data['levelView']}
    Should be true    ${jsonvalues_levelView['assertStatus']}    ${jsonvalues_levelView}
    ${jsonkeys_questions}    Compare Jsonkeys    ${userAnswer_userAnswerId['questions']}    ${data['questions']}
    Should be true    ${jsonkeys_questions['assertStatus']}    ${jsonkeys_questions}
    ${jsonvalues_questions}    compareJsonvaluesTpye    ${userAnswer_userAnswerId['questions']}    ${data['questions']}
    Should be true    ${jsonvalues_questions['assertStatus']}    ${jsonvalues_questions}
