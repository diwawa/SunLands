*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/DailyPractice.robot
Resource          ../Resource/Question.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/DailyPractice.py
Variables         ../../Datas/Response/DailyPractice.py


*** Test Cases ***
dailyPractice_calendar
	[Documentation]    每日一练日历
	[Tags]    Run
	${resp}    get/dailyPractice/calendar    ${token}    2018    6
	${result}    compareResp    ${dailyPractice_calendar_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${dailyPractice_calendar_resp['dateList'][0]}    ${resp['dateList'][0]}
	Should Be True    ${result['status']}    ${result}
	should be equal

dailyPractice_examPapers
	[Documentation]    每日一练任务列表
	[Tags]    Run
	${resp}    get/dailyPractice/examPapers    ${token}    ${EMPTY}    ${EMPTY}    ${EMPTY}
	set suite variable     ${assignmentList}     ${resp['assignmentList']}
	${result}    compareResp    ${dailyPractice_examPapers_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${dailyPractice_examPapers_resp['headImages'][0]}    ${resp['headImages'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${dailyPractice_examPapers_resp['assignmentList'][0]}    ${resp['assignmentList'][0]}
	Should Be True    ${result['status']}    ${result}

dailyPractice_userClockIn
	[Documentation]    今日打卡
	[Tags]    Run
	RE_DailyPractice    ${assignmentList}
	${resp}    post/dailyPractice/userClockIn    ${token}
	${result}    compareResp    ${dailyPractice_userClockIn_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

dailyPractice_clockInSum
	[Documentation]    打卡总数
	[Tags]    Run
	${resp}    get/dailyPractice/clockInSum    ${token}
	${result}    compareResp    ${dailyPractice_clockInSum_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}



