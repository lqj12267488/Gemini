package com.goisan.educational.otherexamination.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.otherAchievements.bean.OtherAchievements;
import com.goisan.educational.otherAchievements.service.OtherAchievementsService;
import com.goisan.educational.otherexamination.bean.OtherExamination;
import com.goisan.educational.otherexamination.service.OtherExaminationService;
import com.goisan.educational.score.bean.ScoreChange;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.teachingtask.service.TeachingTaskService;
import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.logistics.assets.service.AssetsService;
import com.goisan.system.bean.*;
import com.goisan.system.service.ClassService;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/otherExamination")
public class OtherExaminationController {
    @Autowired
    TeachingTaskService teachingTaskService;
    @Autowired
    OtherExaminationService otherExaminationService;
    @Autowired
    CommonService commonService;
    @Autowired
    OtherAchievementsService otherAchievementsService;
    @Autowired
    ClassService classService;

    @RequestMapping("/otherExamination")
    public ModelAndView otherExamination() {
        /* return new ModelAndView("/business/educational/otherexamination/otherExaminationList");*/
        return new ModelAndView("/business/educational/otherexamination/otherExaminationListNew");
    }

    /**
     * 新增其他考试基础
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/addOtherAchievementsNew")
    public ModelAndView addExamTopicInstall() {
        ModelAndView mv = new ModelAndView("/business/educational/otherexamination/addOtherAchievementsNew");
        mv.addObject("head", "新增其他考试");
        return mv;
    }

    @RequestMapping("/updateOtherAchievementsNew")
    public ModelAndView updateList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/otherexamination/addOtherAchievementsNew");
        mv.addObject("head", "修改其他考试信息");
        OtherAchievements otherAchievements = otherAchievementsService.getOtherAchievementsById(id);
        mv.addObject("examTopic", otherAchievements);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/deleteOtherAchievementsNew")
    public Message deleteOtherAchievementsNew(String id) {
        otherAchievementsService.deleteOtherAchievements(id);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/getOtherExaminationList")
    public Map<String, Object> getOtherExaminationList(OtherExamination otherExamination, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> otherExaminations = new HashMap();
        List<OtherExamination> empList = otherExaminationService.getOtherExaminationList(otherExamination);
        PageInfo<List<Emp>> info = new PageInfo(empList);
        otherExaminations.put("draw", draw);
        otherExaminations.put("recordsTotal", info.getTotal());
        otherExaminations.put("recordsFiltered", info.getTotal());
        otherExaminations.put("data", empList);
        return otherExaminations;

    }

    @RequestMapping("/editScore")
    public ModelAndView addScoreChange(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/otherexamination/otherExaminationImportEdit");
        OtherExamination otherExamination = otherExaminationService.getScoreImportById(id);
        mv.addObject("head", "修改");
        mv.addObject("otherExamination", otherExamination);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/delScore")
    public Message deleteById(String id) {
        otherExaminationService.deleteById(id);
        return new Message(1, "删除成功！", null);
    }


    @RequestMapping("/toOtherExaminationAdd")
    public ModelAndView toOtherExaminationAdd(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/otherexamination/otherExaminationEdit");
        if (id != null && !"".equals(id)) {
            OtherExamination otherExamination = otherExaminationService.getOtherExaminationById(id);
            mv.addObject("data", otherExamination);
            mv.addObject("head", "修改");
        } else {
            mv.addObject("head", "新增");
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/saveScore")
    public Message saveScore(HttpServletRequest request) {
        return otherExaminationService.saveScoreCon(request);
    }

    @ResponseBody
    @RequestMapping("/changeOpenFlag")
    public Message changeOpenFlag(String id) {
        return otherExaminationService.openScore(id);
    }

    @RequestMapping("/import")
    public ModelAndView scoreMakeupList(String id, String term, String examName, String course, String examType) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", id);
        mv.addObject("term", term);
        mv.addObject("course", course);
        mv.addObject("examName", examName);
        mv.addObject("examType", examType);
        mv.setViewName("/business/educational/otherexamination/otherExaminationImport");
        return mv;
    }

    @RequestMapping("/importOtherExam")
    public ModelAndView importOtherExam(String id, String trainingLevel, String majorDirection, String term, String curriculum, String classId, String departmentId, String majorCode, String semester) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", id);
        mv.addObject("trainingLevel", trainingLevel);
        mv.addObject("majorDirection", majorDirection);
        mv.addObject("term", term);
        mv.addObject("departmentId", departmentId);
        mv.addObject("curriculum", curriculum);
        mv.addObject("classId", classId);
        mv.addObject("majorCode", majorCode);
        mv.addObject("semester", semester);
        mv.setViewName("/business/educational/otherexamination/otherExaminationImportNew");
        return mv;
    }

    @RequestMapping("/getScoreImport")
    public Map<String, List> getScoreImport(OtherExamination otherExamination) {
        otherExamination.setCreateDept(CommonUtil.getDefaultDept());
        return CommonUtil.tableMap(otherExaminationService.getScoreImport(otherExamination));

    }


    @RequestMapping("deleteOtherExamination")
    public Message deleteOtherExamination(String id) {
        otherExaminationService.deleteOtherExamination(id);
        return new Message(1, "删除成功！", null);
    }


    @RequestMapping("saveOtherExamination")
    public Message saveOtherExamination(OtherExamination otherExamination) {
        if (otherExamination.getId() != null && !"".equals(otherExamination.getId())) {
            otherExamination.setChanger(CommonUtil.getPersonId());
            otherExamination.setChangeDept(CommonUtil.getDefaultDept());
            otherExaminationService.updateOtherExamination(otherExamination);
            return new Message(0, "修改成功！", null);
        } else {
            otherExamination.setId(CommonUtil.getUUID());
            otherExamination.setCreator(CommonUtil.getPersonId());
            otherExamination.setCreateDept(CommonUtil.getDefaultDept());
            otherExaminationService.saveOtherExamination(otherExamination);
            return new Message(0, "新增成功！", null);
        }
    }

    @RequestMapping("saveOtherExaminationImport")
    public Message saveOtherExaminationImport(OtherExamination otherExamination) {
        otherExamination.setChanger(CommonUtil.getPersonId());
        otherExamination.setChangeDept(CommonUtil.getDefaultDept());
        otherExaminationService.updateOtherExaminationImport(otherExamination);
        return new Message(0, "修改成功！", null);
    }


    /**
     * 导入页面
     *
     * @return
     */
    @RequestMapping("/otherExaminationImport")
    public ModelAndView toImportOtherExamination(String scoreExamId, String term, String course, String examName, String examType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/otherexamination/otherExaminationToImport");
        mv.addObject("scoreExamId", scoreExamId);
        mv.addObject("term", term);
        mv.addObject("course", course);
        mv.addObject("examName", examName);
        mv.addObject("examType", examType);
        return mv;
    }

    @RequestMapping("/otherExaminationImportNew")
    public ModelAndView toImportOtherExaminationNew(String id, String trainingLevel, String majorDirection, String term, String curriculum, String classId, String semester, String departmentId, String majorCode) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/otherexamination/otherExaminationToImportNew");
        mv.addObject("id", id);
        mv.addObject("term", term);
        mv.addObject("trainingLevel", trainingLevel);
        mv.addObject("majorDirection", majorDirection);
        mv.addObject("curriculum", curriculum);
        mv.addObject("classId", classId);
        mv.addObject("semester", semester);
        mv.addObject("departmentId", departmentId);
        mv.addObject("majorCode", majorCode);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/importOtherExamination")
    public Message importOtherExamination(@RequestParam(value = "file", required = false) CommonsMultipartFile file, HttpServletRequest request) {
        String scoreExamId = request.getParameter("scoreExamId");
        String term = request.getParameter("term");
        String course = request.getParameter("course");
        String examName = request.getParameter("examName");
        String examType = request.getParameter("examType");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        int count = 0;
        try {
            HSSFWorkbook workbook1 = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook1.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                if (null == row && count == 0) {
                    return new Message(0, "无数据，导入失败！", "error");
                } else if (null == row) {
                    return new Message(1, "共计" + count + "条，导入成功！", "success");
                }
                ScoreImport project = new ScoreImport();
                String idcard = row.getCell(1).toString();
                project.setStudentId(idcard);
                HSSFCell hssef2 = row.getCell(3);
                hssef2.setCellType(hssef2.CELL_TYPE_STRING);
                project.setScoreExamId(scoreExamId);
                project.setTermId(term);
                project.setCourseId(course);
                project.setScoreExamName(examName);
                project.setExamMethod(examType);
                project.setTeachingTeacherId(teachingTaskService.getPersonIdByStaffId(hssef2.toString() + ""));
                String classId = commonService.getClassIdByStudentId(idcard);
                project.setClassId(classId);
                project.setScore(row.getCell(4).toString());
                project.setStudentName(commonService.getStudentNameByIdCard(idcard));
                String s = commonService.getClassByClassId(classId).getDepartmentsId();
                project.setDepartmentsId(s);
                project.setMajorCode(commonService.getClassByClassId(classId).getMajorCode());
                project.setCreator(CommonUtil.getPersonId());
                project.setCreateDept(CommonUtil.getDefaultDept());
                project.setId(CommonUtil.getUUID());
                otherExaminationService.insertScoreImportByOtherExamination(project);
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "导入" + count + "条成功，第" + (count + 1) + "条数据异常。导入失败！";
            return new Message(0, msg, null);
        }

        return new Message(1, "共计" + count + "条，导入成功！", "success");
    }

    @Resource
    AssetsService assetsService;

    @ResponseBody
    @RequestMapping("/getOtherExaminationExcelTemplateNew")
    public void getOtherExaminationExcelTemplateNew(HttpServletResponse response, String classId, String curriculum, String term, String semester) {
        ClassBean classBean = classService.getClassByClassid(classId);
        List<Student> list = classService.getStudentListByClassId(classId);
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("其他考试信息录入表模板");
        HSSFCellStyle cellStyle = wb.createCellStyle();
        //cellStyle.setFillForegroundColor((short) 13);// 设置背景色
        cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
        cellStyle.setBorderTop(BorderStyle.THIN);//上边框
        cellStyle.setBorderRight(BorderStyle.THIN);//右边框
        cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
        cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
        HSSFCellStyle headStyle = wb.createCellStyle();
        headStyle.cloneStyleFrom(cellStyle);
        HSSFFont hssfFont = wb.createFont();
        hssfFont.setColor(HSSFColor.RED.index);
        headStyle.setFont(hssfFont);
        sheet.setDefaultColumnWidth(25);
        int tmp = 0;
        HSSFRow row0 = sheet.createRow(tmp);
        row0.createCell(0).setCellValue("");
        row0.createCell(1).setCellValue("说明：此项为必填项");
        row0.createCell(2).setCellValue("说明：此项为必填项");
        row0.createCell(3).setCellValue("说明：此项为必填项");
        row0.createCell(4).setCellValue("说明：此项为必填项");
        row0.createCell(5).setCellValue("说明：此项为必填项");
        row0.createCell(6).setCellValue("说明：此项为必填项");
        row0.createCell(7).setCellValue("说明：此项为必填项");
        row0.createCell(8).setCellValue("说明：此项为必填项");
        row0.createCell(9).setCellValue("说明：此项为必填项");
        row0.createCell(10).setCellValue("说明：此项为必填项");
        row0.createCell(11).setCellValue("说明：此项为必填项");
        row0.createCell(12).setCellValue("说明：此项为必填项");
        row0.createCell(13).setCellValue("说明：此项为必填项");
        tmp++;
        HSSFRow row1 = sheet.createRow(tmp);
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("学生姓名");
        row1.createCell(2).setCellValue("学号");
        row1.createCell(3).setCellValue("身份证号");
        row1.createCell(4).setCellValue("性别");
        row1.createCell(5).setCellValue("系部");
        row1.createCell(6).setCellValue("专业");
        row1.createCell(7).setCellValue("班级");
        row1.createCell(8).setCellValue("学期");
        row1.createCell(9).setCellValue("考试名称");
        row1.createCell(10).setCellValue("科目");
        row1.createCell(11).setCellValue("考核方式");
        row1.createCell(12).setCellValue("授课教师");
        row1.createCell(13).setCellValue("成绩");
        tmp++;
        int i = 1;
        for (Student salaryObj : list) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(salaryObj.getName());
            row.createCell(2).setCellValue(salaryObj.getStudentNumber());
            row.createCell(3).setCellValue(salaryObj.getIdcard());
            row.createCell(4).setCellValue(salaryObj.getSex());
            row.createCell(5).setCellValue(classBean.getDepartmentsIdShow());
            row.createCell(6).setCellValue(classBean.getMajorCodeShow());
            row.createCell(7).setCellValue(salaryObj.getClassShow());
            row.createCell(8).setCellValue(semester);
            row.createCell(9).setCellValue("");
            row.createCell(10).setCellValue(curriculum);
            row.createCell(11).setCellValue("考查");
            row.createCell(12).setCellValue(CommonUtil.getLoginUser().getName());
            row.createCell(13).setCellValue("");
            tmp++;
            i++;
        }
        List<String> list5 = commonService.getSysDictName("QTCJKCLX","");
        String[] score = new String[list5.size()];
        for (int j = 0; j < list5.size(); j++) {
            score[j] = list5.get(j);
        }
        int endRow = list.size() + 1;
        setHSSFValidation(sheet, score, 2, endRow, 13, 13);
        OutputStream os = null;
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("其他考试信息录入表模板.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                    wb.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
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
    @ResponseBody
    @RequestMapping("/getScoreExamListByOtherExam")
    public Message getScoreExamListByOtherExam(String termId, String classId, String course, String scoreExamId) {
        ScoreImport scoreImport = new ScoreImport();
        scoreImport.setTermId(termId);
        scoreImport.setClassId(classId);
        scoreImport.setCourseId(course);
        scoreImport.setScoreExamId(scoreExamId);
        List<ScoreImport> list = otherExaminationService.getScoreExamListByOtherExam(scoreImport);
        if (list.size() > 0) {
            return new Message(2, "", null);
        } else {
            return new Message(1, "提交成功", null);
        }
    }

    @ResponseBody
    @RequestMapping("/importOtherExaminationNew")
    public Message importOtherExaminationNew(@RequestParam(value = "file", required = false) CommonsMultipartFile file, HttpServletRequest request) {
        //HttpServletResponse response, String classId, String curriculum, String term, String semester
        String scoreExamId = request.getParameter("id");
        String classId = request.getParameter("classId");
        String curriculum = request.getParameter("curriculum");
        String term = request.getParameter("term");
        String majorDirection = request.getParameter("majorDirection");
        String departmentId = request.getParameter("departmentId");
        String trainingLevel = request.getParameter("trainingLevel");
        String majorCode = request.getParameter("majorCode");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        int count = 0;
        try {
            HSSFWorkbook workbook1 = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook1.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                if (null == row && count == 0) {
                    return new Message(0, "无数据，导入失败！", "error");
                } else if (null == row) {
                    return new Message(1, "共计" + count + "条，导入成功！", "success");
                }
                ScoreImport project = new ScoreImport();
                project.setStudentName(row.getCell(1).toString());
                String idcard = row.getCell(3).toString();
                project.setStudentId(idcard);
                HSSFCell hssef2 = row.getCell(3);
                hssef2.setCellType(hssef2.CELL_TYPE_STRING);
                String scoreExamName = row.getCell(9).toString();
                project.setScoreExamName(scoreExamName);
                if ("".equals(CommonUtil.changeToString(row.getCell(13))) || null == CommonUtil.changeToString(row.getCell(13))) {
                    project.setScore("超旷");
                }else{
                    project.setScore(row.getCell(13).toString());
                }
                project.setDepartmentsId(departmentId);
                project.setMajorCode(majorCode);
                project.setTrainingLevel(trainingLevel);
                project.setMajorDirection(majorDirection);
                project.setClassId(classId);
                project.setCourseId(curriculum);
                project.setTermId(term);
                project.setExamMethod("2");
                project.setTeachingTeacherId(CommonUtil.getPersonId());
                project.setCreator(CommonUtil.getPersonId());
                project.setCreateDept(CommonUtil.getDefaultDept());
                project.setScoreExamId(scoreExamId);
                otherExaminationService.insertScoreImportByOtherExamination(project);
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "导入" + count + "条成功，第" + (count + 1) + "条数据异常。导入失败！";
            return new Message(0, msg, null);
        }

        return new Message(1, "共计" + count + "条，导入成功！", "success");
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

    @ResponseBody
    @RequestMapping("/getOtherExaminationExcelTemplate")
    public void getOtherExaminationExcelTemplate(HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20", " ");
        String fileName = rootPath + "/template/otherExaminationTemplate.xls";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;

        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("其他考试信息表模板.xls", "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 其他考试信息导出
     *
     * @param
     * @param response
     * @throws UnsupportedEncodingException
     */
    @ResponseBody
    @RequestMapping("/exportOtherExamination")
    public void exportOtherExamination(HttpServletRequest request, HttpServletResponse response) {
        String scoreExamId = request.getParameter("scoreExamId");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        OtherExamination otherExamination = new OtherExamination();
        otherExamination.setScoreExamId(scoreExamId);
        List<OtherExamination> list = otherExaminationService.getScoreImport(otherExamination);

        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("其他考试信息维护表");

        CellStyle cellStyle0 = wb.createCellStyle();

        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);
        CellStyle titleStyle=wb.createCellStyle();
        Font titleFont=wb.createFont();
        titleFont.setFontHeightInPoints((short)22);
        titleFont.setFontName("楷体");
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(CellStyle.ALIGN_CENTER);
        titleStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        int tmp = 0;
        Row titleRow=sheet.createRow(0);
        Cell titleCell=titleRow.createCell(0);
        titleCell.setCellValue("其他考试成绩单");
        titleCell.setCellStyle(titleStyle);

        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 13));
        tmp++;

        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("学生姓名");
        row1.createCell(2).setCellValue("学号");
        row1.createCell(3).setCellValue("身份证号");
        row1.createCell(4).setCellValue("性别");
        row1.createCell(5).setCellValue("专业");
        row1.createCell(6).setCellValue("班级");
        row1.createCell(7).setCellValue("学期");
        row1.createCell(8).setCellValue("考试名称");
        row1.createCell(9).setCellValue("科目");
        row1.createCell(10).setCellValue("考核方式");
        row1.createCell(11).setCellValue("授课教师");
        row1.createCell(12).setCellValue("成绩");
        row1.createCell(13).setCellValue("上传时间");
        tmp++;
        int i = 1;
        for (OtherExamination salaryObj : list) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(salaryObj.getName());
            row.createCell(2).setCellValue(salaryObj.getStudentNumber());
            row.createCell(3).setCellValue(salaryObj.getIdcard());
            row.createCell(4).setCellValue(salaryObj.getSexShow());
            row.createCell(5).setCellValue(salaryObj.getMajorCodeShow());
            row.createCell(6).setCellValue(salaryObj.getClassIdShow());
            row.createCell(7).setCellValue(salaryObj.getTermShow());
            row.createCell(8).setCellValue(salaryObj.getScoreExamName());
            row.createCell(9).setCellValue(salaryObj.getCourseIdShow());
            row.createCell(10).setCellValue(salaryObj.getExamMethodShow());
            row.createCell(11).setCellValue(salaryObj.getTeachingTeacherIdShow());
            row.createCell(12).setCellValue(salaryObj.getScore());
            row.createCell(13).setCellValue(salaryObj.getUploadTime());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("其他考试信息维护表.xls", "utf-8"));
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
