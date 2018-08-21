import os

url = "https://exam.zmgongzuoshi.top"
ReqChannel = "MASTER"

dbHost = '172.16.164.208'
dbPort = 3300
dbName = 'exam_shangde_01'
dbUsername = 'root'
dbPassword = 'feo@2030'
dbCharset = 'utf8'

curr_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
conf_dir = os.path.join(curr_dir, "Conf")
yaml_names = ["exam-swagger", "assist-swagger"]
yaml_table = os.path.join(conf_dir, "yaml_table.xls")
business_tabel = os.path.join(conf_dir, "Business.xls")

excel_case_dir = os.path.join(curr_dir, "External", "FunCases.xlsx")
case_dir = os.path.join(curr_dir, "Cases", excel_case_dir.split("\\")[-1].split(".")[0])
api_cases_dir = os.path.join(curr_dir, "Cases", "APICases_Doc")

business_dir = os.path.join(curr_dir, "Business")
business_robot = os.path.join(business_dir, "Business.robot")

datas_dir = os.path.join(curr_dir, "Datas")
param_datas_dir = os.path.join(datas_dir, "Params")
resp_datas_dir = os.path.join(datas_dir, "Resps")

# print os.listdir("E:\RFCode\AutoCreateCases\Conf")
