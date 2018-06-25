*** Settings ***
Variables         ../../Datas/Response/AnswerPlan.py


*** Keywords ***
answerPlans_resp
	${resp}    evaluate    ${answerPlans_resp}
	Should Be Equal    ${resp['onlyWrongPractice']}    ${sql}
	Should Be Equal    ${resp['randomPractice']}    ${sql}
	Should Be Equal    ${resp['dailyPractice']}    ${sql}
	Should Be Equal    ${resp['answerPlanId']}    ${sql}
	Should Be Equal    ${resp['simulationExam']}    ${sql}
	Should Be Equal    ${resp['highWrongPractice']}    ${sql}
	Should Be Equal    ${resp['chapterPractice']}    ${sql}


