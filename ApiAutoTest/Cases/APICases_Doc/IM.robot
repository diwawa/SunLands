*** Settings ***
Force Tags        DocTest    IM
Library           ../../Lib/JsonRead.py
Resource          ../../Res/Common.robot
Variables         ../../Variables.py


*** Test Cases ***
post/commodity/api/v1/IM/quit
	[Documentation]    聊天室退出（芒果会计小程序）
	[Tags]    Run
	${params}    getParam_data    IM    post/commodity/api/v1/IM/quit
	${resp}    getApiResp    ${token}    post    /commodity/api/v1/IM/quit    ${params}
	${result}    docmentAssert    post    /commodity/api/v1/IM/quit    ${resp}
	should be true     ${result[0]}     ${result}

post/commodity/api/v1/IM/join
	[Documentation]    聊天室加入（芒果会计小程序）
	[Tags]    Run
	${params}    getParam_data    IM    post/commodity/api/v1/IM/join
	${resp}    getApiResp    ${token}    post    /commodity/api/v1/IM/join    ${params}
	${result}    docmentAssert    post    /commodity/api/v1/IM/join    ${resp}
	should be true     ${result[0]}     ${result}

