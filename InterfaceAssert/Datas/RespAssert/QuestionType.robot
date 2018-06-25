*** Settings ***
Variables         ../../Datas/Response/QuestionType.py


*** Keywords ***
questionTypes_next_resp
	${resp}    evaluate    ${questionTypes_next_resp}
	Should Be Equal    ${resp}    ${sql}


questionTypes_examQuestion_resp
	${resp}    evaluate    ${questionTypes_examQuestion_resp}
	Should Be Equal    ${resp[0]['questionType']}    ${sql}
	Should Be Equal    ${resp[0]['questionId']}    ${sql}
	Should Be Equal    ${resp[0]['questionDesc']}    ${sql}
	Should Be Equal    ${resp[0]['number']}    ${sql}
	Should Be Equal    ${resp[0]['collect']}    ${sql}
	Should Be Equal    ${resp[0]['answer']['correctAnswerDesc']}    ${sql}
	Should Be Equal    ${resp[0]['answer']['errorFatherRate']}    ${sql}
	Should Be Equal    ${resp[0]['answer']['newestCorrect']}    ${sql}
	Should Be Equal    ${resp[0]['answer']['errorNum']}    ${sql}
	Should Be Equal    ${resp[0]['answer']['errorRate']}    ${sql}
	Should Be Equal    ${resp[0]['answer']['errorPeople']}    ${sql}
	Should Be Equal    ${resp[0]['answer']['correctAnswer']}    ${sql}
	Should Be Equal    ${resp[0]['options'][0]['selected']}    ${sql}
	Should Be Equal    ${resp[0]['options'][0]['stutus']}    ${sql}
	Should Be Equal    ${resp[0]['options'][0]['option']}    ${sql}
	Should Be Equal    ${resp[0]['options'][0]['optionDesc']}    ${sql}


questionTypes_examPapers_history_resp
	${resp}    evaluate    ${questionTypes_examPapers_history_resp}
	Should Be Equal    ${resp[0]['finishTime']}    ${sql}
	Should Be Equal    ${resp[0]['userAnswerId']}    ${sql}
	Should Be Equal    ${resp[0]['examPapersId']}    ${sql}
	Should Be Equal    ${resp[0]['score']}    ${sql}
	Should Be Equal    ${resp[0]['unfinishedNum']}    ${sql}
	Should Be Equal    ${resp[0]['date']}    ${sql}
	Should Be Equal    ${resp[0]['examPaperName']}    ${sql}


questionTypes_myQuestionStem_chapterId_resp
	${resp}    evaluate    ${questionTypes_myQuestionStem_chapterId_resp}
	Should Be Equal    ${resp[0]['date']}    ${sql}
	Should Be Equal    ${resp[0]['questionId']}    ${sql}
	Should Be Equal    ${resp[0]['errorNum']}    ${sql}
	Should Be Equal    ${resp[0]['questionDesc']}    ${sql}
	Should Be Equal    ${resp[0]['collectNum']}    ${sql}


questionTypes_chapters_resp
	${resp}    evaluate    ${questionTypes_chapters_resp}
	Should Be Equal    ${resp['errorSum']}    ${sql}
	Should Be Equal    ${resp['chapters'][0]['totle']}    ${sql}
	Should Be Equal    ${resp['chapters'][0]['people']}    ${sql}
	Should Be Equal    ${resp['chapters'][0]['current']}    ${sql}
	Should Be Equal    ${resp['chapters'][0]['errorNum']}    ${sql}
	Should Be Equal    ${resp['chapters'][0]['collectNum']}    ${sql}
	Should Be Equal    ${resp['chapters'][0]['chapterId']}    ${sql}
	Should Be Equal    ${resp['chapters'][0]['chapterName']}    ${sql}


questionTypes_examPapers_resp
	${resp}    evaluate    ${questionTypes_examPapers_resp}
	Should Be Equal    ${resp[0]['totle']}    ${sql}
	Should Be Equal    ${resp[0]['finish']}    ${sql}
	Should Be Equal    ${resp[0]['people']}    ${sql}
	Should Be Equal    ${resp[0]['examPapersId']}    ${sql}
	Should Be Equal    ${resp[0]['current']}    ${sql}
	Should Be Equal    ${resp[0]['examPaperName']}    ${sql}


