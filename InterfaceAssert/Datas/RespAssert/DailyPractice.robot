*** Settings ***
Variables         ../../Datas/Response/DailyPractice.py


*** Keywords ***
dailyPractice_examPapers_resp
	${resp}    evaluate    ${dailyPractice_examPapers_resp}
	Should Be Equal    ${resp['clockIn']}    ${sql}
	Should Be Equal    ${resp['clockInSum']}    ${sql}
	Should Be Equal    ${resp['donesum']}    ${sql}
	Should Be Equal    ${resp['schedult']}    ${sql}
	Should Be Equal    ${resp['assignmentList'][0]['totle']}    ${sql}
	Should Be Equal    ${resp['assignmentList'][0]['finish']}    ${sql}
	Should Be Equal    ${resp['assignmentList'][0]['people']}    ${sql}
	Should Be Equal    ${resp['assignmentList'][0]['assignmentId']}    ${sql}
	Should Be Equal    ${resp['assignmentList'][0]['current']}    ${sql}
	Should Be Equal    ${resp['assignmentList'][0]['assignmentName']}    ${sql}
	Should Be Equal    ${resp['headImages'][0]['imagesUrl']}    ${sql}


dailyPractice_calendar_resp
	${resp}    evaluate    ${dailyPractice_calendar_resp}
	Should Be Equal    ${resp['dateSum']}    ${sql}
	Should Be Equal    ${resp['dateList'][0]['status']}    ${sql}
	Should Be Equal    ${resp['dateList'][0]['choosed']}    ${sql}
	Should Be Equal    ${resp['dateList'][0]['number']}    ${sql}
	Should Be Equal    ${resp['clockInSum']}    ${sql}


dailyPractice_userClockIn_resp
	${resp}    evaluate    ${dailyPractice_userClockIn_resp}
	Should Be Equal    ${resp['examTypeId']}    ${sql}
	Should Be Equal    ${resp['clockInSum']}    ${sql}


dailyPractice_clockInSum_resp
	${resp}    evaluate    ${dailyPractice_clockInSum_resp}
	Should Be Equal    ${resp['clockInSum']}    ${sql}


