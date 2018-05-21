# coding=utf-8
chapters = {
    "errorSum": 0,
    "chapters": [
        {
            "chapterId": 0,
            "chapterName": "string",
            "people": 0,
            "current": "string",
            "totle": "string",
            "errorNum": "string"
        }
    ]
}

myQuestionStem_chapterId = [
    {
        "questionId": "string",
        "questionDesc": "string",
        "date": "string",
        "errorNum": 0,
        "collectNum": 0
    }
]

examPapers = [
    {
        "examPapersId": 0,
        "examPaperName": "string",
        "finish": True,
        "people": 0,
        "current": "string",
        "totle": "string"
    }
]

examPapers_history = [
    {
        "examPapersId": 0,
        "userAnswerId": 0,
        "examPaperName": "string",
        "score": "string",
        "finishTime": 0,
        "date": 0,
        "unfinishedNum": 0
    }
]

examQuestion = [
    {
        "questionId": 0,
        "questionDesc": "string",
        "questionType": "string",
        "number": 0,
        "collect": True,
        "options": [
            {
                "option": "string",
                "optionDesc": 0,
                "selected": True,
                "stutus": "string"
            }
        ],
        "answer": {
            "correctAnswer": "string",
            "correctAnswerDesc": 0,
            "errorNum": 0,
            "errorPeople": 0,
            "newestCorrect": True,
            "errorRate": 0,
            "errorFatherRate": 0
        }
    }
]
