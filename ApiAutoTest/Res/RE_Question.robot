*** Settings ***
Library           ../Lib/JsonRead.py
Library           ../Lib/PrivateMethod.py
Library           ../Lib/GetSQL.py
Library           Collections
Resource          Common.robot

*** Keywords ***
re_getQuestions
    [Arguments]  ${examQuestion}    ${method}
    [Documentation]   获取答题用questions、结果（0:随机/正数：正确/负数：错误）
    ${questions}    getParam_data    RE_Question    re_userAnswer
    ${len}    Get Length    ${examQuestion}
    : FOR    ${x}    IN RANGE    ${len}
    \    ${questionId}    get from dictionary      ${examQuestion[${x}]}    questionId
    \    ${questionType}    get from dictionary      ${examQuestion[${x}]}    questionType
    \    ${options}    get from dictionary      ${examQuestion[${x}]}    options
    \    set to dictionary    ${questions[${x}]}    questionId    ${questionId}
    \    ${answers}      getAnswerDesc    ${questionId}    ${questionType}    ${options}    ${method}
    \    set to dictionary    ${questions[${x}]}    answerDesc    ${answers}
    \    ${answerDa}    Evaluate    time.time( )    time
    \    ${answerDate}    Evaluate    int(${answerDa})*1000
    \    set to dictionary    ${questions[${x}]}    answerDate    ${answerDate}
    \     ${num}    evaluate      int(${x})+1
	\     exit for loop if      ${num}==${len}
	\     ${question0}    copy dictionary     ${questions[0]}
	\     insert into list      ${questions}     ${num}    ${question0}
    [Return]  ${questions}

getAnswerDesc
    [Arguments]      ${questionId}    ${questionType}    ${options}    ${method}
    [Documentation]    获取选项：id,题目类型、选项、结果（0:随机/正数：正确/负数：错误）
    ${sql_question}    table exam question      id=${questionId}
    ${correct_answer}     get from dictionary      ${sql_question}    correct_answer
    ${len}    get length   ${options}
    ${correctDesc}    create dictionary
    :For    ${x}    In Range    ${len}
    \    ${option}     get from dictionary      ${options[${x}]}    option
    \    ${correct}    set variable if  "${option}" in "${correct_answer}"    ${True}     ${False}
    \    set to dictionary     ${correctDesc}    ${option}    ${correct}
    log     ${correctDesc}
    ${answerDesc}    getQuestion    ${questionType}    ${correctDesc}    ${method}
    [Return]  ${answerDesc}

