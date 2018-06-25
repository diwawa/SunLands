*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/TRANS.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/TRANS.py
Variables         ../../Datas/Response/TRANS.py


*** Test Cases ***
trans_api_v1_order_prePay
	[Documentation]    预生成订单（芒果会计小程序）
	[Tags]    Run
	${resp}    post/trans/api/v1/order/prePay    ${token}    ${trans_api_v1_order_prePay_param['orderParams']}
	should be equal as strings    ${resp}    ${trans_api_v1_order_prePay_resp}

trans_api_v1_order
	[Documentation]    订单列表（公众号）
	[Tags]    Run
	${resp}    get/trans/api/v1/order    ${token}
	set suite variable    ${orderCode}    ${resp[0]['orderCode']}
	${result}    compareResp    ${trans_api_v1_order_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${trans_api_v1_order_resp[0]}    ${resp[0]}
	Should Be True    ${result['status']}    ${result}

trans_api_v1_order_pay
	[Documentation]    立即支付（公众号）
	[Tags]    Run
	${resp}    post/trans/api/v1/order/pay    ${token}    ${orderCode}
	${result}    compareResp    ${trans_api_v1_order_pay_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

trans_api_v1_users_token
	[Documentation]    微信公众号获取授权（公众号）
	[Tags]    NotRun
	${resp}    get/trans/api/v1/users/token    ${token}    ${trans_api_v1_users_token_param['code']}
	${result}    compareResp    ${trans_api_v1_users_token_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

