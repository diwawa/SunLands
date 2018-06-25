*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Resource          ../../API/Activity.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/Activity.py
Variables         ../../Datas/Response/Activity.py


*** Test Cases ***
ctivity_pointQuestion_home
	[Documentation]    小心心首页
	[Tags]    Run
	${resp}    get/activity/pointQuestion/home    ${token}    ${activity_pointQuestion_home_param['shareMark']}

activity_pointQuestion_final
	[Documentation]    小心心提交点击次数，返回数据
	[Tags]    Run
	${resp}    get/activity/pointQuestion/final    ${token}    30

activity_APM_ranking
	[Documentation]    小心心手速排行榜
	[Tags]    Run
	${resp}    get/activity/APM/ranking    ${token}
