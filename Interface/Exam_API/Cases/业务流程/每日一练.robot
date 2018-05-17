*** Settings ***
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Metadata          name    每日一练
Resource          ../../Bussiness/每日一练.robot
Resource          ../../Common/Resource/ComTest.robot
Library           DatabaseLibrary

*** Test Cases ***
修改科目
    ${examTypeIdInput}    set Variable    5
    ${subjectIdInput}    set Variable    440
    ${examTypeAssert}    Query    SELECT primary_categories FROM exam_type WHERE id=${examTypeIdInput}
    ${currentSubjectAssert}    Query    SELECT subject_name FROM `subject` WHERE id=${subjectIdInput}
    PUT/users/examTypes    ${examTypeIdInput}    true
    PUT/users/subjects    ${subjectIdInput}
    ${me}=    GET/users/me    ${EMPTY}    ${EMPTY}
    ${examType}    Get From Dictionary    ${me}    examType
    ${examTypeId}    Get From Dictionary    ${me}    examTypeId
    ${currentSubject}    Get From Dictionary    ${me}    currentSubject
    Should Be Equal As Strings    ${examType}    ${examTypeAssert[0][0]}
    Should Be Equal As Integers    ${examTypeId}    ${examTypeIdInput}
    Should Be Equal As Strings    ${currentSubject}    ${currentSubjectAssert[0][0]}

当前科目打卡
    ${clockIn}    打卡
    #查看日历    年    月
    ${date}    Get Current Date    result_format=datetime
    ${calendar}    GET/dailyPractice/calendar    ${date.year}    ${date.month}
    ${clockInSum}    GET/dailyPractice/clockInSum
