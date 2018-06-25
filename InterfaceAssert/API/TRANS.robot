*** Settings ***
Library          RequestsLibrary
Library          Collections


*** Keywords ***
get/trans/api/v1/order
	[Arguments]    ${token}
	[Documentation]    订单列表（公众号）
	Create Session    exam    https://exam.zmgongzuoshi.top
	${headers}    Create Dictionary    Authorization    ${token}    ReqChannel    HULUO_PUBLIC
	${resp}    get request    exam    /trans/api/v1/order    headers=${headers}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/trans/api/v1/order/pay
	[Arguments]    ${token}    ${orderCode}
	[Documentation]    立即支付（公众号）
	Create Session    exam    https://exam.zmgongzuoshi.top
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json    ReqChannel    HULUO_PUBLIC
	${params}    Create Dictionary    orderCode    ${orderCode}    
	${resp}    post request    exam    /trans/api/v1/order/pay    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


post/trans/api/v1/order/prePay
	[Arguments]    ${token}    ${orderParams}
	[Documentation]    预生成订单（芒果会计小程序）
	Create Session    exam    https://exam.zmgongzuoshi.top
	${headers}    Create Dictionary    Authorization    ${token}    Content-Type    application/json    ReqChannel    MANGO_ACCOUNTING
	${params}    set variable    ${orderParams}    
	${resp}    post request    exam    /trans/api/v1/order/prePay    headers=${headers}    data=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}


get/trans/api/v1/users/token
	[Arguments]    ${token}    ${code}
	[Documentation]    微信公众号获取授权（公众号）
	Create Session    exam    https://exam.zmgongzuoshi.top
	${headers}    Create Dictionary    Authorization    ${token}    ReqChannel    MANGO_ACCOUNTING
	${params}    Create Dictionary    code    ${code}    
	${resp}    get request    exam    /trans/api/v1/users/token    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	${json}    to json    ${resp.content}
	log    ${json}
	[Return]    ${json}


