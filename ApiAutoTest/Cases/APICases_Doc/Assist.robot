*** Settings ***
Force Tags        DocTest    Assist
Library           ../../Lib/JsonRead.py
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
post/assist
	[Documentation]    创建助力活动
	[Tags]    NotRun
	${params}    getParam_data    Assist    post/assist
	${resp}    getApiResp    ${token}    post    /assist    ${params}
	${result}    docmentAssert    post    /assist    ${resp}
	should be true     ${result[0]}     ${result}

get/assist
	[Documentation]    助力详情
	[Tags]    NotRun
	${params}    getParam_data    Assist    get/assist
	${resp}    getApiResp    ${token}    get    /assist    ${params}
	${result}    docmentAssert    get    /assist    ${resp}
	should be true     ${result[0]}     ${result}

get/assist/share
	[Documentation]    分享助力活动
	[Tags]    NotRun
	${params}    getParam_data    Assist    get/assist/share
	${resp}    getApiResp    ${token}    get    /assist/share    ${params}
	${result}    docmentAssert    get    /assist/share    ${resp}
	should be true     ${result[0]}     ${result}

get/assist/joinNum
	[Documentation]    参加某项助力活动的人数
	[Tags]    NotRun
	${params}    getParam_data    Assist    get/assist/joinNum
	${resp}    getApiResp    ${token}    get    /assist/joinNum    ${params}
	${result}    docmentAssert    get    /assist/joinNum    ${resp}
	should be true     ${result[0]}     ${result}

get/assit/list
	[Documentation]    助力列表
	[Tags]    NotRun
	${params}    getParam_data    Assist    get/assit/list
	${resp}    getApiResp    ${token}    get    /assit/list    ${params}
	${result}    docmentAssert    get    /assit/list    ${resp}
	should be true     ${result[0]}     ${result}

post/assist/join
	[Documentation]    好友助力
	[Tags]    NotRun
	${params}    getParam_data    Assist    post/assist/join
	${resp}    getApiResp    ${token}    post    /assist/join    ${params}
	${result}    docmentAssert    post    /assist/join    ${resp}
	should be true     ${result[0]}     ${result}

post/assist/restart/{assistId}
	[Documentation]    重新开始
	[Tags]    NotRun
	${params}    getParam_data    Assist    post/assist/restart/{assistId}
	${resp}    getApiResp    ${token}    post    /assist/restart/{assistId}    ${params}
	${result}    docmentAssert    post    /assist/restart/{assistId}    ${resp}
	should be true     ${result[0]}     ${result}

