*** Settings ***
Suite Setup       SuiteSetup
Suite Teardown    SuiteTeardown
Test Teardown     TestTeardown
Metadata          name    Key_Activity
Resource          ../../Common/Resource/ComTest.robot
Library           ../../Common/Library/Function.py
Resource          ../../API/Activity.robot
Variables         ../../AssertJson/Activity.py

*** Test Cases ***
activity
    ${data}    Activity.GET/activity
    ${jsonkeys}    Compare Jsonkeys    ${activity}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${activity}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}

push
    ${data}    Activity.GET/activity/push
    ${jsonkeys}    Compare Jsonkeys    ${push}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${push}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}

join
    ${data}    Activity.POST/activity/join
    ${jsonkeys}    Compare Jsonkeys    ${join}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${join}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}

details
    ${data}    Activity.GET/activity/details    ${EMPTY}
    ${jsonkeys}    Compare Jsonkeys    ${details}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${details}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_userList}    Compare Jsonkeys    ${details["userList"]}    ${data["userList"]}
    Should Be True    ${jsonkeys_userList['assertStatus']}    ${jsonkeys_userList}
    ${jsonvalues_userList}    Compare Jsonvalues Tpye    ${details["userList"]}    ${data["userList"]}
    Should Be True    ${jsonvalues_userList['assertStatus']}    ${jsonvalues_userList}

goods
    ${data}    Activity.GET/activity/goods    ${EMPTY}
    ${jsonkeys}    Compare Jsonkeys    ${goods}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${goods}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_goodsList}    Compare Jsonkeys    ${goods["goodsList"]}    ${data["goodsList"]}
    Should Be True    ${jsonkeys_goodsList['assertStatus']}    ${jsonkeys_goodsList}
    ${jsonvalues_goodsList}    Compare Jsonvalues Tpye    ${goods["goodsList"]}    ${data["goodsList"]}
    Should Be True    ${jsonvalues_goodsList['assertStatus']}    ${jsonvalues_goodsList}

draw_details
    ${data}    Activity.GET/activity/draw/details
    ${jsonkeys}    Compare Jsonkeys    ${draw_details}    ${data}
    Should be true    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    compareJsonvaluesTpye    ${draw_details}    ${data}
    Should be true    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_goodsList}    Compare Jsonkeys    ${draw_details["goodsList"]}    ${data["goodsList"]}
    Should be true    ${jsonkeys_goodsList['assertStatus']}    ${jsonkeys_goodsList}
    ${jsonvalues_goodsList}    compareJsonvaluesTpye    ${draw_details["goodsList"]}    ${data["goodsList"]}
    Should be true    ${jsonvalues_goodsList['assertStatus']}    ${jsonvalues_goodsList}
    ${jsonkeys_helpList}    Compare Jsonkeys    ${draw_details["helpList"]}    ${data["helpList"]}
    Should be true    ${jsonkeys_helpList['assertStatus']}    ${jsonkeys_helpList}
    ${jsonvalues_helpList}    compareJsonvaluesTpye    ${draw_details["helpList"]}    ${data["helpList"]}
    Should be true    ${jsonvalues_helpList['assertStatus']}    ${jsonvalues_helpList}
    ${jsonkeys_wxInfo}    Compare Jsonkeys    ${draw_details["wxInfo"]}    ${data["wxInfo"]}
    Should be true    ${jsonkeys_wxInfo['assertStatus']}    ${jsonkeys_wxInfo}
    ${jsonvalues_wxInfo}    compareJsonvaluesTpye    ${draw_details["wxInfo"]}    ${data["wxInfo"]}
    Should be true    ${jsonvalues_wxInfo['assertStatus']}    ${jsonvalues_wxInfo}
    ${jsonkeys_drawInfo}    Compare Jsonkeys    ${draw_details["drawInfo"]}    ${data["drawInfo"]}
    Should be true    ${jsonkeys_drawInfo['assertStatus']}    ${jsonkeys_wxInfo}
    ${jsonvalues_drawInfo}    compareJsonvaluesTpye    ${draw_details["drawInfo"]}    ${data["drawInfo"]}
    Should be true    ${jsonvalues_drawInfo['assertStatus']}    ${jsonvalues_wxInfo}

draw_shareUser
    ${list}    Query    SELECT share_mark FROM exam_share,`user` WHERE `user`.del_flag = 0 AND `user`.id = exam_share.user_id
    ${data}    Activity.GET/activity/draw/shareUser    ${list[0][0]}
    ${jsonkeys}    Compare Jsonkeys    ${draw_shareUser}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${draw_shareUser}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_helpList}    Compare Jsonkeys    ${draw_shareUser["helpList"]}    ${data["helpList"]}
    Should Be True    ${jsonkeys_helpList['assertStatus']}    ${jsonkeys_helpList}
    ${jsonvalues_helpList}    Compare Jsonvalues Tpye    ${draw_shareUser["helpList"]}    ${data["helpList"]}
    Should Be True    ${jsonvalues_helpList['assertStatus']}    ${jsonvalues_helpList}

draw_help
    ${list}    Query    SELECT share_mark FROM exam_share,`user` WHERE `user`.del_flag = 0 AND `user`.id = exam_share.user_id
    ${data}    Activity.POST/activity/draw/help    ${list[0][0]}
    ${jsonkeys}    Compare Jsonkeys    ${draw_help}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${draw_help}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}

valentines_form
    ${data}    Activity.GET/activity/valentines/form
    ${jsonkeys}    Compare Jsonkeys    ${valentines_form}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${valentines_form}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_successInfos}    Compare Jsonkeys    ${valentines_form["successInfos"]}    ${data["successInfos"]}
    Should Be True    ${jsonkeys_successInfos['assertStatus']}    ${jsonkeys_successInfos}
    ${jsonvalues_successInfos}    Compare Jsonvalues Tpye    ${valentines_form["successInfos"]}    ${data["successInfos"]}
    Should Be True    ${jsonvalues_successInfos['assertStatus']}    ${jsonvalues_successInfos}
    ${jsonkeys_successInfos_userInfo}    Compare Jsonkeys    ${valentines_form["successInfos"]["userInfo"]}    ${data["successInfos"]["userInfo"]}
    Should Be True    ${jsonkeys_successInfos_userInfo['assertStatus']}    ${jsonkeys_successInfos_userInfo}
    ${jsonvalues_successInfos_userInfo}    Compare Jsonvalues Tpye    ${valentines_form["successInfos"]["userInfo"]}    ${data["successInfos"]["userInfo"]}
    Should Be True    ${jsonvalues_successInfos_userInfo['assertStatus']}    ${jsonvalues_successInfos_userInfo}
    ${jsonkeys_successInfos_otherUserInfo}    Compare Jsonkeys    ${valentines_form["successInfos"]["otherUserInfo"]}    ${data["successInfos"]["otherUserInfo"]}
    Should Be True    ${jsonkeys_successInfos_otherUserInfo['assertStatus']}    ${jsonkeys_successInfos_otherUserInfo}
    ${jsonvalues_successInfos_otherUserInfo}    Compare Jsonvalues Tpye    ${valentines_form["successInfos"]["otherUserInfo"]}    ${data["successInfos"]["otherUserInfo"]}
    Should Be True    ${jsonvalues_successInfos_otherUserInfo['assertStatus']}    ${jsonvalues_successInfos_otherUserInfo}

valentines_details接口访问提示参数为空
    ${data}    Activity.GET/activity/valentines/details
    ${jsonkeys}    Compare Jsonkeys    ${valentines_details}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${valentines_details}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_userInfo}    Compare Jsonkeys    ${valentines_details["userInfo"]}    ${data["userInfo"]}
    Should Be True    ${jsonkeys_userInfo['assertStatus']}    ${jsonkeys_userInfo}
    ${jsonvalues_userInfo}    Compare Jsonvalues Tpye    ${valentines_details["userInfo"]}    ${data["userInfo"]}
    Should Be True    ${jsonvalues_userInfo['assertStatus']}    ${jsonvalues_userInfo}
    ${jsonkeys_otherUserInfo}    Compare Jsonkeys    ${valentines_details["otherUserInfo"]}    ${data["otherUserInfo"]}
    Should Be True    ${jsonkeys_otherUserInfo['assertStatus']}    ${jsonkeys_otherUserInfo}
    ${jsonvalues_otherUserInfo}    Compare Jsonvalues Tpye    ${valentines_details["otherUserInfo"]}    ${data["otherUserInfo"]}
    Should Be True    ${jsonvalues_otherUserInfo['assertStatus']}    ${jsonvalues_otherUserInfo}

valentines_ranking提示参数为空
    ${data}    Activity.GET/activity/valentines/ranking
    ${jsonkeys}    Compare Jsonkeys    ${valentines_ranking}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${valentines_ranking}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_userInfo}    Compare Jsonkeys    ${valentines_ranking["userInfo"]}    ${data["userInfo"]}
    Should Be True    ${jsonkeys_userInfo['assertStatus']}    ${jsonkeys_userInfo}
    ${jsonvalues_userInfo}    Compare Jsonvalues Tpye    ${valentines_ranking["userInfo"]}    ${data["userInfo"]}
    Should Be True    ${jsonvalues_userInfo['assertStatus']}    ${jsonvalues_userInfo}
    ${jsonkeys_otherUserInfo}    Compare Jsonkeys    ${valentines_ranking["otherUserInfo"]}    ${data["otherUserInfo"]}
    Should Be True    ${jsonkeys_otherUserInfo['assertStatus']}    ${jsonkeys_otherUserInfo}
    ${jsonvalues_otherUserInfo}    Compare Jsonvalues Tpye    ${valentines_ranking["otherUserInfo"]}    ${data["otherUserInfo"]}
    Should Be True    ${jsonvalues_otherUserInfo['assertStatus']}    ${jsonvalues_otherUserInfo}

APM_ranking
    ${data}    Activity.GET/activity/APM/ranking
    ${jsonkeys}    Compare Jsonkeys    ${APM_ranking}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${APM_ranking}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_userInfo}    Compare Jsonkeys    ${APM_ranking["userInfo"]}    ${data["userInfo"]}
    Should Be True    ${jsonkeys_userInfo['assertStatus']}    ${jsonkeys_userInfo}
    ${jsonvalues_userInfo}    Compare Jsonvalues Tpye    ${APM_ranking["userInfo"]}    ${data["userInfo"]}
    Should Be True    ${jsonvalues_userInfo['assertStatus']}    ${jsonvalues_userInfo}
    ${jsonkeys_meInfo}    Compare Jsonkeys    ${APM_ranking["meInfo"]}    ${data["meInfo"]}
    Should Be True    ${jsonkeys_meInfo['assertStatus']}    ${jsonkeys_meInfo}
    ${jsonvalues_meInfo}    Compare Jsonvalues Tpye    ${APM_ranking["meInfo"]}    ${data["meInfo"]}
    Should Be True    ${jsonvalues_meInfo['assertStatus']}    ${jsonvalues_meInfo}

pointQuestion_final
    ${data}    Activity.GET/activity/pointQuestion/final    65
    ${jsonkeys}    Compare Jsonkeys    ${pointQuestion_final}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${pointQuestion_final}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}

pointQuestion_home
    ${data}    Activity.GET/activity/pointQuestion/home    ${EMPTY}
    ${jsonkeys}    Compare Jsonkeys    ${pointQuestion_home}    ${data}
    Should Be True    ${jsonkeys['assertStatus']}    ${jsonkeys}
    ${jsonvalues}    Compare Jsonvalues Tpye    ${pointQuestion_home}    ${data}
    Should Be True    ${jsonvalues['assertStatus']}    ${jsonvalues}
    ${jsonkeys_usersHeadImageUrl}    Compare Jsonkeys    ${pointQuestion_home["usersHeadImageUrl"]}    ${data["usersHeadImageUrl"]}
    Should Be True    ${jsonkeys_usersHeadImageUrl['assertStatus']}    ${jsonkeys_usersHeadImageUrl}
    ${jsonvalues_usersHeadImageUrl}    Compare Jsonvalues Tpye    ${pointQuestion_home["usersHeadImageUrl"]}    ${data["usersHeadImageUrl"]}
    Should Be True    ${jsonvalues_usersHeadImageUrl['assertStatus']}    ${jsonvalues_usersHeadImageUrl}
