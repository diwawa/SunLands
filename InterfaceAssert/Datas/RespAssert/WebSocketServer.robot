*** Settings ***
Variables         ../../Datas/Response/WebSocketServer.py


*** Keywords ***
webSocketServer_pk_resp
	${resp}    evaluate    ${webSocketServer_pk_resp}
	Should Be Equal    ${resp['MARK_TIMEOUT']}    ${sql}
	Should Be Equal    ${resp['END']}    ${sql}
	Should Be Equal    ${resp['JOIN_ERROR']}    ${sql}
	Should Be Equal    ${resp['NEXT']}    ${sql}
	Should Be Equal    ${resp['START']}    ${sql}
	Should Be Equal    ${resp['GIVE_UP']}    ${sql}
	Should Be Equal    ${resp['ERROR']}    ${sql}
	Should Be Equal    ${resp['READY']}    ${sql}
	Should Be Equal    ${resp['FIND']}    ${sql}


