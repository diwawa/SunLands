*** Settings ***
Documentation     有返回值得接口断言与接口文档是否一致
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        对比文档
Metadata          name    Key_Subject
Resource          ../../Common/Resource/ComTest.robot
Library           ../../Common/Library/Function.py
Resource          ../../API/Subject.robot
Variables         ../../AssertJson/Subject.py

*** Test Cases ***
subjects
    ${data}    GET/subjects    2
    ${jsonkeys}    Compare Jsonkeys    ${subjects}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${subjects}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_item}    Compare Jsonkeys    ${subjects[0]["item"]}    ${data[0]["item"]}
    Should be true    ${jsonkeys_item['assertStatus']}    ${jsonkeys_item}
    ${jsonvalues_item}    compareJsonvaluesTpye    ${subjects[0]["item"]}    ${data[0]["item"]}
    Should be true    ${jsonvalues_item['assertStatus']}    ${jsonvalues_item}
