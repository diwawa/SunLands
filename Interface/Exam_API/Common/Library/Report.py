# coding=utf-8
import xlwt
import os
import time


class Report(object):
    def __init__(self):
        self.curr_dir = os.getcwd()

    def Read_From_File(self, filename):
        file = os.path.join(self.curr_dir, filename)
        try:
            f = open(file, 'r')
            data = f.read().decode('utf-8')
        except Exception, e:
            print str(e)
        finally:
            f.close()
        return data

    def Delete_Form_File(self, filename):
        if os.path.exists(filename):
            # 删除文件，可使用以下两种方法。
            os.remove(filename)
            # os.unlink(filename)
        else:
            print 'no such file:%s' % filename

    def Set_Style(self, name, height, colour=1, bold=False, pattern_colour=None):
        # default font style

        # Cell set alignment
        alignment = xlwt.Alignment()
        alignment.horz = xlwt.Alignment.HORZ_LEFT
        alignment.vert = xlwt.Alignment.VERT_CENTER

        # Cell add borders
        borders = xlwt.Borders()
        borders.left = xlwt.Borders.THIN
        borders.right = xlwt.Borders.THIN
        borders.top = xlwt.Borders.THIN
        borders.bottom = xlwt.Borders.THIN
        borders.left_colour = 0x40
        borders.right_colour = 0x40
        borders.top_colour = 0x40
        borders.bottom_colour = 0x40

        # Cell set font style
        font = xlwt.Font()
        font.name = name
        font.height = height
        font.colour_index = colour
        font.bold = bold

        if pattern_colour != None:
            # Cell set background colour
            pattern = xlwt.Pattern()
            pattern.pattern = xlwt.Pattern.SOLID_PATTERN
            pattern.pattern_fore_colour = pattern_colour

        style = xlwt.XFStyle()
        style.alignment = alignment
        if pattern_colour != None:
            # Cell set background colour
            style.pattern = pattern
        style.borders = borders
        style.font = font
        return style


    def Write_To_Excel_File(self, filename, *data):
        wb = xlwt.Workbook()
        ws = wb.add_sheet("Test Result", cell_overwrite_ok=True)
        # Cell set width of column
        col_wid = ws.col(0)
        col_wid.width = 256 * 20
        col_wid = ws.col(1)
        col_wid.width = 256 * 20
        col_wid = ws.col(2)
        col_wid.width = 256 * 20
        col_wid = ws.col(3)
        col_wid.width = 256 * 10
        col_wid = ws.col(4)
        col_wid.width = 256 * 50
        col_wid = ws.col(5)
        col_wid.width = 256 * 30

        total_case = 0
        pass_case = 0
        fail_case = 0

        start_row = 6
        row_status = ['SuiteName', 'CaseName', 'TagName', 'Status', 'Error Message', 'Cause of Error']
        for i in xrange(0, len(row_status)):
            ws.write(start_row-1, i, row_status[i],self.Set_Style('Arial', 220, 0x7FFF, True, pattern_colour=22))
        for value in data:
            total_case = len(value)
            for row in xrange(total_case):
                len_col = len(value[row])
                ws.write(row + start_row, len_col, '',self.Set_Style('Arial', 200, 64))
                for col in xrange(len_col):
                    if col == 0:
                        # 去除项目名称及Cases
                        str1 = value[row][0].split(".")
                        str1.pop(0)
                        str1.pop(0)
                        str2 = str1[0]
                        for x in range(1, len(str1)):
                            str2 += "--" + str1[x]
                        ws.write(row + start_row, 0, str2,self.Set_Style('Arial', 200, 64))
                    elif col == 2:
                        str1 = value[row][2]
                        # 将unicode转换成中文
                        str2 = str(str1).replace('u\'', '\'')
                        print(str2.decode("unicode-escape"))
                        ws.write(row + start_row, 2, str2.decode("unicode-escape"),self.Set_Style('Arial', 200, 64))
                    elif col == 3:
                        if value[row][3] == 'PASS':
                            pass_case += 1
                        elif value[row][3] == 'FAIL':
                            fail_case += 1
                        else:
                            pass
                        ws.write(row + start_row, 3, value[row][3],self.Set_Style('Arial', 200, 12, True))
                    else:
                        ws.write(row + start_row, col, value[row][col],self.Set_Style('Arial', 200, 64))

        per = float((pass_case * 100) )/ float((fail_case + pass_case))
        percentage = str('{:.2f}'.format(per)) + '%'
        row_statistics = ['Total', 'Pass', 'Fail', 'Percentage']
        test_statistics = [total_case, pass_case, fail_case, percentage]
        for i in xrange(len(test_statistics)):
            ws.write(i, 0, row_statistics[i], self.Set_Style('Arial', 220, 64, True, pattern_colour=22))
            ws.write(i, 1, test_statistics[i], self.Set_Style('Arial', 200, 2))

        wb.save(filename)

    def Reorganize_Data(self, data):
        # Reorganize data for writing them to CSV/Excel file
        allList = []
        reorganized = data.split('|')
        for row in reorganized:
            allList.append(row.split('::'))
        allList.pop(-1)
        return allList

    def Create_Excel_Report(self, suitename,filename):
        # Create Excel Report | ${filename}
        file_date = 'Report\\'+ suitename + "_" + time.strftime("%Y%m%d-%H%M%S", time.localtime()) + '.xls'
        report_file = os.path.join(self.curr_dir, file_date)  # Default File Path
        lines = self.Read_From_File(filename)
        data = self.Reorganize_Data(lines)
        self.Write_To_Excel_File(report_file, data)
        self.Delete_Form_File(filename)

