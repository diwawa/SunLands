*** Settings ***
Force Tags        DocTest    CUT_PRICE
Library           ../../Lib/JsonRead.py
Library           ../../Lib/GetSQL.py
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
post/trans/api/v1/cutPrice/reSystemCutPrice
	[Documentation]    系统砍价
	[Tags]    Run
	${params}    getParam_data    CUT_PRICE    post/trans/api/v1/cutPrice/reSystemCutPrice
	${resp}    getApiResp    ${token}    post    /trans/api/v1/cutPrice/reSystemCutPrice    ${params['systemCutPriceRequest']}
	${result}    docmentAssert    post    /trans/api/v1/cutPrice/reSystemCutPrice    ${resp}
	should be true     ${result[0]}     ${result}

post/trans/api/v1/cutPrice/getCutPriceHelpTimes
	[Documentation]    用户帮助砍价次数
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /trans/api/v1/cutPrice/getCutPriceHelpTimes
	${result}    docmentAssert    get    /trans/api/v1/cutPrice/getCutPriceHelpTimes    ${resp}
	should be true     ${result[0]}     ${result}

post/trans/api/v1/cutPrice/friendsCutPrice
	[Documentation]    好友砍价
	[Tags]    Run
    update commodity cut To create date      5     ${userId}    ${userId2}
	${params}    getParam_data    CUT_PRICE    post/trans/api/v1/cutPrice/friendsCutPrice
	${resp}    getApiResp    ${token2}    post    /trans/api/v1/cutPrice/friendsCutPrice    ${params['friendsCutPriceRequest']}
	${result}    docmentAssert    post    /trans/api/v1/cutPrice/friendsCutPrice    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/cutPrice/getCommodityInfo
	[Documentation]    获取用户活动详情
	[Tags]    Run
	${params}    getParam_data    CUT_PRICE    get/trans/api/v1/cutPrice/getCommodityInfo
	${resp}    getApiResp    ${token}    get    /trans/api/v1/cutPrice/getCommodityInfo    ${params}
	${result}    docmentAssert    get    /trans/api/v1/cutPrice/getCommodityInfo    ${resp}
	should be true     ${result[0]}     ${result}

post/trans/api/v1/cutPrice/systemCutPrice
	[Documentation]    系统砍价
	[Tags]    NotRun
	${params}    getParam_data    CUT_PRICE    post/trans/api/v1/cutPrice/systemCutPrice
	${resp}    getApiResp    ${token}    post    /trans/api/v1/cutPrice/systemCutPrice    ${params}
	${result}    docmentAssert    post    /trans/api/v1/cutPrice/systemCutPrice    ${resp}
	should be true     ${result[0]}     ${result}

