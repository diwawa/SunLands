*** Settings ***
Variables         ../../Datas/Response/TRANS.py


*** Keywords ***
trans_api_v1_order_prePay_resp
	${resp}    evaluate    ${trans_api_v1_order_prePay_resp}
	Should Be Equal    ${resp}    ${sql}


trans_api_v1_order_pay_resp
	${resp}    evaluate    ${trans_api_v1_order_pay_resp}
	Should Be Equal    ${resp['package']}    ${sql}
	Should Be Equal    ${resp['timeStamp']}    ${sql}
	Should Be Equal    ${resp['signType']}    ${sql}
	Should Be Equal    ${resp['paySign']}    ${sql}
	Should Be Equal    ${resp['appId']}    ${sql}
	Should Be Equal    ${resp['nonceStr']}    ${sql}


trans_api_v1_order_resp
	${resp}    evaluate    ${trans_api_v1_order_resp}
	Should Be Equal    ${resp[0]['commodityId']}    ${sql}
	Should Be Equal    ${resp[0]['orderCode']}    ${sql}
	Should Be Equal    ${resp[0]['commodityImage']}    ${sql}
	Should Be Equal    ${resp[0]['streamId']}    ${sql}
	Should Be Equal    ${resp[0]['commodityName']}    ${sql}
	Should Be Equal    ${resp[0]['payStatus']}    ${sql}
	Should Be Equal    ${resp[0]['commodityType']}    ${sql}


trans_api_v1_users_token_resp
	${resp}    evaluate    ${trans_api_v1_users_token_resp}
	Should Be Equal    ${resp['token']}    ${sql}
	Should Be Equal    ${resp['refreshToken']}    ${sql}


