*** Settings ***
Variables         ../../Datas/Response/Subject.py


*** Keywords ***
subjects_resp
	${resp}    evaluate    ${subjects_resp}
	Should Be Equal    ${resp[0]['examTypeId']}    ${sql}
	Should Be Equal    ${resp[0]['subjectName']}    ${sql}
	Should Be Equal    ${resp[0]['number']}    ${sql}
	Should Be Equal    ${resp[0]['subjectId']}    ${sql}


