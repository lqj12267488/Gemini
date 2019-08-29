package com.goisan.system.service.impl;

import com.goisan.educational.major.bean.Major;
import com.goisan.educational.major.service.MajorService;
import com.goisan.system.bean.*;
import com.goisan.system.dao.StudentDao;
import com.goisan.system.service.ClassService;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.StudentService;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.*;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/5/20.
 */
@Service
public class StudentServiceImpl implements StudentService {
    @Resource
    private StudentDao studentDao;

    public List<Student> getStudentList(Student student) {
        return studentDao.getStudentList(student);
    }

    @Override
    public Student getStudentByIdcard(String idcard) {
        return studentDao.getStudentByIdcard(idcard);
    }

    public Student getStudentById(String studentId) {
        return studentDao.getStudentById(studentId);
    }

    public Student getStudentNameByStudentId(String studentId) {
        return studentDao.getStudentNameByStudentId(studentId);
    }

    public String getDepartmentsIdByStudentId(String studentId) {
        return studentDao.getDepartmentsIdByStudentId(studentId);
    }

    public void insertStudent(Student student) {
        studentDao.insertStudent(student);
    }

    public void updateStudent(Student student) {
        studentDao.updateStudent(student);
    }

    public void delStudent(String studentId) {
        studentDao.delStudent(studentId);
    }

    public void delClassStudentRelation(String studentId) {
        studentDao.delClassStudentRelation(studentId);
    }

    public void delRoleByStudentId(String studentId) {
        studentDao.delRoleByStudentId(studentId);
    }

    public List<Tree> getMajorClassTree() {
        return studentDao.getMajorClassTree();
    }

    public List<Tree> getMajorClassTreeByLevel(String level) {
        return studentDao.getMajorClassTreeByLevel(level);
    }

    public void addRelation(ClassStudentRelation relation) {
        studentDao.addRelation(relation);
    }

    public List<ClassStudentRelation> getClassStudentRelation(String studentId) {
        return studentDao.getClassStudentRelation(studentId);
    }

    public String getTreeTable(String id) {
        return studentDao.getTreeTable(id);
    }

    public List checkIdCard(String idcard) {
        return studentDao.checkIdCard(idcard);
    }

    public String getMajorCodeByMajorName(String majorName) {
        return studentDao.getMajorCodeByMajorName(majorName);
    }

    public List checkStudentNumber(String studentNumber) {
        return studentDao.checkStudentNumber(studentNumber);
    }

    public void saveClassStudentRelation(String studentId, String relationids) {
        studentDao.delClassStudentRelation(studentId);
        String[] idlist = relationids.split(",");
        studentDao.insertClassStudentRelation(studentId, idlist);
    }

    public List<Student> getStudentListByDept(String deptId, String deptIdLike, String name, String idcard, String level) {
        return studentDao.getStudentListByDept(deptId, deptIdLike, name, idcard, level);
    }

    public List<Student> getStudentListByMajor(String majorCode, String name, String idcard, String level) {
        return studentDao.getStudentListByMajor(majorCode, name, idcard, level);
    }

    public List<Tree> getStudentTree(String roleId) {
        return studentDao.getStudentTree(roleId);
    }

    public List<Student> findStudentListByStudentId(String ids) {
        return studentDao.findStudentListByStudentId(ids);
    }

    @Override
    public List<Student> getPaymentInfoStandardList(String id) {
        return studentDao.getPaymentInfoStandardList(id);
    }

    public List<Student> getStudentStatisticsList(Student student) {
        return studentDao.getStudentStatisticsList(student);
    }

    public String getClassNameByClassId(String class_id) {
        return studentDao.getClassNameByClassId(class_id);
    }

    public String getClassIdByClassName(String className) {
        return studentDao.getClassIdByClassName(className);
    }

    @Override
    public HSSFWorkbook getStudentExcelTemplate(String type) {
        List<Select2> ZZMM = commonService.getSysDict("ZZMM", "");
        List<Select2> sexs = commonService.getSysDict("XB", "");
        List<Select2> mz = commonService.getSysDict("MZ", "");
        List<Select2> xz = commonService.getSysDict("XZ", "");
        List<Select2> cc = commonService.getSysDict("CC", "");
        List<Select2> xxxs = commonService.getSysDict("XXXS", "");
        List<Major> majorList = majorService.getMajorList(new Major());
        List<ClassBean> classList = classService.getClassList(new ClassBean());
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("sheet");
        HSSFSheet sheet2 = wb.createSheet("sheet2");
        for (int i = 0; i < ZZMM.size(); i++) {
            HSSFRow row = sheet2.getRow(i);
            if (row == null) {
                row = sheet2.createRow(i);
            }
            row.createCell(0).setCellValue(ZZMM.get(i).getText());
        }
        for (int i = 0; i < mz.size(); i++) {
            HSSFRow row = sheet2.getRow(i);
            if (row == null) {
                row = sheet2.createRow(i);
            }
            row.createCell(1).setCellValue(mz.get(i).getText());
        }
        for (int i = 0; i < xz.size(); i++) {
            HSSFRow row = sheet2.getRow(i);
            if (row == null) {
                row = sheet2.createRow(i);
            }
            row.createCell(2).setCellValue(xz.get(i).getText());
        }
        for (int i = 0; i < cc.size(); i++) {
            HSSFRow row = sheet2.getRow(i);
            if (row == null) {
                row = sheet2.createRow(i);
            }
            row.createCell(3).setCellValue(cc.get(i).getText());
        }
        for (int i = 0; i < xxxs.size(); i++) {
            HSSFRow row = sheet2.getRow(i);
            if (row == null) {
                row = sheet2.createRow(i);
            }
            row.createCell(4).setCellValue(xxxs.get(i).getText());
        }
        for (int i = 0; i < majorList.size(); i++) {
            HSSFRow row = sheet2.getRow(i);
            if (row == null) {
                row = sheet2.createRow(i);
            }
            row.createCell(5).setCellValue(majorList.get(i).getMajorName());
        }
        for (int i = 0; i < classList.size(); i++) {
            HSSFRow row = sheet2.getRow(i);
            if (row == null) {
                row = sheet2.createRow(i);
            }
            row.createCell(6).setCellValue(classList.get(i).getClassName());
        }
        for (int i = 0; i < sexs.size(); i++) {
            HSSFRow row = sheet2.getRow(i);
            if (row == null) {
                row = sheet2.createRow(i);
            }
            row.createCell(7).setCellValue(sexs.get(i).getText());
        }
        HSSFCellStyle cellStyle = wb.createCellStyle();
        //cellStyle.setFillForegroundColor((short) 13);// 设置背景色
        cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
        cellStyle.setBorderTop(BorderStyle.THIN);//上边框
        cellStyle.setBorderRight(BorderStyle.THIN);//右边框
        cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
        cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
        cellStyle.setDataFormat(wb.createDataFormat().getFormat("@"));
        HSSFCellStyle headStyle = wb.createCellStyle();
        headStyle.cloneStyleFrom(cellStyle);
        HSSFFont hssfFont = wb.createFont();
        hssfFont.setColor(HSSFColor.RED.index);
        headStyle.setFont(hssfFont);
        sheet.setDefaultColumnStyle(0, cellStyle);
        sheet.setDefaultColumnStyle(1, cellStyle);
        sheet.setDefaultColumnStyle(2, cellStyle);
        sheet.setDefaultColumnStyle(3, cellStyle);
        sheet.setDefaultColumnStyle(4, cellStyle);
        sheet.setDefaultColumnStyle(5, cellStyle);
        sheet.setDefaultColumnStyle(6, cellStyle);
        sheet.setDefaultColumnStyle(7, cellStyle);
        sheet.setDefaultColumnStyle(8, cellStyle);
        sheet.setDefaultColumnStyle(9, cellStyle);
        sheet.setDefaultColumnStyle(10, cellStyle);
        sheet.setDefaultColumnStyle(11, cellStyle);
        sheet.setDefaultColumnStyle(12, cellStyle);
        sheet.setDefaultColumnStyle(13, cellStyle);
        sheet.setDefaultColumnStyle(14, cellStyle);
        HSSFCellStyle style = wb.createCellStyle();
        style.cloneStyleFrom(headStyle);
        style.setAlignment(HorizontalAlignment.LEFT);
        if(type.equals("0")){
            HSSFRow hssfRow = sheet.createRow(0);
            hssfRow.createCell(0).setCellValue("考生号");
            hssfRow.getCell(0).setCellStyle(headStyle);
            hssfRow.createCell(1).setCellValue("学号");
            hssfRow.getCell(1).setCellStyle(headStyle);
            hssfRow.createCell(2).setCellValue("姓名");
            hssfRow.getCell(2).setCellStyle(headStyle);
            hssfRow.createCell(3).setCellValue("性别");
            hssfRow.getCell(3).setCellStyle(headStyle);
            hssfRow.createCell(4).setCellValue("出生日期");
            hssfRow.getCell(4).setCellStyle(headStyle);
            hssfRow.createCell(5).setCellValue("身份证号");
            hssfRow.getCell(5).setCellStyle(headStyle);
            hssfRow.createCell(6).setCellValue("政治面貌");
            hssfRow.getCell(6).setCellStyle(headStyle);
            hssfRow.createCell(7).setCellValue("民族");
            hssfRow.getCell(7).setCellStyle(headStyle);
            hssfRow.createCell(8).setCellValue("专业代码");
            hssfRow.getCell(8).setCellStyle(cellStyle);
            hssfRow.createCell(9).setCellValue("专业名称");
            hssfRow.getCell(9).setCellStyle(headStyle);
            hssfRow.createCell(10).setCellValue("层次");
            hssfRow.getCell(10).setCellStyle(headStyle);
            hssfRow.createCell(11).setCellValue("学制");
            hssfRow.getCell(11).setCellStyle(headStyle);
            hssfRow.createCell(12).setCellValue("学习形式");
            hssfRow.getCell(12).setCellStyle(cellStyle);
            hssfRow.createCell(13).setCellValue("总分");
            hssfRow.getCell(13).setCellStyle(cellStyle);
            hssfRow.createCell(14).setCellValue("班级");
            hssfRow.getCell(14).setCellStyle(headStyle);
            setDataValidation(sheet, "Sheet2!$H$1:$H$" + sexs.size(), 2, 65535, 3, 3);
            setDataValidation(sheet, "Sheet2!$A$1:$A$" + ZZMM.size(), 2, 65535, 6, 6);
            setDataValidation(sheet, "Sheet2!$B$1:$B$" + mz.size(), 2, 65535, 7, 7);
            setDataValidation(sheet, "Sheet2!$F$1:$F$" + majorList.size(), 2, 65535, 9, 9);
            setDataValidation(sheet, "Sheet2!$C$1:$C$" + cc.size(), 2, 65535, 11, 11);
            setDataValidation(sheet, "Sheet2!$D$1:$D$" + xz.size(), 2, 65535, 10, 10);
            setDataValidation(sheet, "Sheet2!$E$1:$E$" + xxxs.size(), 2, 65535, 12, 12);
            setDataValidation(sheet, "Sheet2!$G$1:$G$" + classList.size(), 2, 65535, 14, 14);
            sheet.setDefaultColumnWidth(15);
            return wb;
        }else{
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 14));
            HSSFRow head = sheet.createRow(0);
            head.createCell(0).setCellValue("红色字段为必填项");
            head.getCell(0).setCellStyle(style);
            HSSFRow hssfRow = sheet.createRow(1);
            hssfRow.createCell(0).setCellValue("考生号");
            hssfRow.getCell(0).setCellStyle(headStyle);
            hssfRow.createCell(1).setCellValue("学号");
            hssfRow.getCell(1).setCellStyle(headStyle);
            hssfRow.createCell(2).setCellValue("姓名");
            hssfRow.getCell(2).setCellStyle(headStyle);
            hssfRow.createCell(3).setCellValue("性别");
            hssfRow.getCell(3).setCellStyle(headStyle);
            hssfRow.createCell(4).setCellValue("出生日期");
            hssfRow.getCell(4).setCellStyle(headStyle);
            hssfRow.createCell(5).setCellValue("身份证号");
            hssfRow.getCell(5).setCellStyle(headStyle);
            hssfRow.createCell(6).setCellValue("政治面貌");
            hssfRow.getCell(6).setCellStyle(headStyle);
            hssfRow.createCell(7).setCellValue("民族");
            hssfRow.getCell(7).setCellStyle(headStyle);
            hssfRow.createCell(8).setCellValue("专业代码");
            hssfRow.getCell(8).setCellStyle(cellStyle);
            hssfRow.createCell(9).setCellValue("专业名称");
            hssfRow.getCell(9).setCellStyle(headStyle);
            hssfRow.createCell(10).setCellValue("层次");
            hssfRow.getCell(10).setCellStyle(headStyle);
            hssfRow.createCell(11).setCellValue("学制");
            hssfRow.getCell(11).setCellStyle(headStyle);
            hssfRow.createCell(12).setCellValue("学习形式");
            hssfRow.getCell(12).setCellStyle(cellStyle);
            hssfRow.createCell(13).setCellValue("总分");
            hssfRow.getCell(13).setCellStyle(cellStyle);
            hssfRow.createCell(14).setCellValue("班级");
            hssfRow.getCell(14).setCellStyle(headStyle);
            setDataValidation(sheet, "Sheet2!$H$1:$H$" + sexs.size(), 2, 65535, 3, 3);
            setDataValidation(sheet, "Sheet2!$A$1:$A$" + ZZMM.size(), 2, 65535, 6, 6);
            setDataValidation(sheet, "Sheet2!$B$1:$B$" + mz.size(), 2, 65535, 7, 7);
            setDataValidation(sheet, "Sheet2!$F$1:$F$" + majorList.size(), 2, 65535, 9, 9);
            setDataValidation(sheet, "Sheet2!$C$1:$C$" + cc.size(), 2, 65535, 11, 11);
            setDataValidation(sheet, "Sheet2!$D$1:$D$" + xz.size(), 2, 65535, 10, 10);
            setDataValidation(sheet, "Sheet2!$E$1:$E$" + xxxs.size(), 2, 65535, 12, 12);
            setDataValidation(sheet, "Sheet2!$G$1:$G$" + classList.size(), 2, 65535, 14, 14);
            sheet.setDefaultColumnWidth(15);
            return wb;
        }


    }

    @Override
    public HSSFWorkbook getStudentExcelTemplate1() {
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("学生基础信息");
        HSSFSheet sheet2 = wb.createSheet("Sheet3");

        Font headerFont = wb.createFont();
        headerFont.setFontName("微软雅黑");// 将“华文行楷”字体应用到当前单元格上
        headerFont.setFontHeightInPoints((short) 11);
        headerFont.setColor(HSSFColor.RED.index);

        Font headerFont2 = wb.createFont();
        headerFont2.setColor(HSSFColor.BLUE.index);// 将字体设置为“红色”
        headerFont2.setFontHeightInPoints((short) 11);// 将字体大小设置为18px
        headerFont2.setFontName("微软雅黑");// 将“华文行楷”字体应用到当前单元格上

        Font headerFont3 = wb.createFont();
        headerFont3.setFontHeightInPoints((short) 11);// 将字体大小设置为18px
        headerFont3.setFontName("微软雅黑");// 将“华文行楷”字体应用到当前单元格上

        HSSFCellStyle headerStyle = wb.createCellStyle();
        HSSFCellStyle cellStyle = wb.createCellStyle();
        HSSFCellStyle cellStyle2 = wb.createCellStyle();

        //cellStyle.setFillForegroundColor((short) 11);// 设置背景色
        cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
        cellStyle.setBorderTop(BorderStyle.THIN);//上边框
        cellStyle.setBorderRight(BorderStyle.THIN);//右边框
        cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
        cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
        cellStyle.setFont(headerFont);

        headerStyle.cloneStyleFrom(cellStyle);
        headerStyle.setFont(headerFont);
        HSSFCellStyle hssfCellStyle2 = wb.createCellStyle();
        hssfCellStyle2.cloneStyleFrom(cellStyle);
        hssfCellStyle2.setFont(headerFont2);

        cellStyle2.setBorderLeft(BorderStyle.THIN);//左边框
        cellStyle2.setBorderTop(BorderStyle.THIN);//上边框
        cellStyle2.setBorderRight(BorderStyle.THIN);//右边框
        cellStyle2.setBorderBottom(BorderStyle.THIN); //下边框
        cellStyle2.cloneStyleFrom(cellStyle);
        cellStyle2.setFont(headerFont3);
        cellStyle2.setAlignment(HorizontalAlignment.LEFT);

        sheet.createRow(0).createCell(0).setCellValue("学生基础信息");
        sheet.getRow(0).getCell(0).setCellStyle(cellStyle2);

        sheet.setColumnWidth(0, 20 * 256);
        sheet.setColumnWidth(1, 20 * 256);
        sheet.setColumnWidth(2, 20 * 256);
        sheet.setColumnWidth(3, 20 * 256);
        sheet.setColumnWidth(4, 20 * 256);
        sheet.setColumnWidth(5, 20 * 256);
        sheet.setColumnWidth(6, 20 * 256);
        sheet.setColumnWidth(7, 20 * 256);
        sheet.setColumnWidth(8, 20 * 256);
        sheet.setColumnWidth(9, 20 * 256);
        sheet.setColumnWidth(10, 20 * 256);
        sheet.setColumnWidth(11, 20 * 256);
        sheet.setColumnWidth(12, 20 * 256);
        sheet.setColumnWidth(13, 20 * 256);
        sheet.setColumnWidth(14, 20 * 256);
        sheet.setColumnWidth(15, 20 * 256);
        sheet.setColumnWidth(16, 20 * 256);
        sheet.setColumnWidth(17, 20 * 256);
        sheet.setColumnWidth(18, 20 * 256);
        sheet.setColumnWidth(19, 20 * 256);
        sheet.setColumnWidth(20, 20 * 256);
        sheet.setColumnWidth(21, 20 * 256);
        sheet.setColumnWidth(22, 20 * 256);
        sheet.setColumnWidth(23, 20 * 256);
        sheet.setColumnWidth(24, 20 * 256);
        sheet.setColumnWidth(25, 20 * 256);
        sheet.setColumnWidth(26, 20 * 256);
        sheet.setColumnWidth(27, 20 * 256);
        sheet.setColumnWidth(28, 20 * 256);
        sheet.setColumnWidth(29, 20 * 256);
        sheet.setColumnWidth(30, 20 * 256);
        sheet.setColumnWidth(31, 20 * 256);
        sheet.setColumnWidth(32, 20 * 256);
        sheet.setColumnWidth(33, 20 * 256);
        sheet.setColumnWidth(34, 20 * 256);
        sheet.setColumnWidth(35, 20 * 256);
        sheet.setColumnWidth(36, 20 * 256);
        sheet.setColumnWidth(37, 20 * 256);
        sheet.setColumnWidth(38, 20 * 256);
        sheet.setColumnWidth(39, 20 * 256);
        sheet.setColumnWidth(40, 20 * 256);
        sheet.setColumnWidth(41, 20 * 256);
        sheet.setColumnWidth(42, 20 * 256);
        sheet.setColumnWidth(43, 20 * 256);
        sheet.setColumnWidth(44, 20 * 256);
        sheet.setColumnWidth(45, 20 * 256);
        sheet.setColumnWidth(46, 20 * 256);
        sheet.setColumnWidth(47, 20 * 256);


        HSSFRow headRow1 = sheet.createRow(1);
        HSSFCell row1Cell1 = headRow1.createCell(0);
        row1Cell1.setCellValue("红色字段为必填项");
        row1Cell1.setCellStyle(headerStyle);
        HSSFCell row1Cell2 = headRow1.createCell(1);
        row1Cell2.setCellValue("");
        HSSFCell row1Cell3 = headRow1.createCell(2);
        row1Cell3.setCellValue("");
        HSSFCell row1Cell4 = headRow1.createCell(36);
        row1Cell4.setCellValue("招生方式为统一招生时必填");
        row1Cell4.setCellStyle(hssfCellStyle2);
        HSSFCell row1Cell5 = headRow1.createCell(39);
        row1Cell5.setCellValue("联招合作学生为必填");
        row1Cell5.setCellStyle(hssfCellStyle2);
        HSSFCell row1Cell6 = headRow1.createCell(41);
        row1Cell6.setCellValue("校外教学点的学生必填");
        row1Cell6.setCellStyle(hssfCellStyle2);
        HSSFCell row1Cell7 = headRow1.createCell(42);
        row1Cell7.setCellValue("学生信息选填项");
        row1Cell7.setCellStyle(cellStyle2);
        HSSFCell row1Cell8 = headRow1.createCell(43);
        row1Cell8.setCellStyle(cellStyle2);
        row1Cell8.setCellValue("学生家庭成员及监护人信息为选填项（成员1和成员2信息可以都不填写）。若填写成员1或成员2信息时蓝色字体的4项信息同时为必填项，黑色字体为选填项");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 47));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 4));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 5, 21));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 22, 35));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 36, 38));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 39, 40));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 43, 47));
        HSSFRow row1 = sheet.createRow(2);
        HSSFCell row1cell0 = row1.createCell(0);
        row1cell0.setCellStyle(headerStyle);
        row1cell0.setCellValue("姓名");
        HSSFCell row1cell1 = row1.createCell(1);
        row1cell1.setCellStyle(headerStyle);
        row1cell1.setCellValue("性别");
        HSSFCell row1cell2 = row1.createCell(2);
        row1cell2.setCellStyle(headerStyle);
        row1cell2.setCellValue("出生日期");
        HSSFCell row1cell3 = row1.createCell(3);
        row1cell3.setCellStyle(hssfCellStyle2);
        row1cell3.setCellValue("身份证件类型");
        HSSFCell row1cell4 = row1.createCell(4);
        row1cell4.setCellStyle(headerStyle);
        row1cell4.setCellValue("身份证件号");
        HSSFCell row1cell5 = row1.createCell(5);
        row1cell5.setCellStyle(hssfCellStyle2);
        row1cell5.setCellValue("姓名拼音");
        HSSFCell row1cell6 = row1.createCell(6);
        row1cell6.setCellStyle(headerStyle);
        row1cell6.setCellValue("班级名称");
        HSSFCell row1cell7 = row1.createCell(7);
        row1cell7.setCellStyle(headerStyle);
        row1cell7.setCellValue("学号");
        HSSFCell row1cell8 = row1.createCell(8);
        row1cell8.setCellStyle(hssfCellStyle2);
        row1cell8.setCellValue("学生类别");
        HSSFCell row1cell9 = row1.createCell(9);
        row1cell9.setCellStyle(hssfCellStyle2);
        row1cell9.setCellValue("学习形式");
        HSSFCell row1cell10 = row1.createCell(10);
        row1cell10.setCellStyle(hssfCellStyle2);
        row1cell10.setCellValue("入学方式");
        HSSFCell row1cell11 = row1.createCell(11);
        row1cell11.setCellStyle(hssfCellStyle2);
        row1cell11.setCellValue("就读方式");
        HSSFCell row1cell12 = row1.createCell(12);
        row1cell12.setCellStyle(hssfCellStyle2);
        row1cell12.setCellValue("国籍/地区");
        HSSFCell row1cell13 = row1.createCell(13);
        row1cell13.setCellStyle(hssfCellStyle2);
        row1cell13.setCellValue("港澳台侨外");
        HSSFCell row1cell14 = row1.createCell(14);
        row1cell14.setCellStyle(hssfCellStyle2);
        row1cell14.setCellValue("婚姻状况");
        HSSFCell row1cell15 = row1.createCell(15);
        row1cell15.setCellStyle(hssfCellStyle2);
        row1cell15.setCellValue("乘火车区间");
        HSSFCell row1cell16 = row1.createCell(16);
        row1cell16.setCellStyle(hssfCellStyle2);
        row1cell16.setCellValue("是否随迁子女");
        HSSFCell row1cell17 = row1.createCell(17);
        row1cell17.setCellStyle(hssfCellStyle2);
        row1cell17.setCellValue("生源地行政区划码");
        HSSFCell row1cell18 = row1.createCell(18);
        row1cell18.setCellStyle(hssfCellStyle2);
        row1cell18.setCellValue("出生地行政区划码");
        HSSFCell row1cell19 = row1.createCell(19);
        row1cell19.setCellStyle(hssfCellStyle2);
        row1cell19.setCellValue("籍贯地行政区划码");
        HSSFCell row1cell20 = row1.createCell(20);
        row1cell20.setCellStyle(hssfCellStyle2);
        row1cell20.setCellValue("户口所在地区县以下详细地址");
        HSSFCell row1cell21 = row1.createCell(21);
        row1cell21.setCellStyle(hssfCellStyle2);
        row1cell21.setCellValue("所属派出所");
        HSSFCell row1cell22 = row1.createCell(22);
        row1cell22.setCellStyle(hssfCellStyle2);
        row1cell22.setCellValue("户口所在地行政区划码");
        HSSFCell row1cell23 = row1.createCell(23);
        row1cell23.setCellStyle(hssfCellStyle2);
        row1cell23.setCellValue("户口性质");
        HSSFCell row1cell24 = row1.createCell(24);
        row1cell24.setCellStyle(hssfCellStyle2);
        row1cell24.setCellValue("学生居住地类型");
        HSSFCell row1cell25 = row1.createCell(25);
        row1cell25.setCellStyle(hssfCellStyle2);
        row1cell25.setCellValue("入学年月(例：201802)");
        HSSFCell row1cell26 = row1.createCell(26);
        row1cell26.setCellStyle(hssfCellStyle2);
        row1cell26.setCellValue("专业简称");
        HSSFCell row1cell27 = row1.createCell(27);
        row1cell27.setCellStyle(hssfCellStyle2);
        row1cell27.setCellValue("学制");
        HSSFCell row1cell28 = row1.createCell(28);
        row1cell28.setCellStyle(hssfCellStyle2);
        row1cell28.setCellValue("民族");
        HSSFCell row1cell29 = row1.createCell(29);
        row1cell29.setCellStyle(hssfCellStyle2);
        row1cell29.setCellValue("政治面貌");
        HSSFCell row1cell30 = row1.createCell(30);
        row1cell30.setCellStyle(hssfCellStyle2);
        row1cell30.setCellValue("健康状况");
        HSSFCell row1cell31 = row1.createCell(31);
        row1cell31.setCellStyle(hssfCellStyle2);
        row1cell31.setCellValue("学生来源");
        HSSFCell row1cell32 = row1.createCell(32);
        row1cell32.setCellStyle(hssfCellStyle2);
        row1cell32.setCellValue("招生对象");
        HSSFCell row1cell33 = row1.createCell(33);
        row1cell33.setCellStyle(hssfCellStyle2);
        row1cell33.setCellValue("联系电话");
        HSSFCell row1cell34 = row1.createCell(34);
        row1cell34.setCellStyle(hssfCellStyle2);
        row1cell34.setCellValue("招生方式");
        HSSFCell row1cell35 = row1.createCell(35);
        row1cell35.setCellStyle(hssfCellStyle2);
        row1cell35.setCellValue("联招合作类型");
        HSSFCell row1cell36 = row1.createCell(36);
        row1cell36.setCellStyle(hssfCellStyle2);
        row1cell36.setCellValue("准考证号");
        HSSFCell row1cell37 = row1.createCell(37);
        row1cell37.setCellStyle(hssfCellStyle2);
        row1cell37.setCellValue("考生号");
        HSSFCell row1cell38 = row1.createCell(38);
        row1cell38.setCellStyle(hssfCellStyle2);
        row1cell38.setCellValue("考试总分");
        HSSFCell row1cell39 = row1.createCell(39);
        row1cell39.setCellStyle(hssfCellStyle2);
        row1cell39.setCellValue("联招合作办学形式");
        HSSFCell row1cell40 = row1.createCell(40);
        row1cell40.setCellStyle(hssfCellStyle2);
        row1cell40.setCellValue("联招合作学校代码");
        HSSFCell row1cell41 = row1.createCell(41);
        row1cell41.setCellStyle(hssfCellStyle2);
        row1cell41.setCellValue("校外教学点");
        HSSFCell row1cell42 = row1.createCell(42);
        row1cell42.setCellStyle(hssfCellStyle2);
        row1cell42.setCellValue("分段培养方式");
        HSSFCell row1cell43 = row1.createCell(43);
        row1cell43.setCellStyle(hssfCellStyle2);
        row1cell43.setCellValue("成员1姓名");
        HSSFCell row1cell44 = row1.createCell(44);
        row1cell44.setCellStyle(hssfCellStyle2);
        row1cell44.setCellValue("成员1关系");
        HSSFCell row1cell45 = row1.createCell(45);
        row1cell45.setCellStyle(hssfCellStyle2);
        row1cell45.setCellValue("成员1是否监护人");
        HSSFCell row1cell46 = row1.createCell(46);
        row1cell46.setCellStyle(hssfCellStyle2);
        row1cell46.setCellValue("成员1联系电话");
        HSSFCell row1cell47 = row1.createCell(47);
        row1cell47.setCellStyle(hssfCellStyle2);
        row1cell47.setCellValue("毕业学校（初中）");

        List<Select2> sexs = commonService.getSysDict("XB", "");
        demo(sheet2, sexs, 0);
        setDataValidation(sheet, "Sheet3!$A$1:$A$" + sexs.size(), 3, 65535, 1, 1);

        List<Select2> sfzjlx = commonService.getSysDict("SFZJLX", "");
        demo(sheet2, sfzjlx, 1);
        setDataValidation(sheet, "Sheet3!$B$1:$B$" + sfzjlx.size(), 3, 65535, 3, 3);

        List<ClassBean> classList = classService.getClassList(new ClassBean());
        for (int i = 0; i < classList.size(); i++) {
            HSSFRow row = sheet2.getRow(i);
            if (row == null) {
                row = sheet2.createRow(i);
            }
            row.createCell(2).setCellValue(classList.get(i).getClassName());
        }
        setDataValidation(sheet, "Sheet3!$C$1:$C$" + classList.size(), 3, 65535, 6, 6);

        List<Select2> xslx = commonService.getSysDict("XSLX", "");
        demo(sheet2, xslx, 3);
        setDataValidation(sheet, "Sheet3!$D$1:$D$" + xslx.size(), 3, 65535, 8, 8);

        List<Select2> gj = commonService.getSysDict("GJ", "");
        demo(sheet2, gj, 4);
        setDataValidation(sheet, "Sheet3!$E$1:$E$" + gj.size(), 3, 65535, 12, 12);

        List<Select2> gatqb = commonService.getSysDict("GATQB", "");
        demo(sheet2, gatqb, 5);
        setDataValidation(sheet, "Sheet3!$F$1:$F$" + gatqb.size(), 3, 65535, 13, 13);

        List<Select2> hyzk = commonService.getSysDict("HYZK", "");
        demo(sheet2, hyzk, 6);
        setDataValidation(sheet, "Sheet3!$G$1:$G$" + hyzk.size(), 3, 65535, 14, 14);

        List<Select2> hjxz = commonService.getSysDict("HJXZ", "");
        demo(sheet2, hjxz, 7);
        setDataValidation(sheet, "Sheet3!$H$1:$H$" + hjxz.size(), 3, 65535, 23, 23);

        List<Select2> xz = commonService.getSysDict("XZ", "");
        demo(sheet2, xz, 8);
        setDataValidation(sheet, "Sheet3!$I$1:$I$" + xz.size(), 3, 65535, 27, 27);

        List<Select2> mz = commonService.getSysDict("MZ", "");
        demo(sheet2, mz, 9);
        setDataValidation(sheet, "Sheet3!$J$1:$J$" + mz.size(), 3, 65535, 28, 28);

        List<Select2> zzmm = commonService.getSysDict("ZZMM", "");
        demo(sheet2, zzmm, 10);
        setDataValidation(sheet, "Sheet3!$K$1:$K$" + zzmm.size(), 3, 65535, 29, 29);

        List<Select2> sylx = commonService.getSysDict("XSLY", "");
        demo(sheet2, sylx, 11);
        setDataValidation(sheet, "Sheet3!$L$1:$L$" + sylx.size(), 3, 65535, 31, 31);


        HSSFCellStyle cellStyle5 = wb.createCellStyle();
        cellStyle5.setBorderLeft(BorderStyle.THIN);//左边框
        cellStyle5.setBorderTop(BorderStyle.THIN);//上边框
        cellStyle5.setBorderRight(BorderStyle.THIN);//右边框
        cellStyle5.setBorderBottom(BorderStyle.THIN); //下边框
        cellStyle5.setDataFormat(wb.createDataFormat().getFormat("@"));
        for (int i = 0; i < 48; i++) {
            sheet.setDefaultColumnStyle(i, cellStyle5);
        }
        HSSFCellStyle cellStyle7 = wb.createCellStyle();
        cellStyle7.setFillBackgroundColor(HSSFColor.GREY_50_PERCENT.index);
        row1.setRowStyle(cellStyle7);
        return wb;
    }

    private void demo(HSSFSheet sheet, List<Select2> data, int col) {
        for (int i = 0; i < data.size(); i++) {
            HSSFRow row = sheet.getRow(i);
            if (row == null) {
                row = sheet.createRow(i);
            }
            row.createCell(col).setCellValue(data.get(i).getText());
        }
    }

    @Override
    public Student getStudentByCandidateNumber(String candidateNumber) {
        return studentDao.getStudentByCandidateNumber(candidateNumber);
    }

    @Override
    public Student getStudentByStudentNumber(String studentNumber) {
        return studentDao.getStudentByStudentNumber(studentNumber);
    }

    @Autowired
    private CommonService commonService;
    @Autowired
    private MajorService majorService;
    @Autowired
    private ClassService classService;

    private static void setDataValidation(HSSFSheet sheet, String strFormula, int firstRow, int endRow, int firstCol, int endCol) {
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        DVConstraint constraint = DVConstraint.createFormulaListConstraint(strFormula);//add
        HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);//add
        dataValidation.createErrorBox("Error", "Error");
        dataValidation.createPromptBox("", null);
        sheet.addValidationData(dataValidation);
    }

    public static void setHSSFStringValidation(HSSFSheet sheet, int firstRow, int endRow, int firstCol, int endCol) {
        // 加载下拉列表内容
        DVConstraint constraint = DVConstraint.createCustomFormulaConstraint("");
        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        sheet.addValidationData(hssfDataValidation);
    }

    public static void setHSSFValidation(HSSFSheet sheet, String[] textlist, int firstRow, int endRow, int firstCol, int endCol) {
        // 加载下拉列表内容
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(textlist);
        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        sheet.addValidationData(hssfDataValidation);
    }

    /**
     * 设置单元格上提示
     *
     * @param sheet         要设置的sheet.
     * @param promptTitle   标题
     * @param promptContent 内容
     * @param firstRow      开始行
     * @param endRow        结束行
     * @param firstCol      开始列
     * @param endCol        结束列
     * @return 设置好的sheet.
     */
    public static void setHSSFPrompt(HSSFSheet sheet, String promptTitle, String promptContent, int firstRow, int endRow, int firstCol, int endCol) {
        // 构造constraint对象
        DVConstraint constraint = DVConstraint.createCustomFormulaConstraint("BB1");
        // 四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        hssfDataValidation.createPromptBox(promptTitle, promptContent);
        sheet.addValidationData(hssfDataValidation);
    }

    @Override
    public List<Student> exportStudent(Map<String, Object> param) {
        return studentDao.exportStudent(param);
    }

    @Override
    public Student getStudentByIdNoClassId(String studentId) {
        return studentDao.getStudentByIdNoClassId(studentId);
    }

    @Override
    public List<Map<String, Object>> checkStudentById(String studentId) {
        return  studentDao.checkStudentById(studentId);
    }

    @Override
    public String getStudentNumByClassId(String classId) {
        return studentDao.getStudentNumByClassId(classId);
    }
}
