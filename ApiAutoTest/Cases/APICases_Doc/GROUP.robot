*** Settings ***
Force Tags        DocTest    GROUP
Library           ../../Lib/JsonRead.py
Library           ../../Lib/GetSQL.py
Library           Collections
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
post/trans/api/v1/group/create
	[Documentation]    开团
	[Tags]    Run
	update group order To del flag      ${userId}
	${params}    getParam_data    GROUP    post/trans/api/v1/group/create
	${resp}    getApiResp    ${token}    post    /trans/api/v1/group/create    ${params}
	set suite variable      ${id}    ${resp['groupOrderId']}
	update group order To status     ${id}
	${result}    docmentAssert    post    /trans/api/v1/group/create    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/group/list
	[Documentation]    可以加入团列表
	[Tags]    Run
	${params}    getParam_data    GROUP    get/trans/api/v1/group/list
	${resp}    getApiResp    ${token2}    get    /trans/api/v1/group/list    ${params}
	${result}    docmentAssert    get    /trans/api/v1/group/list    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/group/isAdd
	[Documentation]    是否参团
	[Tags]    Run
	${params}    getParam_data    GROUP    get/trans/api/v1/group/isAdd
	${resp}    getApiResp    ${token2}    get    /trans/api/v1/group/isAdd    ${params}
	${result}    docmentAssert    get    /trans/api/v1/group/isAdd    ${resp}
	should be true     ${result[0]}     ${result}

post/trans/api/v1/group/add/{id}
	[Documentation]    参团
	[Tags]    Run
	${params}    getParam_data    GROUP    post/trans/api/v1/group/add/{id}
	set to dictionary        ${params}       id     ${id}
	${resp}    getApiResp    ${token2}    post    /trans/api/v1/group/add/{id}    ${params}
	${result}    docmentAssert    post    /trans/api/v1/group/add/{id}    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/group/getGroupInfo
	[Documentation]    获取拼团信息
	[Tags]    Run
	${params}    getParam_data    GROUP    get/trans/api/v1/group/getGroupInfo
	set to dictionary        ${params}       id     ${id}
	${resp}    getApiResp    ${token}    get    /trans/api/v1/group/getGroupInfo    ${params}
	set suite variable      ${status}      ${resp['status']}
	${result}    docmentAssert    get    /trans/api/v1/group/getGroupInfo    ${resp}
	should be true     ${result[0]}     ${result}

get/trans/api/v1/group/groupList
	[Documentation]    可以加入团列表
	[Tags]    Run
	${params}    getParam_data    GROUP    get/trans/api/v1/group/groupList
	set to dictionary      ${params}     status    ${status}
	${resp}    getApiResp    ${token}    get    /trans/api/v1/group/groupList    ${params}
	${result}    docmentAssert    get    /trans/api/v1/group/groupList    ${resp}
	should be true     ${result[0]}     ${result}





