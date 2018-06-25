*** Settings ***
Variables         ../../Datas/Response/ExamType.py


*** Keywords ***
examTypes_resp
	${resp}    evaluate    ${examTypes_resp}
	Should Be Equal    ${resp[0]['id']}    ${sql}
	Should Be Equal    ${resp[0]['item'][0]['id']}    ${sql}
	Should Be Equal    ${resp[0]['item'][0]['primaryCategories']}    ${sql}
	Should Be Equal    ${resp[0]['item'][0]['description']}    ${sql}
	Should Be Equal    ${resp[0]['item'][0]['parentId']}    ${sql}
	Should Be Equal    ${resp[0]['primaryCategories']}    ${sql}
	Should Be Equal    ${resp[0]['description']}    ${sql}
	Should Be Equal    ${resp[0]['parentId']}    ${sql}


