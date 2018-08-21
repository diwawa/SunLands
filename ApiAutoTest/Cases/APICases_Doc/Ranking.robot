*** Settings ***
Force Tags        DocTest    Ranking
Library           ../../Lib/JsonRead.py
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
get/ranking/pkArena
	[Documentation]    排行榜-pk场
	[Tags]    Run
	${params}    getParam_data    Ranking    get/ranking/pkArena
	${resp}    getApiResp    ${token}    get    /ranking/pkArena    ${params}
	${result}    docmentAssert    get    /ranking/pkArena    ${resp}
	should be true     ${result[0]}     ${result}
