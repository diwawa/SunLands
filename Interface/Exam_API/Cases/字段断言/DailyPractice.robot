*** Settings ***
Documentation     有返回值得接口断言与接口文档是否一致
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        对比文档
Metadata          name    Key_DailyPractice
Resource          ../../Common/Resource/ComTest.robot
Library           ../../Common/Library/Function.py
Resource          ../../API/DailyPractice.robot
Variables         ../../AssertJson/DailyPractice.py
Library           DateTime

*** Test Cases ***
examPapers
    ${data}    GET/dailyPractice/examPapers    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ${jsonkeys}    Compare Jsonkeys    ${examPapers}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${examPapers}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_headImages}    Compare Jsonkeys    ${examPapers['headImages']}    ${data['headImages']}
    Should be true    ${jsonkeys_headImages['assertStatus']}    ${jsonkeys_headImages}
    ${jsonvalues_headImages}    compareJsonvaluesTpye    ${examPapers['headImages']}    ${data['headImages']}
    Should be true    ${jsonvalues_headImages['assertStatus']}    ${jsonvalues_headImages}
    ${jsonkeys_assignmentList}    Compare Jsonkeys    ${examPapers['assignmentList']}    ${data['assignmentList']}
    Should be true    ${jsonkeys_assignmentList['assertStatus']}    ${jsonkeys_assignmentList}
    ${jsonvalues_assignmentList}    compareJsonvaluesTpye    ${examPapers['assignmentList']}    ${data['assignmentList']}
    Should be true    ${jsonvalues_assignmentList['assertStatus']}    ${jsonvalues_assignmentList}

calendar
    ${date}    Get Current Date    result_format=datetime
    ${data}    GET/dailyPractice/calendar    ${date.year}    ${date.month}
    ${jsonkeys}    Compare Jsonkeys    ${calendar}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${calendar}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_dateList}    Compare Jsonkeys    ${calendar['dateList']}    ${data['dateList']}
    Should be true    ${jsonkeys_dateList['assertStatus']}    ${jsonkeys_dateList}
    ${jsonvalues_dateList}    compareJsonvaluesTpye    ${calendar['dateList']}    ${data['dateList']}
    Should be true    ${jsonvalues_dateList['assertStatus']}    ${jsonvalues_dateList}
