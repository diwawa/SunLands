import os
curr_dir = os.path.dirname(os.path.realpath(__file__))
api_dir = curr_dir + "\\API\\"
cases_dir = curr_dir + "\\Cases\\API_Tests\\"
casesnew_dir = curr_dir + "\\Cases\\API_Tests_New\\"
params_dir = curr_dir + "\\Datas\\Params\\"
paramsnew_dir = curr_dir + "\\Datas\\Params_New\\"
resp_dir = curr_dir + "\\Datas\\Response\\"
respAssert_dir = curr_dir + "\\Datas\\RespAssert\\"
resp_pack = "Datas.Response."

host = "exam.zmgongzuoshi.top"
url = "https://" + host + "/api/v1"

token = 'eyJhbGciOiJIUzUxMiJ9.eyJhIjpudWxsLCJzIjoibzJFSVYwVjlXMklab2Q2SmJQM3MwbXZJMG5vZyIsImMiOjE1Mjg5NDQ4NTE4MjUsImUiOjE1MzAyNDA4NTE4MjUsImkiOjN9.EviWtAukrfYEwJfpNawYlNqCaawfp1hNcExEY8LSOugWDBwkzeX7rhva8u7HJBBsLT8lfBx-kXmI7St-Sk40Pw'
userId = 3
token2 = 'eyJhbGciOiJIUzUxMiJ9.eyJhIjpudWxsLCJzIjoibzJFSVYwVUk1dl9VTHlwblI4WUVlY2tkbGdJOCIsImMiOjE1Mjg2ODY1OTkxMTMsImUiOjE1Mjk5ODI1OTkxMTMsImkiOjE1fQ.W0s1n27UMbBE565v1qTtR7mttrnBKrDF-bU3bNz7xkt90QCy1cPEj7IQ3QgBJJ_twRoVv7QwQ6BuH6jJu74OMQ'
userId2 = 15
token3 = 'eyJhbGciOiJIUzUxMiJ9.eyJhIjpudWxsLCJzIjoibzJFSVYwVmlhTUJkd3BYS19VeVkzWXEwSGF1RSIsImMiOjE1Mjk2NjEwNTc2MjAsImUiOjE1MzA5NTcwNTc2MjAsImkiOjEyOTcxM30.Xww4LT7vOZCel8Jo2ldkjGo2fElUwaW9OY76Sy4GEYuIj091O3zftVkg4Vd3__CSfXYFN28-rv2azZAyU5Zovw'
userId3 = 129713

dbHost = '172.16.164.208'
dbPort = 3300
dbName = 'exam_shangde_01'
dbUsername = 'root'
dbPassword = 'feo@2030'
dbCharset = 'utf8'
