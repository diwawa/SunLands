*** Settings ***
Variables         ../../Datas/Response/Users.py


*** Keywords ***
users_unchainPaper_resp
	${resp}    evaluate    ${users_unchainPaper_resp}
	Should Be Equal    ${resp}    ${sql}


users_home_resp
	${resp}    evaluate    ${users_home_resp}
	Should Be Equal    ${resp['headImageUrl']}    ${sql}
	Should Be Equal     ${resp['icons'][0]}    ${sql}
	Should Be Equal    ${resp['nickName']}    ${sql}
	Should Be Equal    ${resp['totle']}    ${sql}


users_survey_resp
	${resp}    evaluate    ${users_survey_resp}
	Should Be Equal    ${resp['examTypeId']}    ${sql}
	Should Be Equal    ${resp['msg']}    ${sql}
	Should Be Equal    ${resp['primaryCategories']}    ${sql}


users_me_resp
	${resp}    evaluate    ${users_me_resp}
	Should Be Equal    ${resp[0]['examType']}    ${sql}
	Should Be Equal    ${resp[0]['levelNum']}    ${sql}
	Should Be Equal    ${resp[0]['ranking']}    ${sql}
	Should Be Equal    ${resp[0]['userIntegral']}    ${sql}
	Should Be Equal    ${resp[0]['examTimeInfo']['examType']}    ${sql}
	Should Be Equal    ${resp[0]['examTimeInfo']['examDate']}    ${sql}
	Should Be Equal    ${resp[0]['examTimeInfo']['intervalDays']}    ${sql}
	Should Be Equal    ${resp[0]['percent']}    ${sql}
	Should Be Equal    ${resp[0]['headImageUrl']}    ${sql}
	Should Be Equal    ${resp[0]['passRate']}    ${sql}
	Should Be Equal    ${resp[0]['weekAnswerCorrect']}    ${sql}
	Should Be Equal    ${resp[0]['weekAnswerSum']}    ${sql}
	Should Be Equal    ${resp[0]['maxIntegral']}    ${sql}
	Should Be Equal    ${resp[0]['examTypeId']}    ${sql}
	Should Be Equal    ${resp[0]['currentSubject']}    ${sql}
	Should Be Equal    ${resp[0]['nickName']}    ${sql}
	Should Be Equal    ${resp[0]['weekAnswerCorrectRate']}    ${sql}


users_share_resp
	${resp}    evaluate    ${users_share_resp}
	Should Be Equal    ${resp}    ${sql}


users_examTypes_resp
	${resp}    evaluate    ${users_examTypes_resp}
	Should Be Equal    ${resp}    ${sql}


users_me_info_resp
	${resp}    evaluate    ${users_me_info_resp}
	Should Be Equal    ${resp[0]['userScoreRatio']}    ${sql}
	Should Be Equal    ${resp[0]['diligent']}    ${sql}
	Should Be Equal    ${resp[0]['answerDurationRatio']}    ${sql}
	Should Be Equal    ${resp[0]['userAccuracy']}    ${sql}
	Should Be Equal    ${resp[0]['headImageUrl']}    ${sql}
	Should Be Equal    ${resp[0]['answerSum']}    ${sql}
	Should Be Equal    ${resp[0]['examTypeId']}    ${sql}
	Should Be Equal    ${resp[0]['answerRation']}    ${sql}
	Should Be Equal    ${resp[0]['nickName']}    ${sql}
	Should Be Equal    ${resp[0]['accuracy']}    ${sql}


users_advice_resp
	${resp}    evaluate    ${users_advice_resp}
	Should Be Equal    ${resp}    ${sql}


users_conllects_questionId_resp
	${resp}    evaluate    ${users_conllects_questionId_resp}
	Should Be Equal    ${resp}    ${sql}


users_token_refresh_resp
	${resp}    evaluate    ${users_token_refresh_resp}
	Should Be Equal    ${resp['token']}    ${sql}
	Should Be Equal    ${resp['refreshToken']}    ${sql}
	Should Be Equal    ${resp['isFirst']}    ${sql}


users_token_resp
	${resp}    evaluate    ${users_token_resp}
	Should Be Equal    ${resp['token']}    ${sql}
	Should Be Equal    ${resp['refreshToken']}    ${sql}
	Should Be Equal    ${resp['isFirst']}    ${sql}
	Should Be Equal    ${resp['needAuth']}    ${sql}
	Should Be Equal    ${resp['showTip']}    ${sql}


users_examPapers_resp
	${resp}    evaluate    ${users_examPapers_resp}
	Should Be Equal    ${resp[0]['totle']}    ${sql}
	Should Be Equal    ${resp[0]['finish']}    ${sql}
	Should Be Equal    ${resp[0]['people']}    ${sql}
	Should Be Equal    ${resp[0]['examPapersId']}    ${sql}
	Should Be Equal    ${resp[0]['current']}    ${sql}
	Should Be Equal    ${resp[0]['examPaperName']}    ${sql}


users_subjects_resp
	${resp}    evaluate    ${users_subjects_resp}
	Should Be Equal    ${resp}    ${sql}


users_push_resp
	${resp}    evaluate    ${users_push_resp}
	Should Be Equal    ${resp[0]['nickName']}    ${sql}
	Should Be Equal    ${resp[0]['headImageUrl']}    ${sql}
	Should Be Equal    ${resp[0]['examPaperName']}    ${sql}


users_posters_resp
	${resp}    evaluate    ${users_posters_resp}
	Should Be Equal    ${resp['RARE'][0]['postersName']}    ${sql}
	Should Be Equal    ${resp['RARE'][0]['postersUrl']}    ${sql}
	Should Be Equal    ${resp['RARE'][0]['clockInlist'][0]['clockInDate']}    ${sql}
	Should Be Equal    ${resp['RARE'][0]['clockInlist'][0]['clockInSum']}    ${sql}
	Should Be Equal    ${resp['LEGEND'][0]['postersName']}    ${sql}
	Should Be Equal    ${resp['LEGEND'][0]['postersUrl']}    ${sql}
	Should Be Equal    ${resp['LEGEND'][0]['clockInlist'][0]['clockInDate']}    ${sql}
	Should Be Equal    ${resp['LEGEND'][0]['clockInlist'][0]['clockInSum']}    ${sql}
	Should Be Equal    ${resp['UNCOMMON'][0]['postersName']}    ${sql}
	Should Be Equal    ${resp['UNCOMMON'][0]['postersUrl']}    ${sql}
	Should Be Equal    ${resp['UNCOMMON'][0]['clockInlist'][0]['clockInDate']}    ${sql}
	Should Be Equal    ${resp['UNCOMMON'][0]['clockInlist'][0]['clockInSum']}    ${sql}
	Should Be Equal    ${resp['GENERAL'][0]['postersName']}    ${sql}
	Should Be Equal    ${resp['GENERAL'][0]['postersUrl']}    ${sql}
	Should Be Equal    ${resp['GENERAL'][0]['clockInlist'][0]['clockInDate']}    ${sql}
	Should Be Equal    ${resp['GENERAL'][0]['clockInlist'][0]['clockInSum']}    ${sql}


users_support_resp
	${resp}    evaluate    ${users_support_resp}
	Should Be Equal    ${resp[0]['worldCupStatus']}    ${sql}
	Should Be Equal    ${resp[0]['reciteShow']}    ${sql}
	Should Be Equal    ${resp[0]['activityInfo']['status']}    ${sql}
	Should Be Equal    ${resp[0]['activityInfo']['remainingTime']}    ${sql}
	Should Be Equal    ${resp[0]['activityInfo']['linkUrl']}    ${sql}
	Should Be Equal    ${resp[0]['activityInfo']['icon']}    ${sql}
	Should Be Equal    ${resp[0]['errorSum']}    ${sql}
	Should Be Equal    ${resp[0]['Unchain']}    ${sql}


