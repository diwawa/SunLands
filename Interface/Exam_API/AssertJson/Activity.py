# coding=utf-8

activity = [
    {
        "activityName": "string",
        "activityType": "string",
        "activityUrl": "string",
        "activityImgUrl": "string",
        "status": "string",
        "people": 0,
        "lastDay": 0
    }
]

push = {
    "aName": "string"
}

join = {
    "aName": "string",
    "status": 0,
    "people": 0
}

details = {
    "aName": "string",
    "people": 0,
    "userList": [
        {
            "name": "string",
            "headImageUrl": "string"
        }
    ]
}

goods = {
    "goodsList": [
        {
            "name": "string",
            "url": "string"
        }
    ]
}

decodeUserInfo = {
    "status": 0,
    "msg": "string"
}

draw_details = {
    "schedule": 0,
    "needPeple": 0,
    "phoneAuth": True,
    "phoneNumberDone": True,
    "goodsList": [
        {
            "name": "string",
            "url": "string"
        }
    ],
    "helpList": [
        {
            "nicName": "string",
            "headImageUrl": "string"
        }
    ],
    "wxInfo": {
        "wxName": "string",
        "wxCodeUrl": "string"
    },
    "drawInfo": {
        "drawType": "string",
        "headerDesc": "string",
        "bodyDesc": "string",
        "footDesc": "string"
    }
}

draw_shareUser = {
    "drawType": "string",
    "helpList": [
        {
            "nicName": "string",
            "headImageUrl": "string"
        }
    ]
}

draw_help = {
    "done": 0
}

valentines_form = [
    {
        "isShow": True,
        "successNum": 0,
        "successInfos": {
            "clockInDay": 0,
            "correctRate": 0,
            "questionNum": "string",
            "rankingNum": 0,
            "userInfo": {
                "headImageUrl": "string",
                "nickName": "string"
            },
            "otherUserInfo": {
                "headImageUrl": "string",
                "nickName": "string"
            }
        }
    }
]

valentines_details = {
    "carryPrize": True,
    "rankingNum": 0,
    "userInfo": {
        "headImageUrl": "string",
        "nickName": "string",
        "examTypeNameParent": "string",
        "examTypeNameSon": "string",
        "answerNum": "string",
        "correctRate": "string"
    },
    "otherUserInfo": {
        "headImageUrl": "string",
        "nickName": "string",
        "examTypeNameParent": "string",
        "examTypeNameSon": "string",
        "answerNum": "string",
        "correctRate": "string"
    }
}

valentines_ranking = [
    {
        "isReach": True,
        "isMe": True,
        "clockInDay": 0,
        "correctRate": "string",
        "questionNum": 0,
        "rankingNum": 0,
        "userInfo": {
            "headImageUrl": "string",
            "nickName": "string"
        },
        "otherUserInfo": {
            "headImageUrl": "string",
            "nickName": "string"
        }
    }
]

APM_ranking = {
    "userInfo": [
        {
            "rankingNum": 0,
            "currentUser": True,
            "headImgUrl": "string",
            "nickName": "string",
            "title": "string",
            "questionSum": 0,
            "apm": 0
        }
    ],
    "meInfo": {
        "rankingNum": 0,
        "headImgUrl": "string",
        "nickName": "string",
        "title": "string",
        "questionSum": 0,
        "apm": 0
    }
}

pointQuestion_final = {
    "title": "string",
    "question": 0,
    "pointSum": 0
}

pointQuestion_home = {
    "nickName": "string",
    "headImageUrl": "string",
    "highestApm": 0,
    "chance": "string",
    "usersHeadImageUrl": [
        {
            "headImageUrl": "string"
        }
    ]
}
