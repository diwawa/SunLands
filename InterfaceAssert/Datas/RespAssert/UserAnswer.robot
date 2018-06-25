*** Settings ***
Variables         ../../Datas/Response/UserAnswer.py


*** Keywords ***
userAnswer_userAnswerId_resp
	${resp}    evaluate    ${userAnswer_userAnswerId_resp}
	Should Be Equal    ${resp['clockIn']}    ${sql}
	Should Be Equal    ${resp['wrongCount']}    ${sql}
	Should Be Equal    ${resp['integralAdd']}    ${sql}
	Should Be Equal    ${resp['level']}    ${sql}
	Should Be Equal    ${resp['userAnswerId']}    ${sql}
	Should Be Equal    ${resp['userId']}    ${sql}
	Should Be Equal    ${resp['examPaperId']}    ${sql}
	Should Be Equal    ${resp['correctRate']}    ${sql}
	Should Be Equal    ${resp['answerPlanId']}    ${sql}
	Should Be Equal    ${resp['planType']}    ${sql}
	Should Be Equal    ${resp['score']}    ${sql}
	Should Be Equal    ${resp['levelView'][0]['currentIntegral']}    ${sql}
	Should Be Equal    ${resp['levelView'][0]['maxIntegral']}    ${sql}
	Should Be Equal    ${resp['levelView'][0]['levelNum']}    ${sql}
	Should Be Equal    ${resp['levelView'][0]['levelName']}    ${sql}
	Should Be Equal    ${resp['questions'][0]['answerDate']}    ${sql}
	Should Be Equal    ${resp['questions'][0]['questionId']}    ${sql}
	Should Be Equal    ${resp['questions'][0]['correctAnswerDesc']}    ${sql}
	Should Be Equal    ${resp['questions'][0]['answerDesc']}    ${sql}
	Should Be Equal    ${resp['questions'][0]['answerCorrect']}    ${sql}
	Should Be Equal    ${resp['questions'][0]['correctAnswer']}    ${sql}
	Should Be Equal    ${resp['questions'][0]['duration']}    ${sql}
	Should Be Equal    ${resp['duration']}    ${sql}
	Should Be Equal    ${resp['wrongRate']}    ${sql}


userAnswer_resp
	${resp}    evaluate    ${userAnswer_resp}
	Should Be Equal    ${resp['userAnswerId']}    ${sql}


