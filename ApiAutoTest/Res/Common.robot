*** Settings ***
Library       ../Lib/HttpRequest.py
Library       ../Lib/JsonRead.py
Library       ../Lib/AssertResp.py
Library       Collections


*** Keywords ***
getApiResp
    [Arguments]   ${token}    ${mode}    ${path}    ${params}=${EMPTY}
    ${resp}      getResponse     ${token}    ${mode}    ${path}     ${params}
    should be equal as integers      ${resp[0]}    200
    log    ${resp[1]}
    [Return]     ${resp[1]}

docmentAssert
    [Arguments]    ${mode}    ${path}    ${resp}
    ${resp_doc}     getResp_doc     ${mode}    ${path}
    log    ${resp}
    log    ${resp_doc}
    ${result}    assertresp    ${resp}    ${resp_doc}
    [Return]    ${result}

docmentAssert2
    [Arguments]    ${mode}    ${path}    ${resp}     @{off_fields}
    [Documentation]    去除不想要对比的字段
    ${resp_doc}     getResp_doc     ${mode}    ${path}
    remove from dictionary      ${resp}     @{off_fields}
    remove from dictionary     ${resp_doc}     @{off_fields}
    log    ${resp}
    log    ${resp_doc}
    ${result}    assertresp    ${resp}    ${resp_doc}
    [Return]    ${result}

respValueAssert
    [Arguments]    ${filename}    ${casename}    ${resp}
    ${resp_data}     getResp_data    ${filename}    ${casename}

    log    ${resp}
    log    ${resp_data}
    ${result}    assertrespvalue    ${resp}    ${resp_data}
    [Return]    ${result}



