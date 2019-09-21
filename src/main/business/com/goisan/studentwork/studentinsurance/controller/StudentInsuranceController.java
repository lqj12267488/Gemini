package com.goisan.studentwork.studentinsurance.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.studentwork.studentinsurance.bean.StudentInsurance;
import com.goisan.studentwork.studentinsurance.service.StudentInsuranceService;
import com.goisan.system.bean.Student;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created  By hanjie ON 2019/8/28
 */

@Controller
public class StudentInsuranceController {

    @Autowired
    private StudentInsuranceService studentInsuranceService;

    @Autowired
    private StudentService studentService;

    @RequestMapping("/studentInsurance/list")
    public ModelAndView list(String insuranceType){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("insuranceType",insuranceType);
        modelAndView.setViewName("/business/studentwork/studentinsurance/StudentInsuranceList");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/studentInsurance/getStudentInsuranceList")
    public Map<String,Object> getStudentInsuranceList(StudentInsurance studentInsurance,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> insurances = new HashMap();
        List<StudentInsurance> list = studentInsuranceService.getStudentInsuranceList(studentInsurance);
        PageInfo<List<Student>> info = new PageInfo(list);
        insurances.put("draw", draw);
        insurances.put("recordsTotal", info.getTotal());
        insurances.put("recordsFiltered", info.getTotal());
        insurances.put("data", list);
        return insurances;
    }

    @RequestMapping("/studentInsurance/editStudentInsuranceList")
    public ModelAndView editStudentInsuranceList(StudentInsurance studentInsurance){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("insuranceType",studentInsurance.getInsuranceType());
        if (!"".equals(studentInsurance.getId())&&null!=studentInsurance.getId()){
            StudentInsurance stuInsuranceEdit = studentInsuranceService.getStudentInsuranceById(studentInsurance.getId());
            modelAndView.addObject("head", "修改");
            modelAndView.addObject("stuInsuranceEdit", stuInsuranceEdit);
        }else {
            modelAndView.addObject("head", "新增");
        }
        modelAndView.setViewName("/business/studentwork/studentinsurance/editStudentInsuranceList");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/studentInsurance/saveStudentInsurance")
    public Message saveStudentInsurance(StudentInsurance studentInsurance){
        if (!"".equals(studentInsurance.getId())&&null!=studentInsurance.getId()){
            studentInsuranceService.updStudentInsurance(studentInsurance);
            return new Message(1,"修改成功",null);
        }else {
            studentInsuranceService.insertStudentInsurance(studentInsurance);
            return new Message(1,"保存成功",null);
        }
    }

    @RequestMapping("/studentInsurance/importStudentInsurance")
    public ModelAndView importStudentInsurance(String insuranceType){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/business/studentwork/studentinsurance/importStudentInsurance");
        modelAndView.addObject("insuranceType",insuranceType);
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/studentInsurance/delStudentInsurance")
    public Message delStudentInsurance(StudentInsurance studentInsurance){
        studentInsuranceService.delStudentInsurance(studentInsurance);
        return new Message(1,"删除成功","success");
    }


//    导出以及导出模板  下载导出模板
    @RequestMapping("/studentInsurance/exportStudentInsurance")
    public void exportStudentInsurance(HttpServletRequest request, HttpServletResponse response) {
        //一个Excel文件对应于一个workbook(HSSFWorkbook)
        HSSFWorkbook wb = new HSSFWorkbook();
        String insuranceType = request.getParameter("insuranceType");
        String export = request.getParameter("export");
        HSSFSheet sheet;
        String fileName;
        if ("1".equals(insuranceType)) {
//   创建sheet
            sheet = wb.createSheet("新疆现代职业技术学院社保缴费名单");
            fileName = "新疆现代职业技术学院社保缴费名单";
        } else {

            fileName = "新疆现代职业技术学院商业保险缴费名单";  sheet = wb.createSheet("新疆现代职业技术学院商业保险缴费名单");
        }
//        设置字体
        HSSFFont fontHead = this.createFont(wb, 14, "宋体", false);
        HSSFFont font11 = this.createFont(wb, 11, "宋体", false);
        HSSFFont font12 = this.createFont(wb, 12, "宋体", false);
//      设置样式
        HSSFCellStyle styleHead = this.createStyle(wb, fontHead);
        HSSFCellStyle style11 = this.createBorderStyle(wb, font11);
        HSSFCellStyle style12 = this.createBorderStyle(wb, font12);
//        设置合并单元格
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 9));
// 设置 默认样式，单元格宽度
       this.setColumnDefaultStyleAndWidth(sheet,style12);

//      createRow 创建row
        HSSFRow row0 = sheet.createRow(0);
        row0.setHeightInPoints(28);
        this.createCellWithStyleAndValue(row0,0,fileName,styleHead);

        HSSFRow row1 = sheet.createRow(1);
        row1.setHeightInPoints(28);
        this.createCellWithStyleAndValue(row1,0,"序号",style11);
        this.createCellWithStyleAndValue(row1,1,"姓名",style11);
        this.createCellWithStyleAndValue(row1,2,"学号",style11);
        this.createCellWithStyleAndValue(row1,3,"性别",style11);
        this.createCellWithStyleAndValue(row1,4,"民族",style11);
        this.createCellWithStyleAndValue(row1,5,"出生日期",style11);
        this.createCellWithStyleAndValue(row1,6,"身份证号",style11);
        this.createCellWithStyleAndValue(row1,7,"班级",style11);
        this.createCellWithStyleAndValue(row1,8,"宿舍号",style11);
        this.createCellWithStyleAndValue(row1,9,"生源地",style11);

//        导出数据
        if ("1".equals(export)){
            StudentInsurance query = new StudentInsurance();
            query.setInsuranceType(insuranceType);
            List<StudentInsurance> studentInsuranceList = studentInsuranceService.getStudentInsuranceList(query);
            int rowCount = 2;
            int index = 1;
            for (StudentInsurance studentInsurance:studentInsuranceList){

                HSSFRow row = sheet.createRow(rowCount);
                row.setHeightInPoints(28);
                this.createCellWithStyleAndValue(row,0,String.valueOf(index),style12);
                this.createCellWithStyleAndValue(row,1,studentInsurance.getName(),style12);
                this.createCellWithStyleAndValue(row,2,studentInsurance.getStudentNumber(),style12);
                this.createCellWithStyleAndValue(row,3,studentInsurance.getSexShow(),style12);
                this.createCellWithStyleAndValue(row,4,studentInsurance.getNationShow(),style12);
                this.createCellWithStyleAndValue(row,5,studentInsurance.getBirthday(),style12);
                this.createCellWithStyleAndValue(row,6,studentInsurance.getIdcard(),style12);
                this.createCellWithStyleAndValue(row,7,studentInsurance.getClassShow(),style12);
                this.createCellWithStyleAndValue(row,8,studentInsurance.getDormName(),style12);
                this.createCellWithStyleAndValue(row,9,studentInsurance.getStuSourceAddr(),style12);
                rowCount++;
                index++;
            }
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    (fileName+".xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.close();
                }
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
//导入
    @ResponseBody
    @RequestMapping("/studentInsurance/importInsurance")
    public Message importInsurance(@RequestParam(value = "file", required = false)CommonsMultipartFile file,String insuranceType) {
        int count=3;
        int rightCount = 0 ;
        int errCount = 0 ;
        StringBuilder sb = new StringBuilder();
        try {
//            创建HSSFWorkbook
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
//
            Boolean checkExcel = this.checkExcel(workbook, insuranceType);
            if (!checkExcel){
                return new Message(1,"请检查导入模板",null);
            }
//            获取sheet
            HSSFSheet sheet = workbook.getSheetAt(0);

            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
//                获取行
                HSSFRow row = sheet.getRow(i);
//                获取该行单元格：row.getCell(6)
                String studentId = row.getCell(6).toString();
//                根据studentId，检查是否有此学生
                if (null==studentId &&"".equals(studentId)){
                       sb.append("第");
                       sb.append(count);
                       sb.append("行 ");
                        errCount++;
                }else {
                    Student student = studentService.getStudentById(studentId);
//                    如果没有该学生
                    if (null==student){
                        sb.append("第");
                        sb.append(count);
                        sb.append("行 ");
                        errCount++;
                    }else {
//                        根据studentId插入或者是更新
                        StudentInsurance si = new StudentInsurance();
                        si.setInsuranceType(insuranceType);
                        si.setStudentId(studentId);
                        if (null!=row.getCell(8)) {
                            si.setDormName(row.getCell(8).toString());
                        }
                        studentInsuranceService.saveStudentInsurance(si);
                        rightCount++;
                    }
                }
                count++;
            }
//          检查模板
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (errCount==0) {
            return new Message(1, "成功导入" + rightCount + "条", null);
        }else {
            return new Message(0,"成功导入"+ rightCount + "条\n 失败"+errCount+"条："+sb.toString()+"身份证号错误",null);
        }
    }

// static
    private HSSFFont createFont ( HSSFWorkbook wb,int fontSize,String fontName,Boolean bold){
        HSSFFont font = wb.createFont();
//       大小
        font.setFontHeightInPoints((short) fontSize);
//        设置字体名
        font.setFontName(fontName);
//        是否加粗
        font.setBold(bold);
        return font;
    }

    private HSSFCellStyle createStyle (HSSFWorkbook wb,HSSFFont font){
//        HSSFCellStyle 设置样式
        HSSFCellStyle cellStyle = wb.createCellStyle();
//        设置字体
        cellStyle.setFont(font);
//        设置是否自动换行
        cellStyle.setWrapText(true);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        return cellStyle;
    }

    private HSSFCellStyle createBorderStyle (HSSFWorkbook wb,HSSFFont font){
        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setFont(font);
        cellStyle.setWrapText(true);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
//        设置边框
        cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        return cellStyle;
    }

    private void createCellWithStyleAndValue (HSSFRow row,Integer col,String value,HSSFCellStyle style){
//       createCell生成单元格
        HSSFCell cell = row.createCell(col);
//       setCellValue 设置单元格的值
        cell.setCellValue(value);
//        设置 单元格样式
        cell.setCellStyle(style);
    }

    private void setColumnDefaultStyleAndWidth(HSSFSheet sheet,HSSFCellStyle style){

//        设置setColumnWidth 宽度
        sheet.setColumnWidth(0,5* 256);
        sheet.setColumnWidth(1,33* 256);
        sheet.setColumnWidth(2,15* 256);
        sheet.setColumnWidth(3,5* 256);
        sheet.setColumnWidth(4,11* 256);
        sheet.setColumnWidth(5,13* 256);
        sheet.setColumnWidth(6,22* 256);
        sheet.setColumnWidth(7,30* 256);
        sheet.setColumnWidth(8,9* 256);
        sheet.setColumnWidth(9,13* 256);
//        设置高度
        sheet.setDefaultRowHeightInPoints(28);
        sheet.setDefaultColumnStyle(0,style);
        sheet.setDefaultColumnStyle(1,style);
        sheet.setDefaultColumnStyle(2,style);
        sheet.setDefaultColumnStyle(3,style);
        sheet.setDefaultColumnStyle(4,style);
        sheet.setDefaultColumnStyle(5,style);
        sheet.setDefaultColumnStyle(6,style);
        sheet.setDefaultColumnStyle(7,style);
        sheet.setDefaultColumnStyle(8,style);
        sheet.setDefaultColumnStyle(9,style);
    }

    private Boolean checkExcel(HSSFWorkbook workbook,String insuranceType){
        if ("1".equals(insuranceType)){
            return workbook.getSheetName(0).contains("新疆现代职业技术学院社保缴费名单");
        }else {
            return workbook.getSheetName(0).contains("新疆现代职业技术学院商业保险缴费名单");
        }
    }
}
