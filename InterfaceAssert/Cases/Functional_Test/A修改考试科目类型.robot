*** Settings ***
Force Tags        功能测试
Library           ../../Common/Function.py
Resource          ../../API/Users.robot
Variables         ../../Base.py
Variables         ../../Datas/Params/Users.py
Variables         ../../Datas/Response/Users.py
Resource          ../../API/Subject.robot
Variables         ../../Datas/Params/Subject.py
Variables         ../../Datas/Response/Subject.py
Resource          ../../API/ExamType.robot
Variables         ../../Datas/Params/ExamType.py
Variables         ../../Datas/Response/ExamType.py
Library           ../../Common/GetSQL.py

*** Keywords ***
ExamTypes_item_assert
    [Arguments]  ${items}    ${parent_id}    ${child_ids}    ${child_names}
    ${len}    evaluate     len(${items})
    :For    ${x}    In Range    ${len}
    \    Should Be Equal as integers    ${items[${x}]['examTypeId']}    ${child_ids[${x}]}
    \    should be equal as strings     ${items[${x}]['primaryCategories']}    ${child_names[${x}]}
    \    should be equal as strings    ${items[${x}]['description']}    ${child_names[${x}]}
    \    should be equal as integers    ${items[${x}]['parentId']}    ${parent_id}
*** Test Cases ***
examTypes
	[Documentation]    查询考试类型列表
	[Tags]    Run
	${resp}    get/examTypes    ${token}
	${len}    evaluate     len(${resp})
	${sql_examType}    examType
	:For    ${x}    In Range    ${len}
    \     should be equal as integers    ${resp[${x}]['examTypeId']}    ${sql_examType['parent_id'][${x}]}
    \     should be equal as strings    ${resp[${x}]['primaryCategories']}    ${sql_examType['parent_name'][${x}]}
    \     should be equal as strings    ${resp[${x}]['description']}    ${sql_examType['parent_name'][${x}]}
    \     should not be true    ${resp[${x}]['parentId']}
    \     ExamTypes_item_assert     ${resp[${x}]['items']}    ${sql_examType['parent_id'][${x}]}    ${sql_examType['child_id'][${x}]}    ${sql_examType['child_name'][${x}]}

users_examTypes
	[Documentation]    修改用户考试类型
	[Tags]    Run
	${sql_examType}    examType
	${examTypeId}    getRandomStr     ${sql_examType['child_id'][0]}
	set suite variable     ${examTypeId}
	${resp}    put/users/examTypes    ${token}    ${examTypeId}    ${True}

subjects
	[Documentation]    根据考试类型id查询科目列表
	[Tags]    Run
	${resp}    get/subjects    ${token}    ${examTypeId}
	${sql_subject}    subject    ${examTypeId}
	${len}    evaluate    len(${resp})
	:For    ${x}    In Range    ${len}
	\    Should Be Equal    ${resp[${x}]['examTypeId']}    ${examTypeId}
	\    Should Be Equal    ${resp[${x}]['subjectName']}    ${sql_subject['subject_name'][${x}]}
	\    Should Be Equal    ${resp[${x}]['number']}    ${sql_subject['number'][${x}]}
	\    Should Be Equal    ${resp[${x}]['subjectId']}    ${sql_subject['id'][${x}]}


users_subjects
	[Documentation]    修改用户科目
	[Tags]    Run
	${sql_subject}    subject    ${examTypeId}
	${subjectId}     getRandomStr     ${sql_subject['id']}
	set suite variable    ${subjectId}
	${resp}    put/users/subjects    ${token}    ${subjectId}

put_Assert
    [Documentation]  断言修改考试类型，科目是否正确
	${sql_info}    userAlterableInfo    ${userId}
	should be equal as integers      ${examTypeId}    ${sql_info['exam_type_id']}
	should be equal as integers      ${subjectId}    ${sql_info['subject_id']}


