*** Settings ***
Documentation	        App1.0功能自动化测试
Suite Setup	        Setup_suite
Suite Teardown	        Teardown_suite
Test Setup	        Setup_test
Test Teardown	        Teardown_test
Resource	        ../../Business/Business.robot
Resource	        ../../Res/Common.robot


*** Variables ***
@{type2}	        自考    公共课（本）    中国近现代史纲要
@{type1}	        自考    法律（本）    知识产权法
@{answer}	        A    B    C    D    A


*** Test Cases ***
case001
    [Documentation]    首页切换科目类型，切换成功
    [Tags]    NotRun    ExamType
    process001    @{type1}
    process002    @{type1}

case002
    [Documentation]    首页切换科目类型，切换成功
    [Tags]    NotRun    ExamType
    process001    @{type2}
    process002    @{type2}

case003
    [Documentation]    每日一练做题
    [Tags]    Run    Daily
    process003    
    process004    @{answer}
    process005    
    process006    
    process007    

