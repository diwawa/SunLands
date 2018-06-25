*** Settings ***
Variables         ../../Datas/Response/PkArena.py


*** Keywords ***
pkArena_pkFinal_share_resp
	${resp}    evaluate    ${pkArena_pkFinal_share_resp}
	Should Be Equal    ${resp['currentUserView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['nickName']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['levelNum']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['startNum']}    ${sql}
	Should Be Equal    ${resp['shareUserView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['shareUserView']['levelNum']}    ${sql}
	Should Be Equal    ${resp['shareUserView']['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['shareUserView']['startNum']}    ${sql}
	Should Be Equal    ${resp['shareUserView']['scoreSum']}    ${sql}
	Should Be Equal    ${resp['shareUserView']['nickName']}    ${sql}


pkArena_target_resp
	${resp}    evaluate    ${pkArena_target_resp}
	Should Be Equal    ${resp['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['levelNum']}    ${sql}
	Should Be Equal    ${resp['userId']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['currentStar']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['winRate']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['winSum']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['pkSum']}    ${sql}
	Should Be Equal    ${resp['nickName']}    ${sql}


pkArena_pkDynamicImg_userId_pkLogId_resp
	${resp}    evaluate    ${pkArena_pkDynamicImg_userId_pkLogId_resp}
	Should Be Equal    ${resp}    ${sql}


pkArena_targetAnswerDetail_resp
	${resp}    evaluate    ${pkArena_targetAnswerDetail_resp}
	Should Be Equal    ${resp['targetUserAnswer']}    ${sql}
	Should Be Equal    ${resp['targetUserScore']}    ${sql}
	Should Be Equal    ${resp['targetUserDuration']}    ${sql}
	Should Be Equal    ${resp['correctAnswer']}    ${sql}
	Should Be Equal    ${resp['targetUserScoreSum']}    ${sql}


pkArena_pkAnswer_resp
	${resp}    evaluate    ${pkArena_pkAnswer_resp}
	Should Be Equal    ${resp['currentUserScore']}    ${sql}
	Should Be Equal    ${resp['targetUserAnswer']}    ${sql}
	Should Be Equal    ${resp['currentUserScoreSum']}    ${sql}
	Should Be Equal    ${resp['correctAnswer']}    ${sql}


pkArena_quit_resp
	${resp}    evaluate    ${pkArena_quit_resp}
	Should Be Equal    ${resp['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['levelNum']}    ${sql}
	Should Be Equal    ${resp['userId']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['currentStar']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['winRate']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['winSum']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['pkSum']}    ${sql}
	Should Be Equal    ${resp['nickName']}    ${sql}


pkArena_join_resp
	${resp}    evaluate    ${pkArena_join_resp}
	Should Be Equal    ${resp['status']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['levelNum']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['sharePkLogScore']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['danGradingView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['danGradingView']['currentStar']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['userId']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['nickName']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['levelNum']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['userId']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['currentStar']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['nickName']}    ${sql}
	Should Be Equal    ${resp['isMe']}    ${sql}


pkArena_pkFinal_resp
	${resp}    evaluate    ${pkArena_pkFinal_resp}
	Should Be Equal     ${resp['winRinkingInfo']['headImgUrls'][0]}    ${sql}
	Should Be Equal    ${resp['winRinkingInfo']['surpass']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['levelNum']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['danGradingView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['danGradingView']['currentStar']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['userId']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['userScoreSum']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['nickName']}    ${sql}
	Should Be Equal    ${resp['userId']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['levelNum']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['currentStar']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['beforeStar']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['userId']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['userScoreSum']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['results']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['nickName']}    ${sql}
	Should Be Equal    ${resp['pkLogId']}    ${sql}


pkArena_danGradingTips_resp
	${resp}    evaluate    ${pkArena_danGradingTips_resp}
	Should Be Equal    ${resp['danGradingName']}    ${sql}
	Should Be Equal    ${resp['integral']}    ${sql}


pkArena_me_resp
	${resp}    evaluate    ${pkArena_me_resp}
	Should Be Equal    ${resp['levelNum']}    ${sql}
	Should Be Equal    ${resp['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['currentStar']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['winRate']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['winSum']}    ${sql}
	Should Be Equal    ${resp['danGradingView']['pkSum']}    ${sql}
	Should Be Equal    ${resp['userId']}    ${sql}
	Should Be Equal    ${resp['shareMark']}    ${sql}
	Should Be Equal    ${resp['nickName']}    ${sql}


pkArena_pkMatch_resp
	${resp}    evaluate    ${pkArena_pkMatch_resp}
	Should Be Equal    ${resp['targetUserView']['levelNum']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['sharePkLogScore']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['danGradingView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['danGradingView']['currentStar']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['userId']}    ${sql}
	Should Be Equal    ${resp['targetUserView']['nickName']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['levelNum']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['userId']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['danGradingName']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['danGradingView']['currentStar']}    ${sql}
	Should Be Equal    ${resp['currentUserView']['nickName']}    ${sql}
	Should Be Equal    ${resp['pkLogId']}    ${sql}


pkArena_pkQuestions_resp
	${resp}    evaluate    ${pkArena_pkQuestions_resp}
	Should Be Equal    ${resp['questionType']}    ${sql}
	Should Be Equal    ${resp['questionId']}    ${sql}
	Should Be Equal    ${resp['currentUserScoreSum']}    ${sql}
	Should Be Equal    ${resp['targetUserScore']}    ${sql}
	Should Be Equal    ${resp['targetUserDuration']}    ${sql}
	Should Be Equal    ${resp['targetUserScoreSum']}    ${sql}
	Should Be Equal    ${resp['questionDesc']}    ${sql}
	Should Be Equal    ${resp['options'][0]['option']}    ${sql}
	Should Be Equal    ${resp['options'][0]['optionDesc']}    ${sql}
	Should Be Equal    ${resp['questionSum']}    ${sql}
	Should Be Equal    ${resp['questionCurrentNum']}    ${sql}


