*** Settings ***
Library      Collections

*** Keywords ***
process007
    [Arguments]    
    [Documentation]    断言 打卡成功
    log    待完成

process006
    [Arguments]    
    [Documentation]    在提交结果页直接打卡
    log    待完成

process005
    [Arguments]    
    [Documentation]    提交答题结果
    log    待完成

process004
    [Arguments]    @{answer}
    [Documentation]    答题， 输入答案为
    log    待完成

process003
    [Arguments]    
    [Documentation]    进入每日一练页面
    log    待完成

process002
    [Arguments]    @{type1}
    [Documentation]    断言 当前科目类型为
    log    待完成

process001
    [Arguments]    @{type1}
    [Documentation]    将科目类型切换为
    log    待完成




