# coding=utf-8

me = {
    "userId": 0,
    "headImgUrl": 0,
    "levelNum": 0,
    "nickName": 0,
    "shareMark": "string",
    "danGradingView": {
        "danGradingName": "string",
        "currentStar": "string",
        "pkSum": "string",
        "winSum": "string",
        "winRate": "string"
    }
}


join = {
  "success": True,
  "targetUserView": {
    "userId": 0,
    "headImgUrl": "string",
    "levelNum": 0,
    "nickName": "string",
    "sharePkLogScore": 0,
    "danGradingView": {
      "danGradingName": "string",
      "currentStar": "string"
    }
  },
  "currentUserView": {
    "userId": 0,
    "headImgUrl": "string",
    "levelNum": 0,
    "nickName": "string",
    "danGradingView": {
      "danGradingName": "string",
      "currentStar": "string"
    }
  }
}

target = {
    "userId": 0,
    "headImgUrl": 0,
    "levelNum": 0,
    "nickName": 0,
    "danGradingView": {
        "danGradingName": "string",
        "currentStar": "string",
        "pkSum": "string",
        "winSum": "string",
        "winRate": "string"
    }
}

pkMatch = {
    "pkLogId": 0,
    "targetUserView": {
        "userId": 0,
        "headImgUrl": "string",
        "levelNum": 0,
        "nickName": "string",
        "sharePkLogScore": 0,
        "danGradingView": {
            "danGradingName": "string",
            "currentStar": "string"
        }
    },
    "currentUserView": {
        "userId": 0,
        "headImgUrl": "string",
        "levelNum": 0,
        "nickName": "string",
        "danGradingView": {
            "danGradingName": "string",
            "currentStar": "string"
        }
    }
}

quit = {
    "userId": 0,
    "headImgUrl": 0,
    "levelNum": 0,
    "nickName": 0,
    "danGradingView": {
        "danGradingName": "string",
        "currentStar": "string",
        "pkSum": "string",
        "winSum": "string",
        "winRate": "string"
    }
}

pkQuestions = {
    "questionSum": 0,
    "questionCurrentNum": 0,
    "targetUserDuration": 0,
    "targetUserScore": 0,
    "targetUserScoreSum": 0,
    "currentUserScoreSum": 0,
    "questionId": 0,
    "questionDesc": "string",
    "questionType": "string",
    "options": [
        {
            "option": "string",
            "optionDesc": "string"
        }
    ]
}

pkAnswer = {
    "currentUserScore": 0,
    "currentUserScoreSum": 0,
    "targetUserAnswer": "string",
    "correctAnswer": "string"
}

targetAnswerDetail = {
    "targetUserScore": 0,
    "targetUserDuration": 0,
    "targetUserScoreSum": 0,
    "targetUserAnswer": "string",
    "correctAnswer": "string"
}

danGradingTips = {
    "danGradingName": "string",
    "integral": 0
}

pkFinal = {
    "pkLogId": 0,
    "userId": 0,
    "targetUserView": {
        "userId": 0,
        "headImgUrl": "string",
        "levelNum": 0,
        "nickName": "string",
        "userScoreSum": 0,
        "danGradingView": {
            "danGradingName": "string",
            "currentStar": "string"
        }
    },
    "currentUserView": {
        "results": "string",
        "userId": 0,
        "headImgUrl": "string",
        "levelNum": 0,
        "nickName": "string",
        "userScoreSum": 0,
        "danGradingView": {
            "danGradingName": "string",
            "currentStar": "string",
            "beforeStar": 0
        }
    }
}

pkFinal_share = {
    "shareUserView": {
        "headImgUrl": "string",
        "levelNum": 0,
        "nickName": "string",
        "scoreSum": 0,
        "danGradingName": "string",
        "startNum": "string"
    },
    "currentUserView": {
        "headImgUrl": "string",
        "levelNum": 0,
        "nickName": "string",
        "danGradingName": "string",
        "startNum": "string"
    }
}
