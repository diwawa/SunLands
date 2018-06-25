*** Settings ***
Variables         ../../Datas/Response/Ranking.py


*** Keywords ***
ranking_pkArena_resp
	${resp}    evaluate    ${ranking_pkArena_resp}
	Should Be Equal    ${resp[0]['userView']['nickName']}    ${sql}
	Should Be Equal    ${resp[0]['userView']['levelNum']}    ${sql}
	Should Be Equal    ${resp[0]['userView']['headImgUrl']}    ${sql}
	Should Be Equal    ${resp[0]['rankingNum']}    ${sql}
	Should Be Equal    ${resp[0]['currentUser']}    ${sql}
	Should Be Equal    ${resp[0]['danGradingView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp[0]['danGradingView']['currentStar']}    ${sql}


ranking_persional_resp
	${resp}    evaluate    ${ranking_persional_resp}
	Should Be Equal    ${resp['userViewList'][0]['nickName']}    ${sql}
	Should Be Equal    ${resp['userViewList'][0]['levelNum']}    ${sql}
	Should Be Equal    ${resp['userViewList'][0]['thisWeekScore']}    ${sql}
	Should Be Equal    ${resp['userViewList'][0]['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['userViewList'][0]['rankNum']}    ${sql}
	Should Be Equal    ${resp['currentUser']['nickName']}    ${sql}
	Should Be Equal    ${resp['currentUser']['levelNum']}    ${sql}
	Should Be Equal    ${resp['currentUser']['thisWeekScore']}    ${sql}
	Should Be Equal    ${resp['currentUser']['headImgUrl']}    ${sql}


ranking_provice_list_resp
	${resp}    evaluate    ${ranking_provice_list_resp}
	Should Be Equal    ${resp[0]['en_name']}    ${sql}
	Should Be Equal    ${resp[0]['zn_name']}    ${sql}


