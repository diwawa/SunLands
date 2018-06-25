*** Settings ***
Variables         ../../Datas/Response/IM.py


*** Keywords ***
commodity_api_v1_IM_quit_resp
	${resp}    evaluate    ${commodity_api_v1_IM_quit_resp}
	Should Be Equal    ${resp}    ${sql}


commodity_api_v1_IM_join_resp
	${resp}    evaluate    ${commodity_api_v1_IM_join_resp}
	Should Be Equal    ${resp['Identifier']}    ${sql}
	Should Be Equal    ${resp['UserSig']}    ${sql}
	Should Be Equal    ${resp['groupId']}    ${sql}


