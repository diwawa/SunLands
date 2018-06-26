*** Settings ***
Library           ../../Common/Function.py
Library           ../../Common/GetSQL.py
Resource          ../../API/Activity.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/Activity.py
Variables         ../../Datas/Response/Activity.py


*** Keywords ***
get/users/share_AC
	[Arguments]    ${token}
	[Documentation]    小程序分享
	Create Session    exam    https://exam.zmgongzuoshi.top/api/v1
	${headers}    Create Dictionary    Authorization    ${token}
	${params}    Create Dictionary    shareType    AC
	${resp}    get request    exam    /users/share    headers=${headers}    params=${params}
	should be equal as integers    ${resp.status_code}    200    ${resp.content}
	[Return]    ${resp.content}