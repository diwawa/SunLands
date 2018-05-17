*** Settings ***
Variables         ../Variables/Base.py
Library           DatabaseLibrary
Library           OperatingSystem
Library           Collections
Library           ../Library/Report.py

*** Keywords ***
SuiteSetup
    [Documentation]    连接数据库
    Connect To Database    pymysql    ${dbName}    ${dbUsername}    ${dbPassword}    ${dbHost}    ${dbPort}
    ...    ${dbCharset}
    sleep    2s
    Log    Mysql connect

SuiteTeardown
    Disconnect From Database
    Log    Mysql disconnect
    Create excel report    ${SUITE METADATA["name"]}    %{G_TOTAL_RESULT}

TestTeardown
    Set Environment variable    G_TOTAL_RESULT    total_result.txt
    ${rc}    Run Keyword And Ignore Error    File Should Exist    %{G_TOTAL_RESULT}
    Run keyword If    '${rc[0]}'=='FAIL'    Create File    %{G_TOTAL_RESULT}    ${SUITE NAME}::${TEST_NAME}::@{TEST TAGS}::${TEST_STATUS}::${TEST MESSAGE}|
    ...    ELSE IF    '${rc[0]}'=='PASS'    Append To File    %{G_TOTAL_RESULT}    ${SUITE NAME}::${TEST_NAME}::@{TEST TAGS}::${TEST_STATUS}::${TEST MESSAGE}|
