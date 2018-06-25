*** Settings ***
Variables         ../../Datas/Response/UserClockIn.py


*** Keywords ***
userClockInRecord_resp
	${resp}    evaluate    ${userClockInRecord_resp}
	Should Be Equal     ${resp[0]}    ${sql}


userClockIn_resp
	${resp}    evaluate    ${userClockIn_resp}
	Should Be Equal    ${resp}    ${sql}


