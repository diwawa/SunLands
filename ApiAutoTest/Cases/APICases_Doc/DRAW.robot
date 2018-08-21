*** Settings ***
Force Tags        DocTest    DRAW
Library           ../../Lib/JsonRead.py
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
get/draw/assist/share/{userId}/{videosInfoId}
	[Documentation]    获取用户活动详情
	[Tags]    NotRun
	${params}    getParam_data    DRAW    get/draw/assist/share/{userId}/{videosInfoId}
	${resp}    getApiResp    ${token}    get    /draw/assist/share/{userId}/{videosInfoId}    ${params}
	${result}    docmentAssert    get    /draw/assist/share/{userId}/{videosInfoId}    ${resp}
	should be true     ${result[0]}     ${result}

