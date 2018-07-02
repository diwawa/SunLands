*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Library           DateTime
Resource          ../../API/DailyPractice.robot
Resource          ../Resource/Question.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/DailyPractice.py
Variables         ../../Datas/Response/DailyPractice.py

*** Test Cases ***
dailyPractice_clockInSum
    [Documentation]    打卡总数
    [Tags]    Run
    ${resp}    get/dailyPractice/clockInSum    ${token}
    set suite variable    ${clockInSum}    ${resp}

dailyPractice_calendar
    [Documentation]    每日一练日历
    [Tags]    Run
    ${date}    Get Current Date    result_format=datetime
    ${resp}    get/dailyPractice/calendar    ${token}    ${date.year}    ${date.month}
    ${sql_daily}    dailyPractice    ${userId}
    should be equal as strings    ${resp['clockInSum']}    ${clockInSum}
    #    should be equal as strings    ${resp['dateSum']}    ${sql_daily['continue_sum']}
    ${resp_len}    Get Length    ${resp['dateList']}
    ${sql_len}    Get Length    ${sql_daily['clock_in_details']}
    should be equal as integers    ${resp_len}    ${sql_len}
    : FOR    ${x}    IN RANGE    ${resp_len}
    \    should be equal as integers    ${resp['dateList'][${x}]['number']}    ${sql_daily['clock_in_details'][${x}][0]}
    \    should be equal as integers    ${resp['dateList'][${x}]['status']}    ${sql_daily['clock_in_details'][${x}][1]}
    \    should be equal    ${resp['dateList'][${x}]['choosed']}    ${False}

dailyPractice_examPapers_1
    [Documentation]    每日一练任务列表，打卡前
    [Tags]    Run
    ${resp}    get/dailyPractice/examPapers    ${token}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Integers    ${resp['clockIn']}    2
    set suite variable    ${assignmentList}    ${resp['assignmentList']}
    ${sql_daily}    dailyPractice    ${userId}
    #    Should Be Equal As Integers    ${resp['clockInSum']}    ${sql_daily['clock_in_sum']}
    ${donesum}    set variable    0
    ${schedult}    set variable    0
    ${len}    Get Length    ${resp['assignmentList']}
    : FOR    ${x}    IN RANGE    ${len}
    \    ${sql_assignment}    dailyPracticeAssignment    ${userId}    ${resp['assignmentList'][${x}]['assignmentId']}
    \    ${donesum}    set variable if    ${donesum}>${sql_assignment['today_clock_in_sum']}    ${donesum}    ${sql_assignment['today_clock_in_sum']}
    \    Should Be Equal As Integers    ${resp['assignmentList'][${x}]['total']}    ${sql_assignment['question_sum']}
    \    ${is_done}    set variable if    ${sql_assignment['is_done']}==0    ${False}    ${True}
    \    Should Be Equal    ${resp['assignmentList'][${x}]['finish']}    ${is_done}
    \    ${temp}    set variable if    ${is_done}    1    0
    \    ${schedult}    evaluate    ${schedult}+${temp}
    \    Should Be Equal As Integers    ${resp['assignmentList'][${x}]['people']}    ${sql_assignment['done_sum']}
    \    Should Be Equal As Integers    ${resp['assignmentList'][${x}]['current']}    ${sql_assignment['answer_question_sum']}
    \    Should Be Equal As Strings    ${resp['assignmentList'][${x}]['assignmentName']}    ${sql_assignment['assignment_name']}
    should be equal as integers    ${resp['donesum']}    ${donesum}
    ${schedult}    evaluate    str(${schedult})+"/"+str(${len})
    should be equal as strings    ${resp['schedult']}    ${schedult}
    ${sql_assignment}    dailyPracticeAssignment    ${userId}    ${resp['assignmentList'][0]['assignmentId']}
    : FOR    ${x}    IN RANGE    5
    \    ${sql_info}    userInfo    ${sql_assignment['user_ids'][${x}]}
    \    Should Be Equal As Strings    ${resp['headImages'][${x}]['imagesUrl']}    ${sql_info['head_image_url']}

dailyPractice_examPapers_2
    [Documentation]    每日一练任务列表,答题后，打卡前
    [Tags]    Run
    ${data}    RE_DailyPractice    ${assignmentList}
    ${resp}    get/dailyPractice/examPapers    ${token}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ${sql_daily}    dailyPractice    ${userId}
    Should Be Equal As Integers    ${resp['clockIn']}    1
    #    Should Be Equal As Integers    ${resp['clockInSum']}    ${sql_daily['clock_in_sum']}
    ${donesum}    set variable    0
    ${schedult}    set variable    0
    ${len}    Get Length    ${resp['assignmentList']}
    : FOR    ${x}    IN RANGE    ${len}
    \    ${sql_assignment}    dailyPracticeAssignment    ${userId}    ${resp['assignmentList'][${x}]['assignmentId']}
    \    ${donesum}    set variable if    ${donesum}>${sql_assignment['today_clock_in_sum']}    ${donesum}    ${sql_assignment['today_clock_in_sum']}
    \    Should Be Equal As Integers    ${resp['assignmentList'][${x}]['total']}    ${sql_assignment['question_sum']}
    \    ${is_done}    set variable if    ${sql_assignment['is_done']}==0    ${False}    ${True}
    \    Should Be Equal    ${resp['assignmentList'][${x}]['finish']}    ${is_done}
    \    ${temp}    set variable if    ${is_done}    1    0
    \    ${schedult}    evaluate    ${schedult}+${temp}
    \    Should Be Equal As Integers    ${resp['assignmentList'][${x}]['people']}    ${sql_assignment['done_sum']}
    \    Should Be Equal As Integers    ${resp['assignmentList'][${x}]['current']}    ${sql_assignment['answer_question_sum']}
    \    Should Be Equal As Strings    ${resp['assignmentList'][${x}]['assignmentName']}    ${sql_assignment['assignment_name']}
    should be equal as integers    ${resp['donesum']}    ${donesum}
    ${schedult}    evaluate    str(${schedult})+"/"+str(${len})
    should be equal as strings    ${resp['schedult']}    ${schedult}
    ${sql_assignment}    dailyPracticeAssignment    ${userId}    ${resp['assignmentList'][0]['assignmentId']}
    : FOR    ${x}    IN RANGE    5
    \    ${sql_info}    userInfo    ${sql_assignment['user_ids'][${x}]}
    \    Should Be Equal As Strings    ${resp['headImages'][${x}]['imagesUrl']}    ${sql_info['head_image_url']}


dailyPractice_userClockIn
    [Documentation]    今日打卡
    [Tags]    Run
    ${resp}    post/dailyPractice/userClockIn    ${token}
    ${sql_daily}    dailyPractice    ${userId}
    Should Be Equal    ${resp['examTypeId']}    ${sql_daily['exam_type_id']}
    ${clockInSum}    evaluate    int(${clockInSum})+1
    Should Be Equal    ${resp['clockInSum']}    ${clockInSum}

dailyPractice_examPapers_3
    [Documentation]    每日一练任务列表,打卡后
    [Tags]    Run
    ${resp}    get/dailyPractice/examPapers    ${token}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ${sql_daily}    dailyPractice    ${userId}
    Should Be Equal As Integers    ${resp['clockIn']}    0
    #    Should Be Equal As Integers    ${resp['clockInSum']}    ${sql_daily['clock_in_sum']}
    ${donesum}    set variable    0
    ${schedult}    set variable    0
    ${len}    Get Length    ${resp['assignmentList']}
    Comment    ${len}    evaluate    len(${resp['assignmentList']})
    : FOR    ${x}    IN RANGE    ${len}
    \    ${sql_assignment}    dailyPracticeAssignment    ${userId}    ${resp['assignmentList'][${x}]['assignmentId']}
    \    ${donesum}    set variable if    ${donesum}>${sql_assignment['today_clock_in_sum']}    ${donesum}    ${sql_assignment['today_clock_in_sum']}
    \    Should Be Equal As Integers    ${resp['assignmentList'][${x}]['total']}    ${sql_assignment['question_sum']}
    \    ${is_done}    set variable if    ${sql_assignment['is_done']}==0    ${False}    ${True}
    \    Should Be Equal    ${resp['assignmentList'][${x}]['finish']}    ${is_done}
    \    ${temp}    set variable if    ${is_done}    1    0
    \    ${schedult}    evaluate    ${schedult}+${temp}
    \    Should Be Equal As Integers    ${resp['assignmentList'][${x}]['people']}    ${sql_assignment['done_sum']}
    \    Should Be Equal As Integers    ${resp['assignmentList'][${x}]['current']}    ${sql_assignment['answer_question_sum']}
    \    Should Be Equal As Strings    ${resp['assignmentList'][${x}]['assignmentName']}    ${sql_assignment['assignment_name']}
    should be equal as integers    ${resp['donesum']}    ${donesum}
    ${schedult}    evaluate    str(${schedult})+"/"+str(${len})
    should be equal as strings    ${resp['schedult']}    ${schedult}
    ${sql_assignment}    dailyPracticeAssignment    ${userId}    ${resp['assignmentList'][0]['assignmentId']}
    : FOR    ${x}    IN RANGE    5
    \    ${sql_info}    userInfo    ${sql_assignment['user_ids'][${x}]}
    \    Should Be Equal As Strings    ${resp['headImages'][${x}]['imagesUrl']}    ${sql_info['head_image_url']}
