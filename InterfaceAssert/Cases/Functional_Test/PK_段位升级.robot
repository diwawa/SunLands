*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Resource          ../../API/PkArena.robot
Resource          ../Resource/PkArena.robot
Variables          ../Variables/PkArena.py
Variables         ../../Base.py
Variables         ../../Datas/Params/PkArena.py
Variables         ../../Datas/Response/PkArena.py
Resource          ../../API/Users.robot
Variables         ../../Datas/Response/Users.py

*** Keywords ***
PK_WIN
    ${resp_me}    get/pkArena/me    ${token}
    ${resp_pkMatch}    get/pkArena/pkMatch    ${token}    ${EMPTY}    ${False}
    ${pkLogId}    get from dictionary  ${resp_pkMatch}    pkLogId
    ${danGradingName_before}    get from dictionary     ${resp_pkMatch['currentUserView']['danGradingView']}     danGradingName
    ${userId}    get from dictionary      ${resp_pkMatch['targetUserView']}    userId
    ${result}    PK_随机匹配_结果    ${userId}    ${pkLogId}    ${Random_Win['isCorrect_1']}    ${Random_Win['currentUserDuration_1']}
	${resp_pkFinal}    get/pkArena/pkFinal    ${token}    ${pkLogId}
    should be equal as strings    ${resp_pkFinal['currentUserView']['results']}    ${result[0]}
    ${danGradingName_current}    get from dictionary     ${resp_pkFinal['currentUserView']['danGradingView']}     danGradingName
    ${isUpgrade}    set variable if    "${danGradingName_current}"!="${danGradingName_before}"     ${True}    ${False}
    ${resp}    create dictionary      isUpgrade     ${isUpgrade}    pkLogId    ${pkLogId}    danGradingName    ${danGradingName_current}
    [Return]     ${resp}

PK_Lose
    ${resp_me}    get/pkArena/me    ${token}
    ${shareMark}     get from dictionary    ${resp_me}    shareMark
    ${resp_share_shareMark}    get/users/share_shareMark    ${token}    PK    ${shareMark}
    ${resp_join}    post/pkArena/join    ${token2}    ${shareMark}
    ${resp_target}    get/pkArena/target    ${token}
    ${resp_pkMatch}    get/pkArena/pkMatch    ${token2}    ${shareMark}    ${False}
    ${pkLogId}    get from dictionary  ${resp_pkMatch}    pkLogId
    ${danGradingName_before}    get from dictionary     ${resp_pkMatch['currentUserView']['danGradingView']}     danGradingName
    ${result}    PK_答题_结果    ${pkLogId}    ${LOSE['isCorrect_1']}    ${LOSE['isCorrect_2']}    ${LOSE['currentUserDuration_1']}    ${LOSE['currentUserDuration_2']}
	${resp_pkFinal}    get/pkArena/pkFinal    ${token}    ${pkLogId}
    should be equal as strings    ${resp_pkFinal['currentUserView']['results']}    ${result[0]}
    ${danGradingName_current}    get from dictionary     ${resp_pkFinal['targetUserView']['danGradingView']}     danGradingName
    ${isUpgrade}    set variable if    "${danGradingName_current}"!="${danGradingName_before}"     ${True}    ${False}
    ${resp}    create dictionary      isUpgrade     ${isUpgrade}    pkLogId    ${pkLogId}    danGradingName    ${danGradingName_current}
    [Return]     ${resp}



Level_Up
    [Arguments]  ${danGradingName}
    [Documentation]  通过段位升级，增加的成长值
    ${levelnum}    create list    5    10    15    25    35    45    60
    ${Name}    create list      青铜    白银    黄金    铂金    钻石    星耀    王者
    :FOR    ${x}    IN RANGE   7
    \    exit for loop if    "${danGradingName}"=="${Name[${x}]}"
    [Return]  ${levelnum[${x}]}

*** Test Cases ***
Upgrade_me
    :FOR   ${x}    IN RANGE    12
    \    ${data}    PK_WIN
    \    exit for loop if    ${data['isUpgrade']}
    ${resp_up}    GET/pkArena/danGradingTips    ${token}    ${data['pkLogId']}
    ${danGradingName}    get from dictionary      ${data}    danGradingName
    ${level}    Level_Up    ${danGradingName}
    should be equal as strings    ${resp_up['danGradingName']}    ${danGradingName}
    should be equal as integers    ${resp_up['integral']}    ${level}


Upgrade_target
    # 对手段位升级有问题，只有相同科目ok，不同科目时永远不升级
    :FOR   ${x}    IN RANGE    12
    \    ${data}    PK_LOSE
    \    exit for loop if    ${data['isUpgrade']}
    ${resp_up}    GET/pkArena/danGradingTips    ${token2}    ${data['pkLogId']}
    ${danGradingName}    get from dictionary      ${data}    danGradingName
    ${level}    Level_Up    ${danGradingName}
    should be equal as strings    ${resp_up['danGradingName']}    ${danGradingName}
    should be equal as integers    ${resp_up['integral']}    ${level}