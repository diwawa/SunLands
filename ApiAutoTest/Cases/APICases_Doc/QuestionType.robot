*** Settings ***
Force Tags        DocTest    QuestionType
Library           ../../Lib/JsonRead.py
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
post/questionTypes/next
	[Documentation]    题目下一阶段
	[Tags]    Run
	${params}    getParam_data    QuestionType    post/questionTypes/next
	${resp}    getApiResp    ${token}    post    /questionTypes/next    ${params}
	${result}    docmentAssert    post    /questionTypes/next    ${resp}
	should be true     ${result[0]}     ${result}

get/questionTypes/examQuestion
	[Documentation]    题目详情 (8种类型)
	[Tags]    Run
	${params}    getParam_data    QuestionType    get/questionTypes/examQuestion
	${resp}    getApiResp    ${token}    get    /questionTypes/examQuestion    ${params}
	${result}    docmentAssert    get    /questionTypes/examQuestion    ${resp}
	should be true     ${result[0]}     ${result}

get/questionTypes/myQuestionStem/{chapterId}
	[Documentation]    我的收藏列表/我的错题列表
	[Tags]    Run
	${params}    getParam_data    QuestionType    get/questionTypes/myQuestionStem/{chapterId}
	${resp}    getApiResp    ${token}    get    /questionTypes/myQuestionStem/{chapterId}    ${params}
	${result}    docmentAssert    get    /questionTypes/myQuestionStem/{chapterId}    ${resp}
	should be true     ${result[0]}     ${result}

get/questionTypes/examPapers/history
	[Documentation]    套卷模拟历史纪录
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /questionTypes/examPapers/history
	${result}    docmentAssert    get    /questionTypes/examPapers/history    ${resp}
	should be true     ${result[0]}     ${result}

get/questionTypes/chapters
	[Documentation]    章节列表 （章节练习/只做错题/我的收藏/我的错题）
	[Tags]    Run
	${params}    getParam_data    QuestionType    get/questionTypes/chapters
	${resp}    getApiResp    ${token}    get    /questionTypes/chapters    ${params}
	${result}    docmentAssert    get    /questionTypes/chapters    ${resp}
	should be true     ${result[0]}     ${result}

get/questionTypes/examPapers
	[Documentation]    套卷模拟列表
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /questionTypes/examPapers
	${result}    docmentAssert    get    /questionTypes/examPapers    ${resp}
	should be true     ${result[0]}     ${result}

