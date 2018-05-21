# coding=utf-8
import time
import random


class Function(object):
    def __init__(self):
        pass

    def convertTimestamp(self, data):
        u'''
        将时间转换成时间戳
        '''
        # 转换成时间数组
        timeArray = time.strptime(data, "%Y-%m-%d %H:%M:%S")
        # 转换成时间戳
        timestamp = int(time.mktime(timeArray))

        return timestamp

    def getRandom(self, n1, n2):
        u'''
        获取n1到n2的随机整数
        '''
        return random.randint(n1,n2)


    def compareJsonkeys(self, assertJson, responseJson):
        u'''
        比较接口返回值与接口文档中的字段名称是否一致
        '''
        re_dict = {"assertStatus": True}
        if type(assertJson) == type(responseJson):
            while True:
                if type(assertJson) is list:
                    assertJson = assertJson[0]
                    responseJson = responseJson[0]
                elif type(assertJson) is dict:
                    break
                else:
                    return re_dict

            list1 = assertJson.keys()
            list2 = responseJson.keys()
            list1.sort()
            list2.sort()

            if list1 == list2:
                # 返回所有字段
                re_dict["sameKeys"] = list1
            else:
                index1 = []
                index2 = []

                for key1 in list1:
                    for key2 in list2:
                        if key1 == key2:
                            i1 = list1.index(key1)
                            i2 = list2.index(key2)
                            index1.append(i1)
                            index2.append(i2)

                index1.reverse()
                for i in index1:
                    list1.pop(i)

                index2.sort()
                index2.reverse()
                for i in index2:
                    list2.pop(i)

                # 返回不同的字段
                re_dict["assertStatus"] = False
                re_dict["assertKeys"] = list1
                re_dict["responseKeys"] = list2
        else:
            # 返回不同类型值
            re_dict["assertStatus"] = False
            re_dict["assertType"] = type(assertJson)
            re_dict["responseType"] = type(responseJson)

        return re_dict

    def compareJsonvaluesTpye(self, assertJson, responseJson):
        u'''
        当key一致时，判断接口返回值与接口文档中的值得类型是否一致
        '''
        re_dict = {"assertStatus": True}
        while True:
            if type(assertJson) is list:
                assertJson = assertJson[0]
                responseJson = responseJson[0]

            elif type(assertJson) is dict:
                keys = assertJson.keys()
                for key in keys:
                    v1 = assertJson[key]
                    v2 = responseJson[key]
                    t1 = type(v1)
                    t2 = type(v2)

                    if t2 is unicode:
                        v2 = v2.encode("utf-8")
                        t2 = type(v2)
                    if t1 == t2:
                        pass
                    else:
                        # 类型不一致，返回false，并返回对应类型值
                        re_dict["assertStatus"] = False
                        re_dict[key] = {'assertType': t1, 'responseType': t2}
                return re_dict
            else:
                t1 = type(assertJson)
                t2 = type(responseJson)
                if t2 is unicode:
                    t2 = type(responseJson.encode("utf-8"))
                if t1 == t2:
                    pass
                else:
                    re_dict["assertStatus"] = False
                    re_dict["listValue"] = {'assertType': t1, 'responseType': t2}
                return re_dict


if __name__ == '__main__':
    Function = Function()
