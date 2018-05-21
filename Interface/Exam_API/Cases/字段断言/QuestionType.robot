*** Settings ***
Documentation     有返回值得接口断言与接口文档是否一致
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Force Tags        对比文档
Metadata          name    Key_QuestionType
Resource          ../../Common/Resource/ComTest.robot
Library           ../../Common/Library/Function.py
Resource          ../../API/QuestionType.robot
Variables         ../../AssertJson/QuestionType.py

*** Test Cases ***
chapters
    ${data}    GET/questionTypes/chapters    CHAPTER_PRACTICE
    ${jsonkeys}    Compare Jsonkeys    ${chapters}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${chapters}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_chapters}    Compare Jsonkeys    ${chapters["chapters"]}    ${data["chapters"]}
    Should be true    ${jsonkeys_chapters['assertStatus']}    ${jsonkeys_chapters}
    ${jsonvalues_chapters}    compareJsonvaluesTpye    ${chapters["chapters"]}    ${data["chapters"]}
    Should be true    ${jsonvalues_chapters['assertStatus']}    ${jsonvalues_chapters}

myQuestionStem_chapterId
    ${data}    GET/questionTypes/myQuestionStem/{chapterId}    223889    MY_COLLECT
    ${jsonkeys}    Compare Jsonkeys    ${myQuestionStem_chapterId}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${myQuestionStem_chapterId}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}

examPapers
    ${data}    GET/questionTypes/examPapers
    ${jsonkeys}    Compare Jsonkeys    ${examPapers}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${examPapers}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}

examPapers_history
    ${data}    GET/questionTypes/examPapers/history
    ${jsonkeys}    Compare Jsonkeys    ${examPapers_history}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${examPapers_history}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}

examQuestion
    ${data}    GET/questionTypes/examQuestion    CHAPTER_PRACTICE    1    1    0    223889
    ${jsonkeys}    Compare Jsonkeys    ${examQuestion}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${examQuestion}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_options}    Compare Jsonkeys    ${examQuestion['options']}    ${data['options']}
    Should be true    ${jsonkeys_options['assertStatus']}    ${jsonkeys_options}
    ${jsonvalues_options}    compareJsonvaluesTpye    ${examQuestion['options']}    ${data['options']}
    Should be true    ${jsonvalues_options['assertStatus']}    ${jsonvalues_options}
    ${jsonkeys_answer}    Compare Jsonkeys    ${examQuestion['answer']}    ${data['answer']}
    Should be true    ${jsonkeys_answer['assertStatus']}    ${jsonkeys_answer}
    ${jsonvalues_answer}    compareJsonvaluesTpye    ${examQuestion['answer']}    ${data['answer']}
    Should be true    ${jsonvalues_answer['assertStatus']}    ${jsonvalues_answer}
