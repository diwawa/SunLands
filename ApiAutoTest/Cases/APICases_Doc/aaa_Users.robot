*** Settings ***
Force Tags        DocTest    Users
Library           ../../Lib/JsonRead.py
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
get/users/home
	[Documentation]    欢迎页详情
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /users/home
	${result}    docmentAssert    get    /users/home    ${resp}
	should be true     ${result[0]}     ${result}

get/users/share
	[Documentation]    小程序分享
	[Tags]    Run
	${params}    getParam_data    Users    get/users/share
	${resp}    getApiResp    ${token}    get    /users/share    ${params}
	${result}    docmentAssert    get    /users/share    ${resp}
	should be true     ${result[0]}     ${result}

put/users/examTypes
	[Documentation]    修改用户考试类型
	[Tags]    Run
	${params}    getParam_data    Users    put/users/examTypes
	${resp}    getApiResp    ${token}    put    /users/examTypes    ${params}
	${result}    docmentAssert    put    /users/examTypes    ${resp}
	should be true     ${result[0]}     ${result}

put/users/subjects
	[Documentation]    修改用户科目
	[Tags]    Run
	${params}    getParam_data    Users    put/users/subjects
	${resp}    getApiResp    ${token}    put    /users/subjects    ${params}
	${result}    docmentAssert    put    /users/subjects    ${resp}
	should be true     ${result[0]}     ${result}

get/users/me
	[Documentation]    首页我的详情
	[Tags]    Run
	${params}    getParam_data    Users    get/users/me
	${resp}    getApiResp    ${token}    get    /users/me    ${params}
	${result}    docmentAssert    get    /users/me    ${resp}
	should be true     ${result[0]}     ${result}

post/users/advice
	[Documentation]    用户意见反馈
	[Tags]    Run
	${params}    getParam_data    Users    post/users/advice
	${resp}    getApiResp    ${token}    post    /users/advice    ${params}
	${result}    docmentAssert    post    /users/advice    ${resp}
	should be true     ${result[0]}     ${result}

post/users/conllects/{questionId}
	[Documentation]    用户收藏
	[Tags]    Run
	${params}    getParam_data    Users    post/users/conllects/{questionId}
	${resp}    getApiResp    ${token}    post    /users/conllects/{questionId}    ${params}
	${result}    docmentAssert    post    /users/conllects/{questionId}    ${resp}
	should be true     ${result[0]}     ${result}

get/users/me/info
	[Documentation]    我的数据
	[Tags]    Run
	${params}    getParam_data    Users    get/users/me/info
	${resp}    getApiResp    ${token}    get    /users/me/info    ${params}
	${result}    docmentAssert    get    /users/me/info    ${resp}
	should be true     ${result[0]}     ${result}

get/users/push
	[Documentation]    首页推送消息集合
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /users/push
	${result}    docmentAssert    get    /users/push    ${resp}
	should be true     ${result[0]}     ${result}

post/users/signIn
	[Documentation]    用户签到
	[Tags]    Run
	${resp}    getApiResp    ${token}    post    /users/signIn
	${result}    docmentAssert    post    /users/signIn    ${resp}
	should be true     ${result[0]}     ${result}

get/users/support
	[Documentation]    题库数据支持
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /users/support
	${result}    docmentAssert    get    /users/support    ${resp}
	should be true     ${result[0]}     ${result}

get/users/token
	[Documentation]    微信登陆获取尚德token对（公众号不可用）
	[Tags]    NotRun
	${params}    getParam_data    Users    get/users/token
	${resp}    getApiResp    ${token}    get    /users/token    ${params}
	${result}    docmentAssert    get    /users/token    ${resp}
	should be true     ${result[0]}     ${result}

get/users/token/refresh
	[Documentation]    换取新的尚德token对
	[Tags]    NotRun
	${params}    getParam_data    Users    get/users/token/refresh
	${resp}    getApiResp    ${token}    get    /users/token/refresh    ${params}
	${result}    docmentAssert    get    /users/token/refresh    ${resp}
	should be true     ${result[0]}     ${result}

get/users/versions
	[Documentation]    版本提示动态值；参数code通过微信动态获取，暂时获取不到
	[Tags]    NotRun
	${params}    getParam_data    Users    get/users/versions
	${resp}    getApiResp    ${token}    get    /users/versions    ${params}
	${result}    docmentAssert    get    /users/versions    ${resp}
	should be true     ${result[0]}     ${result}

post/users/unchainPaper
	[Documentation]    授权解锁 模拟试卷
	[Tags]    NotRun
	${params}    getParam_data    Users    post/users/unchainPaper
	${resp}    getApiResp    ${token}    post    /users/unchainPaper    ${params}
	${result}    docmentAssert    post    /users/unchainPaper    ${resp}
	should be true     ${result[0]}     ${result}

post/users/survey
	[Documentation]    用户测试数据提交
	[Tags]    NotRun
	${params}    getParam_data    Users    post/users/survey
	${resp}    getApiResp    ${token}    post    /users/survey    ${params}
	${result}    docmentAssert    post    /users/survey    ${resp}
	should be true     ${result[0]}     ${result}

get/users/passRate
	[Documentation]    用户通过率
	[Tags]    Run
	${resp}    getApiResp    ${token}    get    /users/passRate
	${result}    docmentAssert    get    /users/passRate    ${resp}
	should be true     ${result[0]}     ${result}

