*** Settings ***
Force Tags        DocTest    Subject
Library           ../../Lib/JsonRead.py
Library           Collections
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
get/subjects
	[Documentation]    根据考试类型id查询科目列表
	[Tags]    Run
	${params}    getParam_data    Subject    get/subjects
	${resp}    getApiResp    ${token}    get    /subjects    ${params}
	${result}    docmentAssert    get    /subjects    ${resp}
	should be true     ${result[0]}     ${result}

get/subjects/courses
	[Documentation]    当前科目下所有公开课列表，按照章节分组
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /subjects/courses
	set suite variable      ${id}      ${resp['courseList'][0]['items'][0]['id']}
	${result}    docmentAssert    get    /subjects/courses    ${resp}
	should be true     ${result[0]}     ${result}

get/subjects/videosInfo
	[Documentation]    根据视频id查询视频详情
	[Tags]    Run
	${params}    getParam_data    Subject    get/subjects/videosInfo
    set to dictionary     ${params}    videosInfoId    ${id}
	${resp}    getApiResp    ${token}    get    /subjects/videosInfo    ${params}
	${result}    docmentAssert    get    /subjects/videosInfo    ${resp}
	should be true     ${result[0]}     ${result}

post/subjects/courses/peopleSum
	[Documentation]    增加公开课观看人数
	[Tags]    Run
	${params}    getParam_data    Subject    post/subjects/courses/peopleSum
	set to dictionary     ${params['courseId']}    courseId    ${id}
	${resp}    getApiResp    ${token}    post    /subjects/courses/peopleSum    ${params['courseId']}
	${result}    docmentAssert    post    /subjects/courses/peopleSum    ${resp}
	should be true     ${result[0]}     ${result}

get/subjects/courses/coinStatus
	[Documentation]    当前可以兑换的状态
	[Tags]    NotRun
	${resp}    getApiResp    ${token}    get    /subjects/courses/coinStatus
	${result}    docmentAssert    get    /subjects/courses/coinStatus    ${resp}
	should be true     ${result[0]}     ${result}

post/subjects/courses/exchange
	[Documentation]    积分兑换课程
	[Tags]    NotRun
	${params}    getParam_data    Subject    post/subjects/courses/exchange
	${resp}    getApiResp    ${token}    post    /subjects/courses/exchange    ${params}
	${result}    docmentAssert    post    /subjects/courses/exchange    ${resp}
	should be true     ${result[0]}     ${result}

