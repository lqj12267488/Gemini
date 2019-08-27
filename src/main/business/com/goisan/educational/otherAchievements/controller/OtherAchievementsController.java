package com.goisan.educational.otherAchievements.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.course.bean.Course;
import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.exam.bean.ExamStudent;
import com.goisan.educational.exam.dao.ExamDao;
import com.goisan.educational.exam.service.ExamService;
import com.goisan.educational.otherAchievements.bean.OtherAchievements;
import com.goisan.educational.otherAchievements.bean.OtherAchievementsDetails;
import com.goisan.educational.otherAchievements.service.OtherAchievementsDetailsService;
import com.goisan.educational.otherAchievements.service.OtherAchievementsService;

import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.educational.score.service.ScoreMakeupService;
import com.goisan.system.bean.EmpDeptRelation;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/otherAchievements")
public class OtherAchievementsController {


    @Autowired
    private OtherAchievementsService otherAchievementsService;

    @Autowired
    private OtherAchievementsDetailsService otherAchievementsDetailsService;


    /**
     * create by hlx
     * 其他成绩列表页面
     * @return
     */
    @RequestMapping("/otherAchievementsList")
    public ModelAndView resultInquiryList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/educational/otherAchievements/otherAchievementsList");
        return mv;
    }


    /**
     * create by  hlx
     * 其他成绩列表数据
     * @param otherAchievements
     * @return
     */


    @ResponseBody
    @RequestMapping("/getOtherAchievementsList")
    public Map<String, Object> getScoreExamList1(OtherAchievements otherAchievements, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> OtherAchievementss = new HashMap();
        List<OtherAchievements> otherAchievementsList = otherAchievementsService.getOtherAchievementsList(otherAchievements);
        PageInfo<List<OtherAchievements>> info = new PageInfo(otherAchievementsList);
        OtherAchievementss.put("draw", draw);
        OtherAchievementss.put("recordsTotal", info.getTotal());
        OtherAchievementss.put("recordsFiltered", info.getTotal());
        OtherAchievementss.put("data", otherAchievementsList);
        return OtherAchievementss;
    }



    /**
     * 新增其他考试基础
     * @return
     */
    @ResponseBody
    @RequestMapping("/addOtherAchievements")
    public ModelAndView addExamTopicInstall() {
        ModelAndView mv = new ModelAndView("/business/educational/otherAchievements/addOtherAchievements");
        mv.addObject("head", "新增其他考试");
        return mv;
    }




    /**
     * 新增和修改保存
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/saveOtherAchievements")
    public Message saveexamTopic(OtherAchievements otherAchievements){
        if(otherAchievements.getId() == null || otherAchievements.equals("") || otherAchievements.getId() == ""){
            otherAchievements.setCreator(CommonUtil.getPersonId());
            otherAchievements.setCreateDept(CommonUtil.getDefaultDept());
            otherAchievementsService.saveOtherAchievements(otherAchievements);
            return new Message(1, "新增成功！", null);
        }else{
            otherAchievements.setChanger(CommonUtil.getPersonId());
            otherAchievements.setChangeDept(CommonUtil.getDefaultDept());
            otherAchievementsService.updateOtherAchievements(otherAchievements);
            return new Message(1, "修改成功！", null);
        }
    }


    /**
     * 录入成绩导向 根据otherAchievementsId 导向
     * @param
     * @return
     */
    @RequestMapping("/toOtherAchievementsDetails")
    public ModelAndView toOtherAchievementsDetails(String otherAchievementsId,String courseId,String semesterId,String classId){
        ModelAndView mv= new ModelAndView();
        mv.addObject("otherAchievementsId",otherAchievementsId);
        mv.addObject("courseId",courseId);
        mv.addObject("semesterId",semesterId);
        mv.addObject("classId",classId);
        mv.setViewName("/business/educational/otherAchievements/toOtherAchievementsDatils");
        System.err.println(otherAchievementsId);
        return mv;
    }

    @Autowired
    private ExamDao examDao;
    @Resource
    private CommonService commonService;
    /**下载模板*/
    @ResponseBody
    @RequestMapping("/toCheckStu")
    public void exportMakeupScore(HttpServletRequest request, HttpServletResponse response) {

        String courseId = request.getParameter("courseId");
        String semesterId = request.getParameter("semesterId");
        String classId = request.getParameter("classId");

    if (classId != null && !"".equals(classId)) {
            List<Select2> termType = commonService.getSysDict("XQ", "");
            ExamStudent examStudent = new ExamStudent();
            examStudent.setClassId(classId);
            //examStudent.setTerm(semesterId);
            //examStudent.setCourseId(courseId);
            List<ExamStudent> studentList = examDao.getExamStudentList(examStudent);
            String fileName;
            HSSFWorkbook wb = new HSSFWorkbook();
            if(studentList != null && studentList.size() > 0){
                String kccjList = "";
                HSSFSheet sheet;
                //创建HSSFSheet对象
                sheet = wb.createSheet("其他成绩单");
                fileName = "其他成绩单.xls";
                sheet.setColumnWidth(0, 6000);
                sheet.setColumnWidth(1, 6000);
                sheet.setColumnWidth(2, 6000);
                sheet.setColumnWidth(3, 6000);
                sheet.setColumnWidth(4, 6000);
                sheet.setColumnWidth(5, 6000);
                sheet.setColumnWidth(6, 6000);
                //创建HSSFRow对象
                int tmp = 0;
                HSSFRow row2 = sheet.createRow(tmp);
                row2.createCell(0).setCellValue("学号");
                row2.createCell(1).setCellValue("学生姓名");
                row2.createCell(2).setCellValue("A(满分10分)");
                row2.createCell(3).setCellValue("B(满分10分)");
                row2.createCell(4).setCellValue("C(满分10分)");
                row2.createCell(5).setCellValue("D(满分10分)");
                row2.createCell(6).setCellValue("总评");
                tmp++;
                int i = 1;
                for (ExamStudent es : studentList) {
                    HSSFRow row = sheet.createRow(tmp);
                    String termName = "";
                    for (Select2 status : termType) {
                            if (status.getId().equals(semesterId)) {
                                termName = status.getText();
                                break;
                            }
                        }
                    row.createCell(0).setCellValue(es.getStudentId());
                    row.createCell(1).setCellValue(es.getStudentName());
                    row.createCell(2).setCellValue("");
                    row.createCell(4).setCellValue("");
                    row.createCell(5).setCellValue("");
                    row.createCell(6).setCellValue("");
                    tmp++;
                    i++;
                }
                sheet.autoSizeColumn(0);
                sheet.autoSizeColumn(1);
                sheet.autoSizeColumn(2);
                sheet.autoSizeColumn(3);
                sheet.autoSizeColumn(4);
                sheet.autoSizeColumn(5);
                sheet.autoSizeColumn(6);
            } else {
                wb.createSheet("无可导入成绩");
                fileName = "无可导入成绩.xls";
            }
            OutputStream os = null;
            response.setContentType("application/vnd.ms-excel");
            try {
                response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                        (fileName, "utf-8"));
                os = response.getOutputStream();
                wb.write(os);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    os.flush();
                    os.close();
                    wb.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
    }
}
    //导入界面
    @ResponseBody
    @RequestMapping("/otherAchievementsImport")
    public ModelAndView scoreMakeupImport(String otherAchievementsId) {
        if (otherAchievementsId != null && !"".equals(otherAchievementsId)) {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("/business/educational/otherAchievements/otherAchievementsImport");
            mv.addObject("otherAchievementsId", otherAchievementsId);
            return mv;
        }else {
            return null;
        }
    }

    //导入保存
    @ResponseBody
    @RequestMapping("/otherAchievementsImportSave")
    public Message importStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file,String otherAchievementsId) {
        int count = 0;
        HSSFWorkbook workbook = null;
        try {
            workbook = new HSSFWorkbook(file.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        HSSFSheet sheet = workbook.getSheetAt(0);
        int end = sheet.getLastRowNum();
        for (int i = 2; i <= end; i++) {
            try {
                OtherAchievementsDetails otherAchievementsDetails = new OtherAchievementsDetails();
                HSSFRow row = sheet.getRow(i);
                String stuId = row.getCell(0).toString();
                String stuName = (row.getCell(1).toString());
                otherAchievementsDetails.setOtherAchievementsId(otherAchievementsId);
                otherAchievementsDetails.setStudentId(stuId);
                otherAchievementsDetails.setStudentName(stuName);
                otherAchievementsDetails.setOpenFlag("0");
                otherAchievementsDetails.setScoreA(CommonUtil.changeToInteger(row.getCell(2))+"");
                otherAchievementsDetails.setScoreB(CommonUtil.changeToInteger(row.getCell(3))+ "");
                otherAchievementsDetails.setScoreC(CommonUtil.changeToInteger(row.getCell(4))+ "");
                otherAchievementsDetails.setScoreD(CommonUtil.changeToInteger(row.getCell(5))+ "");
                otherAchievementsDetails.setGeneralComment(row.getCell(6).toString());
                int sum=CommonUtil.changeToInteger(row.getCell(2))+CommonUtil.changeToInteger(row.getCell(3))+CommonUtil.changeToInteger(row.getCell(4))+
                        CommonUtil.changeToInteger(row.getCell(5));
                otherAchievementsDetails.setPeacetimeTotal(sum+"");
                otherAchievementsDetails.setCreator(CommonUtil.getPersonId());
                otherAchievementsDetails.setCreateDept(CommonUtil.getDefaultDept());
                CommonUtil.update(otherAchievementsDetails);
                otherAchievementsDetailsService.saveOtherAchievementsDetails(otherAchievementsDetails);
                count++;
            } catch (Exception e) {
                e.printStackTrace();
                String msg = "导入" + count + "条成功，第" + (count + 1) + "条数据异常。导入失败！";
                return new Message(0, msg, null);

            }
        }
        return new Message(1, "共计" + count + "条，导入成功！", null);
    }
    /**
     * 导出
     *
     * @param response
     */
    @RequestMapping("/exportOtherAchievements")
    public void exportTeacherResult(OtherAchievementsDetails otherAchievementsDetails, HttpServletResponse response) {
        String name = "其他成绩单";
        List<OtherAchievementsDetails> otherAchievementsList = otherAchievementsDetailsService.getOtherAchievementsDetailsList(otherAchievementsDetails);
        if (otherAchievementsList.size() != 0) {
            //创建HSSFWorkbook对象
            HSSFWorkbook wb = new HSSFWorkbook();
            //创建HSSFSheet对象
            HSSFSheet sheet = wb.createSheet(name);

            Font valueFont = wb.createFont();
            valueFont.setFontHeightInPoints((short) 12);//字体大小

            HSSFCellStyle valueStyle = wb.createCellStyle();
            HSSFCellStyle cellStyle = wb.createCellStyle();
            int index = 1;

            HSSFRow headRow = sheet.createRow(index);
            HSSFCell headCell0 = headRow.createCell(0);

            headCell0.setCellValue("序号");
            headCell0.setCellStyle(cellStyle);
            //if (Integer.parseInt(scoreImport.getExamTypes()) < 5) {
                HSSFCell headCell11 = headRow.createCell(1);
                headCell11.setCellStyle(cellStyle);
                headCell11.setCellValue("学号");
                HSSFCell headCell1 = headRow.createCell(2);
                headCell1.setCellStyle(cellStyle);
                headCell1.setCellValue("姓名");
                HSSFCell headCell2 = headRow.createCell(3);
                headCell2.setCellStyle(cellStyle);
                headCell2.setCellValue("A(10)");
                HSSFCell headCell3 = headRow.createCell(4);
                headCell3.setCellStyle(cellStyle);
                headCell3.setCellValue("B(10)");
                HSSFCell headCell4 = headRow.createCell(5);
                headCell4.setCellStyle(cellStyle);
                headCell4.setCellValue("C(10)");
                HSSFCell headCell5 = headRow.createCell(6);
                headCell5.setCellStyle(cellStyle);
                headCell5.setCellValue("D(10)");
                HSSFCell headCell6 = headRow.createCell(7);
                headCell6.setCellStyle(cellStyle);
                headCell6.setCellValue("平时合计");
                HSSFCell headCell7 = headRow.createCell(8);
                headCell7.setCellStyle(cellStyle);
                headCell7.setCellValue("总评");
           // }
            for (int i = 0; i < otherAchievementsList.size(); i++) {
                index++;
                HSSFRow row = sheet.createRow(index);
                HSSFCell cell0 = row.createCell(0);
                cell0.setCellStyle(valueStyle);
                cell0.setCellValue(i + 1);

                    HSSFCell cell11 = row.createCell(1);
                    cell11.setCellStyle(valueStyle);
                    cell11.setCellValue(otherAchievementsList.get(i).getStudentNum());
                    HSSFCell cell1 = row.createCell(2);
                    cell1.setCellStyle(valueStyle);
                    cell1.setCellValue(otherAchievementsList.get(i).getStudentName());
                    HSSFCell cell2 = row.createCell(3);
                    cell2.setCellStyle(valueStyle);
                    cell2.setCellValue(otherAchievementsList.get(i).getScoreA());
                    HSSFCell cell3 = row.createCell(4);
                    cell3.setCellStyle(valueStyle);
                    cell3.setCellValue(otherAchievementsList.get(i).getScoreB());
                    HSSFCell cell4 = row.createCell(5);
                    cell4.setCellStyle(valueStyle);
                    cell4.setCellValue(otherAchievementsList.get(i).getScoreC());
                    HSSFCell cell5 = row.createCell(6);
                    cell5.setCellStyle(valueStyle);
                    cell5.setCellValue(otherAchievementsList.get(i).getScoreD());
                    HSSFCell cell6 = row.createCell(7);
                    cell6.setCellStyle(valueStyle);
                    cell6.setCellValue(otherAchievementsList.get(i).getPeacetimeTotal());
                    HSSFCell cell7 = row.createCell(8);
                    cell7.setCellStyle(valueStyle);
                    cell7.setCellValue(otherAchievementsList.get(i).getGeneralComment());
            }

            sheet.setColumnWidth(1, 6000);
            sheet.setColumnWidth(2, 6000);
            sheet.setColumnWidth(3, 6000);
            sheet.setColumnWidth(4, 6000);
            sheet.setColumnWidth(5, 6000);
            sheet.setColumnWidth(6, 6000);
            sheet.setColumnWidth(7, 6000);
            sheet.setColumnWidth(8, 6000);

            OutputStream os = null;
            response.setContentType("application/vnd.ms-excel");
            try {
                response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(name + ".xls", "utf-8"));
                os = response.getOutputStream();
                wb.write(os);
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    os.flush();
                    os.close();
                    wb.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } else {
            HSSFWorkbook wb = new HSSFWorkbook();
            //创建HSSFSheet对象
            HSSFSheet sheet = wb.createSheet("无数据");
            sheet.createRow(0).createCell(0).setCellValue("无数据");
            OutputStream os = null;
            response.setContentType("application/vnd.ms-excel");
            try {
                response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("无数据.xls", "utf-8"));
                os = response.getOutputStream();
                wb.write(os);
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    os.flush();
                    os.close();
                    wb.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
