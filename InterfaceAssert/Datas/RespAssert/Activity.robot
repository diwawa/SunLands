*** Settings ***
Variables         ../../Datas/Response/Activity.py


*** Keywords ***
activity_worldCup_invite_resp
	${resp}    evaluate    ${activity_worldCup_invite_resp}
	Should Be Equal    ${resp['success']}    ${sql}


activity_resp
	${resp}    evaluate    ${activity_resp}
	Should Be Equal    ${resp[0]['status']}    ${sql}
	Should Be Equal    ${resp[0]['activityName']}    ${sql}
	Should Be Equal    ${resp[0]['people']}    ${sql}
	Should Be Equal    ${resp[0]['activityType']}    ${sql}
	Should Be Equal    ${resp[0]['activityUrl']}    ${sql}
	Should Be Equal    ${resp[0]['lastDay']}    ${sql}
	Should Be Equal    ${resp[0]['activityImgUrl']}    ${sql}


activity_draw_details_resp
	${resp}    evaluate    ${activity_draw_details_resp}
	Should Be Equal    ${resp['helpList'][0]['nicName']}    ${sql}
	Should Be Equal    ${resp['helpList'][0]['headImageUrl']}    ${sql}
	Should Be Equal    ${resp['goodsList'][0]['url']}    ${sql}
	Should Be Equal    ${resp['goodsList'][0]['name']}    ${sql}
	Should Be Equal    ${resp['wxInfo']['wxName']}    ${sql}
	Should Be Equal    ${resp['wxInfo']['wxCodeUrl']}    ${sql}
	Should Be Equal    ${resp['needPeple']}    ${sql}
	Should Be Equal    ${resp['phoneNumberDone']}    ${sql}
	Should Be Equal    ${resp['schedule']}    ${sql}
	Should Be Equal    ${resp['drawInfo']['headerDesc']}    ${sql}
	Should Be Equal    ${resp['drawInfo']['footDesc']}    ${sql}
	Should Be Equal    ${resp['drawInfo']['drawType']}    ${sql}
	Should Be Equal    ${resp['drawInfo']['bodyDesc']}    ${sql}
	Should Be Equal    ${resp['phoneAuth']}    ${sql}


activity_valentines_details_resp
	${resp}    evaluate    ${activity_valentines_details_resp}
	Should Be Equal    ${resp['otherUserInfo']['examTypeNameSon']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['headImageUrl']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['correctRate']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['examTypeNameParent']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['nickName']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['answerNum']}    ${sql}
	Should Be Equal    ${resp['rankingNum']}    ${sql}
	Should Be Equal    ${resp['carryPrize']}    ${sql}
	Should Be Equal    ${resp['userInfo']['examTypeNameSon']}    ${sql}
	Should Be Equal    ${resp['userInfo']['headImageUrl']}    ${sql}
	Should Be Equal    ${resp['userInfo']['correctRate']}    ${sql}
	Should Be Equal    ${resp['userInfo']['examTypeNameParent']}    ${sql}
	Should Be Equal    ${resp['userInfo']['nickName']}    ${sql}
	Should Be Equal    ${resp['userInfo']['answerNum']}    ${sql}


activity_worldCup_peopleSum_resp
	${resp}    evaluate    ${activity_worldCup_peopleSum_resp}
	Should Be Equal    ${resp['peopleSum']}    ${sql}


activity_pointQuestion_final_resp
	${resp}    evaluate    ${activity_pointQuestion_final_resp}
	Should Be Equal    ${resp['pointSum']}    ${sql}
	Should Be Equal    ${resp['question']}    ${sql}
	Should Be Equal    ${resp['title']}    ${sql}


activity_draw_help_resp
	${resp}    evaluate    ${activity_draw_help_resp}
	Should Be Equal    ${resp['done']}    ${sql}


activity_worldCup_share_resp
	${resp}    evaluate    ${activity_worldCup_share_resp}
	Should Be Equal    ${resp['status']}    ${sql}


activity_worldCup_cancelMatch_resp
	${resp}    evaluate    ${activity_worldCup_cancelMatch_resp}
	Should Be Equal    ${resp['result']}    ${sql}


activity_details_resp
	${resp}    evaluate    ${activity_details_resp}
	Should Be Equal    ${resp['userList'][0]['headImageUrl']}    ${sql}
	Should Be Equal    ${resp['userList'][0]['name']}    ${sql}
	Should Be Equal    ${resp['aName']}    ${sql}
	Should Be Equal    ${resp['people']}    ${sql}


activity_valentines_ranking_resp
	${resp}    evaluate    ${activity_valentines_ranking_resp}
	Should Be Equal    ${resp[0]['clockInDay']}    ${sql}
	Should Be Equal    ${resp[0]['rankingNum']}    ${sql}
	Should Be Equal    ${resp[0]['correctRate']}    ${sql}
	Should Be Equal    ${resp[0]['userInfo']['nickName']}    ${sql}
	Should Be Equal    ${resp[0]['userInfo']['headImageUrl']}    ${sql}
	Should Be Equal    ${resp[0]['isReach']}    ${sql}
	Should Be Equal    ${resp[0]['otherUserInfo']['nickName']}    ${sql}
	Should Be Equal    ${resp[0]['otherUserInfo']['headImageUrl']}    ${sql}
	Should Be Equal    ${resp[0]['isMe']}    ${sql}
	Should Be Equal    ${resp[0]['questionNum']}    ${sql}


activity_join_resp
	${resp}    evaluate    ${activity_join_resp}
	Should Be Equal    ${resp['status']}    ${sql}
	Should Be Equal    ${resp['aName']}    ${sql}
	Should Be Equal    ${resp['people']}    ${sql}


activity_decodeUserInfo_resp
	${resp}    evaluate    ${activity_decodeUserInfo_resp}
	Should Be Equal    ${resp['status']}    ${sql}
	Should Be Equal    ${resp['msg']}    ${sql}


activity_worldCup_ranking_resp
	${resp}    evaluate    ${activity_worldCup_ranking_resp}
	Should Be Equal    ${resp[0]['rankingNum']}    ${sql}
	Should Be Equal     ${resp[0]['users'][0]}    ${sql}
	Should Be Equal    ${resp[0]['privity']}    ${sql}
	Should Be Equal    ${resp[0]['result']}    ${sql}
	Should Be Equal    ${resp[0]['id']}    ${sql}
	Should Be Equal    ${resp[0]['isMe']}    ${sql}


activity_worldCup_remindTeammates_resp
	${resp}    evaluate    ${activity_worldCup_remindTeammates_resp}
	Should Be Equal    ${resp}    ${sql}


activity_pointQuestion_home_resp
	${resp}    evaluate    ${activity_pointQuestion_home_resp}
	Should Be Equal    ${resp['headImageUrl']}    ${sql}
	Should Be Equal    ${resp['highestApm']}    ${sql}
	Should Be Equal    ${resp['nickName']}    ${sql}
	Should Be Equal    ${resp['chance']}    ${sql}
	Should Be Equal    ${resp['usersHeadImageUrl'][0]['headImageUrl']}    ${sql}


activity_draw_shareUser_resp
	${resp}    evaluate    ${activity_draw_shareUser_resp}
	Should Be Equal    ${resp['helpList'][0]['nicName']}    ${sql}
	Should Be Equal    ${resp['helpList'][0]['headImageUrl']}    ${sql}
	Should Be Equal    ${resp['drawType']}    ${sql}


activity_goods_resp
	${resp}    evaluate    ${activity_goods_resp}
	Should Be Equal    ${resp['goodsList'][0]['url']}    ${sql}
	Should Be Equal    ${resp['goodsList'][0]['name']}    ${sql}


activity_valentines_form_resp
	${resp}    evaluate    ${activity_valentines_form_resp}
	Should Be Equal    ${resp}    ${sql}


activity_worldCup_userDetails_resp
	${resp}    evaluate    ${activity_worldCup_userDetails_resp}
	Should Be Equal    ${resp['rankingNum']}    ${sql}
	Should Be Equal    ${resp['carryPrize']}    ${sql}
	Should Be Equal    ${resp['privity']}    ${sql}
	Should Be Equal    ${resp['countDown']}    ${sql}
	Should Be Equal    ${resp['remind']}    ${sql}
	Should Be Equal    ${resp['userInfo']['examTypeNameSon']}    ${sql}
	Should Be Equal    ${resp['userInfo']['headImageUrl']}    ${sql}
	Should Be Equal    ${resp['userInfo']['correctRate']}    ${sql}
	Should Be Equal    ${resp['userInfo']['examTypeNameParent']}    ${sql}
	Should Be Equal    ${resp['userInfo']['nickName']}    ${sql}
	Should Be Equal    ${resp['userInfo']['answerNum']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['examTypeNameSon']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['headImageUrl']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['correctRate']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['examTypeNameParent']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['nickName']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['answerNum']}    ${sql}
	Should Be Equal    ${resp['change']}    ${sql}


activity_draw_join_resp
	${resp}    evaluate    ${activity_draw_join_resp}


activity_worldCup_match_resp
	${resp}    evaluate    ${activity_worldCup_match_resp}
	Should Be Equal    ${resp['success']}    ${sql}


activity_worldCup_barrage_resp
	${resp}    evaluate    ${activity_worldCup_barrage_resp}
	Should Be Equal    ${resp[0]['oneHeadImage']}    ${sql}
	Should Be Equal    ${resp[0]['type']}    ${sql}
	Should Be Equal    ${resp[0]['up']}    ${sql}
	Should Be Equal    ${resp[0]['twoHeadImage']}    ${sql}


activity_worldCup_join_resp
	${resp}    evaluate    ${activity_worldCup_join_resp}
	Should Be Equal    ${resp['status']}    ${sql}


activity_APM_ranking_resp
	${resp}    evaluate    ${activity_APM_ranking_resp}
	Should Be Equal    ${resp['meInfo']['rankingNum']}    ${sql}
	Should Be Equal    ${resp['meInfo']['title']}    ${sql}
	Should Be Equal    ${resp['meInfo']['apm']}    ${sql}
	Should Be Equal    ${resp['meInfo']['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['meInfo']['nickName']}    ${sql}
	Should Be Equal    ${resp['meInfo']['questionSum']}    ${sql}
	Should Be Equal    ${resp['userInfo'][0]['rankingNum']}    ${sql}
	Should Be Equal    ${resp['userInfo'][0]['title']}    ${sql}
	Should Be Equal    ${resp['userInfo'][0]['apm']}    ${sql}
	Should Be Equal    ${resp['userInfo'][0]['headImgUrl']}    ${sql}
	Should Be Equal    ${resp['userInfo'][0]['nickName']}    ${sql}
	Should Be Equal    ${resp['userInfo'][0]['currentUser']}    ${sql}
	Should Be Equal    ${resp['userInfo'][0]['questionSum']}    ${sql}


activity_worldCup_kickOut_resp
	${resp}    evaluate    ${activity_worldCup_kickOut_resp}
	Should Be Equal    ${resp}    ${sql}


activity_push_resp
	${resp}    evaluate    ${activity_push_resp}
	Should Be Equal    ${resp['aName']}    ${sql}


activity_worldCup_teamDetails_resp
	${resp}    evaluate    ${activity_worldCup_teamDetails_resp}
	Should Be Equal    ${resp['end']}    ${sql}
	Should Be Equal    ${resp['carryPrize']}    ${sql}
	Should Be Equal    ${resp['privity']}    ${sql}
	Should Be Equal    ${resp['countDown']}    ${sql}
	Should Be Equal    ${resp['remind']}    ${sql}
	Should Be Equal    ${resp['match']}    ${sql}
	Should Be Equal    ${resp['showCountDown']}    ${sql}
	Should Be Equal    ${resp['rankingNum']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['examTypeNameSon']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['headImageUrl']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['correctRate']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['examTypeNameParent']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['selfSex']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['nickName']}    ${sql}
	Should Be Equal    ${resp['otherUserInfo']['answerNum']}    ${sql}
	Should Be Equal    ${resp['change']}    ${sql}
	Should Be Equal    ${resp['userInfo']['examTypeNameSon']}    ${sql}
	Should Be Equal    ${resp['userInfo']['headImageUrl']}    ${sql}
	Should Be Equal    ${resp['userInfo']['correctRate']}    ${sql}
	Should Be Equal    ${resp['userInfo']['examTypeNameParent']}    ${sql}
	Should Be Equal    ${resp['userInfo']['selfSex']}    ${sql}
	Should Be Equal    ${resp['userInfo']['nickName']}    ${sql}
	Should Be Equal    ${resp['userInfo']['answerNum']}    ${sql}


