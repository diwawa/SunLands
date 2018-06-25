*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/Ranking.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/Ranking.py
Variables         ../../Datas/Response/Ranking.py


*** Test Cases ***
ranking_pkArena
	[Documentation]    排行榜-pk场
	[Tags]    Run
	${resp}    get/ranking/pkArena    ${token}    ${ranking_pkArena_param['filter']}
	${result}    compareResp    ${ranking_pkArena_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${ranking_pkArena_resp['userView']}    ${resp['userView']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${ranking_pkArena_resp['danGradingView']}    ${resp['danGradingView']}
	Should Be True    ${result['status']}    ${result}

ranking_persional
	[Documentation]    排行榜-个人
	[Tags]    Run
	${resp}    get/ranking/persional    ${token}    ${ranking_persional_param['filter']}
	${result}    compareResp    ${ranking_persional_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${ranking_persional_resp['userViewList'][0]}    ${resp['userViewList'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${ranking_persional_resp['currentUser']}    ${resp['currentUser']}
	Should Be True    ${result['status']}    ${result}

ranking_provice_list
	[Documentation]    排名-省份目录
	[Tags]    Run
	${resp}    get/ranking/provice/list    ${token}
	${result}    compareResp    ${ranking_provice_list_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

