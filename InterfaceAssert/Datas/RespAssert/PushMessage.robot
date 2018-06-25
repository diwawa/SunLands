*** Settings ***
Variables         ../../Datas/Response/PushMessage.py


*** Keywords ***
pushMessage_formid_resp
	${resp}    evaluate    ${pushMessage_formid_resp}
	Should Be Equal    ${resp}    ${sql}


