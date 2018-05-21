*** Settings ***
Documentation     有返回值得接口断言与接口文档是否一致
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        对比文档
Metadata          name    Key_AnswerPlan
Resource          ../../Common/Resource/ComTest.robot
Library           ../../Common/Library/Function.py
Resource          ../../API/AnswerPlan.robot
Variables         ../../AssertJson/AnswerPlan.py

*** Test Cases ***
answerPlans
    ${data}    GET/answerPlans
    ${jsonkeys}    Compare Jsonkeys    ${answerPlans}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${answerPlans}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
