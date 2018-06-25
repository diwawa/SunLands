*** Settings ***
Force Tags        文档测试
Library           ../../Common/Function.py
Resource          ../../API/QuestionType.robot
Resource          ../Resource/Question.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/QuestionType.py
Variables         ../../Datas/Response/QuestionType.py
Resource          ../../API/AnswerPlan.robot
Variables         ../../Datas/Response/AnswerPlan.py
Resource          ../../API/UserAnswer.robot
Variables         ../../Datas/Params/UserAnswer.py
Variables         ../../Datas/Response/UserAnswer.py


*** Test Cases ***
questionTypes_examPapers
	[Documentation]    套卷模拟列表
	[Tags]    Run
	${resp}    get/questionTypes/examPapers    ${token}
	set suite variable      ${examPapersId}    ${resp[0]['examPapersId']}
	${result}    compareResp    ${questionTypes_examPapers_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

questionTypes_examQuestion
	[Documentation]    题目详情 (8种类型)
	[Tags]    Run
	${resp}    get/questionTypes/examQuestion    ${token}    SIMULATION_EXAM    0    0    0    ${examPapersId}
	set suite variable      ${examQuestion}    ${resp}
	${result}    compareResp    ${questionTypes_examQuestion_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${questionTypes_examQuestion_resp['answer']}    ${resp['answer']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${questionTypes_examQuestion_resp['options'][0]}    ${resp['options'][0]}
	Should Be True    ${result['status']}    ${result}

answerPlans
	[Documentation]    个人答题计划生成确认
	[Tags]    Run
	${resp}    get/answerPlans    ${token}
	set suite variable      ${answerPlanId}    ${resp['answerPlanId']}
	${result}    compareResp    ${answerPlans_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

userAnswer
	[Documentation]    判题请求
	[Tags]    Run
	set to dictionary    ${userAnswer_param['userAnswerPostParam']}    userId    ${userId}
	set to dictionary    ${userAnswer_param['userAnswerPostParam']}    examPaperId    ${examPapersId}
	set to dictionary    ${userAnswer_param['userAnswerPostParam']}    answerPlanId    ${answerPlanId}
	set to dictionary    ${userAnswer_param['userAnswerPostParam']}    planType    SIMULATION_EXAM
	${len}    evaluate      len(${examQuestion})
	${questions}    copy list   ${userAnswer_param['userAnswerPostParam']['questions']}
	:FOR    ${x}    IN RANGE    ${len}
	\    set to dictionary      ${questions[${x}]}    questionId    ${examQuestion[${x}]['questionId']}
	\    ${question}    copy dictionary     ${userAnswer_param['userAnswerPostParam']['questions'][0]}
	\    exit for loop if      ${x}==${len-1}
	\    insert into list      ${questions}      ${x+1}    ${question}
	set to dictionary    ${userAnswer_param['userAnswerPostParam']}    questions    ${questions}
	${resp}    post/userAnswer    ${token}    ${userAnswer_param['userAnswerPostParam']}
	set suite variable      ${userAnswerId}    ${resp['userAnswerId']}
	${result}    compareResp    ${userAnswer_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

questionTypes_examPapers_history
	[Documentation]    套卷模拟历史纪录
	[Tags]    Run
	${resp}    get/questionTypes/examPapers/history    ${token}
	${result}    compareResp    ${questionTypes_examPapers_history_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

questionTypes_chapters
	[Documentation]    章节列表 （章节练习/只做错题/我的收藏/我的错题）
	[Tags]    Run
	${resp}    get/questionTypes/chapters    ${token}    MY_WRONG
	set suite variable      ${chapterId}    ${resp['chapters'][0]['chapterId']}
	RE_CHAPTER_PRACTICE     ${chapterId}     # 做题，产生错题
	${result}    compareResp    ${questionTypes_chapters_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${questionTypes_chapters_resp['chapters'][0]}    ${resp['chapters'][0]}
	Should Be True    ${result['status']}    ${result}

questionTypes_myQuestionStem_chapterId
	[Documentation]    我的收藏列表/我的错题列表
	[Tags]    Run
	${resp}    get/questionTypes/myQuestionStem/{chapterId}    ${token}    ${chapterId}    MY_WRONG
    set suite variable      ${questionId}    ${resp[0]['questionId']}
	${result}    compareResp    ${questionTypes_myQuestionStem_chapterId_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}

questionTypes_examQuestion2
	[Documentation]    题目详情 (8种类型)
	[Tags]    Run
	${resp}    get/questionTypes/examQuestion    ${token}    MY_WRONG    1   1    1    ${questionId}
	set suite variable      ${questionids}    ${resp}
	${result}    compareResp    ${questionTypes_examQuestion_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${questionTypes_examQuestion_resp['answer']}    ${resp['answer']}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${questionTypes_examQuestion_resp['options'][0]}    ${resp['options'][0]}
	Should Be True    ${result['status']}    ${result}

questionTypes_next
	[Documentation]    题目下一阶段
	[Tags]    Run
	${resp}    post/questionTypes/next    ${token}    ONLY_WRONG_PRACTICE    ${chapterId}
	should be equal as strings    ${resp}    ${questionTypes_next_resp}

userAnswer_userAnswerId
	[Documentation]    获取判题信息,历史答题记录
	[Tags]    Run
	${resp}    get/userAnswer/{userAnswerId}    ${token}    ${userAnswerId}    ${userAnswer_userAnswerId_param['infoType']}
	${result}    compareResp    ${userAnswer_userAnswerId_resp}    ${resp}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${userAnswer_userAnswerId_resp['levelView'][0]}    ${resp['levelView'][0]}
	Should Be True    ${result['status']}    ${result}
	${result}    compareResp    ${userAnswer_userAnswerId_resp['questions'][0]}    ${resp['questions'][0]}
	Should Be True    ${result['status']}    ${result}





