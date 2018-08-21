*** Settings ***
Force Tags        DocTest    TRANS
Library           ../../Lib/JsonRead.py
Library           ../../Lib/GetSQL.py
Library           Collections
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
post/trans/api/v1/order/prePay
	[Documentation]    预生成订单（芒果会计小程序）
	[Tags]    Run
	${params}    getParam_data    TRANS    post/trans/api/v1/order/prePay
	${resp}    getApiResp    ${token}    post    /trans/api/v1/order/prePay    ${params['userOrderPostParam']}
	${result}    docmentAssert    post    /trans/api/v1/order/prePay    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/order
	[Documentation]    未支付订单列表（公众号）
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /trans/api/v1/order
	set suite variable      ${orderCode}    ${resp[0]['orderCode']}
	${result}    docmentAssert    get    /trans/api/v1/order    ${resp}
	should be true     ${result[0]}     ${result}

post/trans/api/v1/order/pay
	[Documentation]    立即支付（公众号）
	[Tags]    Run
	${params}    getParam_data    TRANS    post/trans/api/v1/order/pay
	set to dictionary    ${params}     orderCode    ${orderCode}
	${resp}    getApiResp    ${token}    post    /trans/api/v1/order/pay    ${params}
	${result}    docmentAssert    post    /trans/api/v1/order/pay    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/commodity/already_recommendInfos
	[Documentation]    已购列表（芒果会计小程序）
	[Tags]    Run
	update already order To pay status    2
	${resp}    getApiResp    ${token}    get    /trans/api/v1/commodity/already
	${result}    docmentAssert2    get    /trans/api/v1/commodity/already    ${resp}    alreadyInfos
	should be true     ${result[0]}     ${result}

get/trans/api/v1/commodity/already_alreadyInfos
	[Documentation]    已购列表（芒果会计小程序）
	[Tags]    Run
	update already order To pay status    1
	${resp}    getApiResp    ${token}    get    /trans/api/v1/commodity/already
	set suite variable      ${commodityId}     ${resp['alreadyInfos'][0]['commodityId']}
	${result}    docmentAssert2    get    /trans/api/v1/commodity/already    ${resp}    recommendInfos
	should be true     ${result[0]}     ${result}

get/trans/api/v1/commodity/already/details
	[Documentation]    已购详情（芒果会计小程序）
	[Tags]    Run
	${params}    getParam_data    TRANS    get/trans/api/v1/commodity/already/details
	set to dictionary    ${params}      commodityId    ${commodityId}
	${resp}    getApiResp    ${token}    get    /trans/api/v1/commodity/already/details    ${params}
	${result}    docmentAssert    get    /trans/api/v1/commodity/already/details    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/commodity/recommend
	[Documentation]    商城推荐列表（芒果会计小程序）
	[Tags]    Run
	${params}    getParam_data    TRANS    get/trans/api/v1/commodity/recommend
	${resp}    getApiResp    ${token}    get    /trans/api/v1/commodity/recommend    ${params}
	${result}    docmentAssert    get    /trans/api/v1/commodity/recommend    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/commodity/system
	[Documentation]    系统课列表（芒果会计小程序）
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /trans/api/v1/commodity/system
	set suite variable      ${commodityId}     ${resp[0]['commodityId']}
	set suite variable      ${commodityId1}     ${resp[1]['commodityId']}
	set suite variable      ${commodityId2}     ${resp[2]['commodityId']}
	${result}    docmentAssert    get    /trans/api/v1/commodity/system    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/commodity/system/details
	[Documentation]    系统课详情（芒果会计小程序）
	[Tags]    Run
	${params}    getParam_data    TRANS    get/trans/api/v1/commodity/system/details
	set to dictionary    ${params}      commodityId    ${commodityId}
	${resp}    getApiResp    ${token}    get    /trans/api/v1/commodity/system/details    ${params}
	${result}    docmentAssert    get    /trans/api/v1/commodity/system/details    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/commodity/system/status
	[Documentation]    系统课状态（芒果会计小程序）
	[Tags]    Run
	${params}    getParam_data    TRANS    get/trans/api/v1/commodity/system/status
    ${commodityIds}    create list    ${commodityId}    ${commodityId1}    ${commodityId2}
    set to dictionary      ${params}    commodityIds    ${commodityIds}
	${resp}    getApiResp    ${token}    get    /trans/api/v1/commodity/system/status    ${params}
	${result}    docmentAssert    get    /trans/api/v1/commodity/system/status    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/users/token
	[Documentation]    微信公众号获取授权（公众号）
	[Tags]    NotRun
	${params}    getParam_data    TRANS    get/trans/api/v1/users/token
	${resp}    getApiResp    ${token}    get    /trans/api/v1/users/token    ${params}
	${result}    docmentAssert    get    /trans/api/v1/users/token    ${resp}
	should be true     ${result[0]}     ${result}








