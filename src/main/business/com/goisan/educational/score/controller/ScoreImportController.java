package com.goisan.educational.score.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.exam.bean.ExamCourse;
import com.goisan.educational.exam.service.ExamService;
import com.goisan.educational.schoolreport.bean.SchoolReport;
import com.goisan.educational.schoolreport.dao.SchoolReportDao;
import com.goisan.educational.score.bean.*;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.educational.score.service.ScoreClassService;
import com.goisan.educational.score.service.ScoreImportService;
import com.goisan.evaluation.bean.EvaluationComplexDetail;
import com.goisan.evaluation.bean.EvaluationComplexResult;
import com.goisan.evaluation.service.EvaluationService;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.JsonUtils;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
import java.util.*;

/**
 * Created by Administrator on 2017/10/14.
 */
@Controller
public class ScoreImportController {
    @Resource
    private ExamService examService;
    @Resource
    public EvaluationService evaluationService;
    @Resource
    private StudentService studentService;
    @Resource
    private ScoreImportService scoreImportService;
    @Resource
    private ScoreClassService scoreClassService;
    @Resource
    private CommonService commonService;

    /**
     * 录入成绩申请跳转
     * request by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/scoreImport/list")
    public ModelAndView scoreImportList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreImport");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/selectScoreImportById")
    public boolean selectScoreImportById(String id) {
        ScoreImport scoreImport = scoreImportService.getScoreImportById(id);
        if (scoreImport.getScore() == null || scoreImport.getScore().equals("")) {
            return true;
        } else {
            return false;
        }

    }

    /**
     * 录入成绩URL
     * url by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreImport/selectScoreClass")
    public Map<String, List<ScoreClass>> selectScoreClass(ScoreClass scoreClass) {
        Map<String, List<ScoreClass>> scoreClassMap = new HashMap<String, List<ScoreClass>>();
        scoreClass.setPersonId(CommonUtil.getPersonId());
        scoreClassMap.put("data", scoreImportService.selectScoreClass(scoreClass));
        return scoreClassMap;


    }

    /**
     * List<ScoreClass> selectScoreClass(String personId);
     * 录入成绩URL111111
     * url by hanyue
     * modify by hanyue
     *
     * @param scoreImport
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreImport/getScoreImportList")
    public Map<String, List<ScoreImport>> getScoreImportList(ScoreImport scoreImport) {
        Map<String, List<ScoreImport>> scoreImportMap = new HashMap<String, List<ScoreImport>>();
        scoreImport.setCreator(CommonUtil.getPersonId());
        scoreImport.setCreateDept(CommonUtil.getDefaultDept());
        scoreImportMap.put("data", scoreImportService.getScoreImportList(scoreImport));
        return scoreImportMap;
    }

    /**
     * 录入成绩跳转
     * request by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/scoreImport/getList")
    public ModelAndView getList(ScoreClass scoreClass) {
        ModelAndView mv = new ModelAndView();
        scoreClass.setCourseId(scoreClassService.getScoreClassById(scoreClass.getScoreClassId()).getCourseId());
        mv.setViewName("/business/educational/score/getScoreImport");
        try {
            List<ScoreImport> scoreClass1 = scoreImportService.getScoreClass(scoreClass);
            String s = scoreClass1.get(0).getScoreExamName();
            String s1 = scoreClass1.get(0).getCourseFlag();
            scoreClass.setScoreExamName(s);
            scoreClass.setCourseFlag(s1);
        } catch (Exception a) {
            scoreClass.setScoreExamName(scoreClass.getScoreExamName());
        }

        mv.addObject("scoreClass", scoreClass);

        return mv;


    }

    /**
     * 录入成绩首页显示
     * update by hanyue
     * modify by hanyue
     *
     * @param scoreClass
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreImport/getScoreClass")
    public Map<String, List<ScoreImport>> getScoreClass(ScoreClass scoreClass) {
        Map<String, List<ScoreImport>> scoreImportMap = new HashMap<String, List<ScoreImport>>();
        String personId = scoreImportService.getPersonIdBySubjectIdScoreClassId(scoreClass);
        List<ScoreImport> scoreClassList = scoreImportService.getScoreClass(scoreClass);
        if (scoreClassList.size() > 0) {
            for (ScoreImport list : scoreClassList) {
                list.setPersonId(personId);
                scoreImportService.updatePersonIdByScoreImport(list);
            }
            scoreImportMap.put("data", scoreImportService.getScoreClass(scoreClass));
            return scoreImportMap;
        } else {
            scoreImportService.deleteScoreImportByScoreClass(scoreClass);
            scoreImportService.saveScoreImport(scoreClass);
            scoreImportMap.put("data", scoreImportService.getScoreClass(scoreClass));
            return scoreImportMap;
        }
    }

    @ResponseBody
    @RequestMapping("/scoreImport/saveScore")
    public Message saveScore(HttpServletRequest request, String courseFlag) {
        Map parameterMap = request.getParameterMap();
        Set<String> set = parameterMap.keySet();
        if (courseFlag.equals("02")) {
            for (String id : set) {
                String[] data = (String[]) parameterMap.get(id);
                if (id.length() == 36) {
                    scoreImportService.updateScore(id, "", "", "", "", data[0], data[1]);
                }
            }
        } else {
            for (String id : set) {
                String[] data = (String[]) parameterMap.get(id);
                if (id.length() == 36) {
                    scoreImportService.updateScore(id, data[0], data[1], data[2], data[3], data[4], data[5]);
                }
            }
        }
        return new Message(1, "保存成功！", null);
    }

    /**
     * 录入成绩修改
     * update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreImport/getScoreImportById")
    public ModelAndView getScoreImportById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/score/editScoreImport");
        ScoreImport scoreImport = scoreImportService.getScoreImportById(id);
        mv.addObject("head", "录入成绩修改");
        mv.addObject("scoreImport", scoreImport);
        return mv;
    }

    /**
     * 录入成绩
     * update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreImport/addScoreImportById")
    public ModelAndView addScoreImportById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/score/addScoreImport");
        ScoreImport scoreImport = scoreImportService.getScoreImportById(id);
        mv.addObject("head", "录入成绩");
        mv.addObject("scoreImport", scoreImport);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/scoreCourseList")
    public ModelAndView scoreCourseList(ScoreImport scoreImport) {
        ModelAndView mv = new ModelAndView("/business/educational/score/scoreCourseList2");
        mv.addObject("data", scoreImport);
        return mv;
    }

    /**
     * 删除录入成绩
     * delete by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreImport/deleteScoreImportById")
    public Message deleteScoreImportById(String id) {
        scoreImportService.deleteScoreImportById(id);
        return new Message(1, "删除录入成绩成功！", null);
    }

    @ResponseBody
    @RequestMapping("/scoreImport/saveScoreImportTeacher")
    public Message saveScoreImportTeacher(ScoreImport scoreImport) {
        scoreImport.setChanger(CommonUtil.getPersonId());
        scoreImport.setChangeDept(CommonUtil.getDefaultDept());
        scoreImportService.updateScoreImportById(scoreImport);
        return new Message(1, "修改录入成绩成功！", null);
    }

    @ResponseBody
    @RequestMapping("/scoreImport/addScoreImportTeacher")
    public Message addScoreImportTeacher(ScoreImport scoreImport) {
        scoreImport.setChanger(CommonUtil.getPersonId());
        scoreImport.setChangeDept(CommonUtil.getDefaultDept());
        scoreImportService.updateScoreImportById(scoreImport);
        return new Message(1, "录入成绩成功！", null);
    }

    /**
     * 导入页面
     *
     * @return
     */
    @RequestMapping("/scoreImport/toImportSalary")
    public ModelAndView toImportSalary(String scoreClassId, String subjectId, String scoreExamName, String courseId, String courseFlag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/importScoreImport");
        mv.addObject("scoreClassId", scoreClassId);
        mv.addObject("subjectId", subjectId);
        mv.addObject("scoreExamName", scoreExamName);
        mv.addObject("courseId", courseId);
        mv.addObject("courseFlag", courseFlag);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/getScore")
    public boolean getScore(String studentId) {
        ScoreImport list = scoreImportService.getScoreExaminationStatus(studentId);
        if (list.getScore() == null && list.getExaminationStatus() == null) {
            return true;
        } else {
            return false;
        }

    }

    @ResponseBody
    @RequestMapping("/scoreImport/importSalary")
    /*public Message importStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        LoginUser login = CommonUtil.getLoginUser();
        int count = 0;
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                ScoreImport scoreImport = new ScoreImport();
                ScoreImport scoreImport1 = new ScoreImport();
                String studentName = row.getCell(0).toString();
                scoreImport1.setStudentName(studentName);
                String scoreExamName = row.getCell(1).toString();
                scoreImport.setScoreExamName(scoreExamName);
                String examinationStatus = row.getCell(2).toString();
                scoreImport.setExaminationStatus(scoreImportService.selectExaminationStatus(examinationStatus));
                String courseId = (row.getCell(3).toString());
                scoreImport.setCourseId(scoreImportService.selectCourseId(courseId));
                HSSFCell hssef1 = row.getCell(4);
                hssef1.setCellType(hssef1.CELL_TYPE_STRING);
                scoreImport1.setClassId(CommonUtil.changeToInteger(hssef1) + "");
                scoreImport.setStudentId(scoreImportService.selectStudentIdByName(scoreImport1));
                HSSFCell hssef2 = row.getCell(5);
                hssef2.setCellType(hssef2.CELL_TYPE_STRING);
                scoreImport.setScore(CommonUtil.changeToInteger(hssef2) + "");
                scoreImportService.updateScoreImport(scoreImport);
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "导入" + count + "条成功，第" + (count + 1) + "条数据异常。导入失败！";
            return new Message(0, msg, null);
        }
        return new Message(1, "共计" + count + "条，导入成功！", null);
    }*/
    public Message importStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        List<Select2> kccj = commonService.getSysDict("KCCJ", "");
        List<Select2> kszt = commonService.getSysDict("KSZT", "");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        LoginUser login = CommonUtil.getLoginUser();
        int count = 0;
        HSSFWorkbook workbook = null;
        try {
            workbook = new HSSFWorkbook(file.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        ScoreImport scoreImport1 = new ScoreImport();
        HSSFSheet sheet = workbook.getSheetAt(0);
        int end = sheet.getLastRowNum();
        for (int i = 2; i <= end; i++) {
            try {
                ScoreImport scoreImport = new ScoreImport();
                HSSFRow row = sheet.getRow(i);
                String scoreExamName = row.getCell(1).toString();
                scoreImport.setScoreExamName(scoreExamName);
                String courseId = (row.getCell(4).toString());
                scoreImport.setCourseId(courseId);
                HSSFCell hssef1 = row.getCell(5);
                hssef1.setCellType(hssef1.CELL_TYPE_STRING);
                scoreImport1.setClassId(hssef1.toString() + "");
                scoreImport.setId(row.getCell(14).toString() + "");
                scoreImport.setPeacetimeScoreA(CommonUtil.changeToInteger(row.getCell(8)) + "");
                scoreImport.setPeacetimeScoreB(CommonUtil.changeToInteger(row.getCell(9)) + "");
                scoreImport.setPeacetimeScoreC(CommonUtil.changeToInteger(row.getCell(10)) + "");
                scoreImport.setPeacetimeScoreD(CommonUtil.changeToInteger(row.getCell(11)) + "");
//                String studentName = row.getCell(7).toString();
//                scoreImport1.setStudentName(studentName);
//                scoreImport.setStudentId(scoreImportService.selectStudentIdByName(scoreImport1));
                if (row.getCell(12) == null) {
                    scoreImport.setExaminationStatus("1");
                } else {
                    String examinationStatus = row.getCell(12).toString();
                    for (Select2 ks : kszt) {
                        if (ks.getText().equals(String.valueOf(examinationStatus))) {
                            scoreImport.setExaminationStatus(ks.getId());
                            break;
                        }
                    }
//                    scoreImport.setExaminationStatus(scoreImportService.selectExaminationStatus(examinationStatus));
                }
                HSSFCell hssef2 = row.getCell(13);
                if (hssef2 != null && String.valueOf(hssef2) != "") {
                    for (Select2 kc : kccj) {
                        if (kc.getText().equals(String.valueOf(hssef2))) {
                            scoreImport.setScore(kc.getId());
                            break;
                        }
                    }
                    if (scoreImport.getScore() == null || scoreImport.getScore().equals("")) {
                        hssef2.setCellType(hssef2.CELL_TYPE_STRING);
                        scoreImport.setScore(CommonUtil.changeToInteger(hssef2) + "");
                    }
                } else {
                    scoreImport.setScore("");
                }
                CommonUtil.update(scoreImport);
                scoreImportService.updateScoreImport(scoreImport);
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
     * 导出模板
     *
     * @param response
     */
    @ResponseBody
    @RequestMapping("/scoreImport/getSalaryExcelTemplate")
    public void getSalaryExcelTemplate(HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20", " ");
        String fileName = rootPath + "/template/scoreImportTemplate.xls";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;

        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("成绩单表模板.xls", "utf-8"));
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

    @RequestMapping("/scoreClass/studentList")
    public ModelAndView studentList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/studentMajorClassTree");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreClass/getMajorClassTree")
    public List<Tree> getMajorClassTree() {
        List<Tree> a = studentService.getMajorClassTree();
        return a;
    }

    @RequestMapping("/scoreClass/studentGrid")
    public ModelAndView studentGrid(ScoreImport scoreImport) {
        ModelAndView mv = new ModelAndView("business/educational/score/scoreStudentResultList");
        mv.addObject("data", scoreImport);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/exportScoreImport")
    public void exportScore(HttpServletRequest request, HttpServletResponse response) {
        List<Select2> kccj = commonService.getSysDict("KCCJ", "");
        List<Select2> kszt = commonService.getSysDict("KSZT", "");
        String kccjList = "";
        for (Select2 kc : kccj) {
            kccjList += "," + kc.getText();
        }
        String ksztList = "";
        for (Select2 bk : kszt) {
            ksztList += "," + bk.getText();
        }

        String scoreClassId = request.getParameter("scoreClassId");
        String subjectId = request.getParameter("subjectId");
        String scoreExamName = request.getParameter("scoreExamName");
        String courseId = request.getParameter("courseId");
        String courseFlag = request.getParameter("courseFlag");
        ScoreClass scoreClass = new ScoreClass();
        scoreClass.setScoreClassId(scoreClassId);
        scoreClass.setSubjectId(subjectId);
        scoreClass.setScoreExamName(scoreExamName);
        scoreClass.setCourseId(courseId);
        List<ScoreImport> scoreImportList = scoreImportService.getScoreClass(scoreClass);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("成绩单表");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row2 = sheet.createRow(tmp);
        row2.createCell(1).setCellValue("说明：此项为必填项，请填写学生姓名");
        row2.createCell(2).setCellValue("说明：此项为必填项");
        row2.createCell(3).setCellValue("说明：此项为必填项");
        row2.createCell(4).setCellValue("说明：此项为必填项");
        row2.createCell(5).setCellValue("说明：此项为必填项");
        row2.createCell(6).setCellValue("说明：此项为必填项");
        row2.createCell(7).setCellValue("说明：此项为必填项");
        row2.createCell(8).setCellValue("说明：此项为必填项");
        row2.createCell(9).setCellValue("说明：此项为必填项");
        row2.createCell(10).setCellValue("说明：此项为必填项");
        row2.createCell(11).setCellValue("说明：此项为必填项");
        row2.createCell(13).setCellValue("说明：此项为必填项，请填写数字");
        tmp++;

        HSSFRow row1 = sheet.createRow(tmp);

        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("考试名称");
        row1.createCell(2).setCellValue("系部");
        row1.createCell(3).setCellValue("专业");
        row1.createCell(4).setCellValue("课程");
        row1.createCell(5).setCellValue("班级");
        row1.createCell(6).setCellValue("录入教师");
        row1.createCell(7).setCellValue("学生姓名");
        row1.createCell(8).setCellValue("到课情况");
        row1.createCell(9).setCellValue("作业情况");
        row1.createCell(10).setCellValue("测验情况");
        row1.createCell(11).setCellValue("课上提问情况");
        row1.createCell(12).setCellValue("考试状态");
        row1.createCell(13).setCellValue("成绩");

        if (null != courseFlag && courseFlag.equals("01")) {
        }

        tmp++;
        int i = 1;

        // 判断和设置 成绩录入方式
        if (scoreImportList != null && scoreImportList.size() > 0)
            if (scoreImportList.get(0).getCourseFlag().equals("02")) {
                DVConstraint constraint = DVConstraint.createExplicitListConstraint(kccjList.split(","));
                CellRangeAddressList regions = new CellRangeAddressList(2, scoreImportList.size() + 2, 13, 13);
                HSSFDataValidation data_validation = new HSSFDataValidation(regions, constraint);
                sheet.addValidationData(data_validation);
            }

        // 录入考试状态 下拉选
        DVConstraint constraintType = DVConstraint.createExplicitListConstraint(ksztList.split(","));
        CellRangeAddressList regionsType = new CellRangeAddressList(2, scoreImportList.size() + 2, 12, 12);
        HSSFDataValidation data_validationType = new HSSFDataValidation(regionsType, constraintType);
        sheet.addValidationData(data_validationType);

        // 隐藏 id列
        sheet.setColumnHidden(14, true);
        if (null != courseFlag && !courseFlag.equals("01")) {
            sheet.setColumnHidden(8, true);
            sheet.setColumnHidden(9, true);
            sheet.setColumnHidden(10, true);
            sheet.setColumnHidden(11, true);
        }
        for (ScoreImport unionMemberObj : scoreImportList) {

            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(unionMemberObj.getScoreExamName());
            row.createCell(2).setCellValue(unionMemberObj.getDepartmentsId());
            row.createCell(3).setCellValue(unionMemberObj.getMajorCode());
            row.createCell(4).setCellValue(unionMemberObj.getCourseId());
            row.createCell(5).setCellValue(unionMemberObj.getClassId());
            row.createCell(6).setCellValue(unionMemberObj.getPersonId());
            row.createCell(7).setCellValue(unionMemberObj.getStudentId());
            if (null != courseFlag && courseFlag.equals("01")) {
                row.createCell(8).setCellValue(unionMemberObj.getPeacetimeScoreA());
                row.createCell(9).setCellValue(unionMemberObj.getPeacetimeScoreB());
                row.createCell(10).setCellValue(unionMemberObj.getPeacetimeScoreC());
                row.createCell(11).setCellValue(unionMemberObj.getPeacetimeScoreD());
            }
            row.createCell(12).setCellValue(unionMemberObj.getExaminationStatus());
            row.createCell(13).setCellValue(unionMemberObj.getScore());
            row.createCell(14).setCellValue(unionMemberObj.getId());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("成绩单表.xls", "utf-8"));
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

    @ResponseBody
    @RequestMapping("/scoreImport/getClassScore")
    public Map<String, Object> getClassScore(ScoreImport scoreImport, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> scoreImportss = new HashMap();
        List<ScoreImport> scoreImports = scoreImportService.getScoreClasses(scoreImport);
        PageInfo<List<ScoreImport>> info = new PageInfo(scoreImports);
        scoreImportss.put("draw", draw);
        scoreImportss.put("recordsTotal", info.getTotal());
        scoreImportss.put("recordsFiltered", info.getTotal());
        scoreImportss.put("data", scoreImports);
        return scoreImportss;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/getStores")
    public Map getSCore(String examId, String id) {
        List<Map<String, String>> data = new ArrayList<>();
        Map<String, String> map;
        List<StudentScore> scores = scoreImportService.getScores(id, examId);
        for (StudentScore student : scores) {
            map = new HashMap<>();
            map.put("name", student.getName());
            map.put("number", student.getNumber());
            for (ScoreImport score : student.getScores()) {
                if (score.getScore() == null || score.getScore() == "") {
                    map.put(score.getSubjectId(), "未录入");
                } else {
                    map.put(score.getSubjectId(), score.getScore());
                }
            }
            data.add(map);
        }
        return CommonUtil.tableMap(data);
    }

    @ResponseBody
    @RequestMapping("/scoreImport/getComplexResultList")
    public Map getComplexResultList(String examId, String id) {
        ScoreImport scoreImports = new ScoreImport();
        Student studentBean = new Student();
        studentBean.setClassId(id);
        scoreImports.setClassId(id);
        scoreImports.setScoreExamId(examId);
        List<ScoreImport> list = scoreImportService.getScoreList(scoreImports);
        List<Map> data = new ArrayList<Map>();
        List<Student> students = scoreImportService.getStudentListForScore(studentBean);
        List<Map<String, String>> score = new ArrayList<Map<String, String>>();
        List<ScoreImport> examList = scoreImportService.getScoreExamList(scoreImports);
        for (Student student : students) {
            Map<String, String> map = new HashMap<String, String>();
            map.put("studentId", student.getStudentId());
            map.put("studentName", student.getName());
            scoreImports.setStudentId(student.getStudentId());
            List<ScoreImport> coreImports = scoreImportService.getScoreListByStudentId(scoreImports);
            for (ScoreImport scoreImport : coreImports) {
                map.put(scoreImport.getTermId() + "_" + scoreImport.getCourseId(), scoreImport.getScore());
            }
            data.add(map);
        }
        return CommonUtil.tableMap(data);
    }

    @ResponseBody
    @RequestMapping("/scoreImport/exportComplexResult")
    public void getComplexResultLista(String complexTaskId, String complexTaskName, HttpServletResponse
            response) {
        EvaluationComplexDetail str = new EvaluationComplexDetail();
        str.setComplexTaskId(complexTaskId);
        str.setEvaluationType("");
        List<EvaluationComplexResult> list = evaluationService.getEvaluationComplexSumResult(str);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("综合评教结果");
        //创建HSSFRow对象
        HSSFRow hssfRow = sheet.createRow(0);
        int tmp = 0;
        HSSFRow rowhead = sheet.createRow(tmp);
        //创建HSSFCell对象
        rowhead.createCell(0).setCellValue("评教人");
        rowhead.createCell(1).setCellValue("评教人部门");
        rowhead.createCell(2).setCellValue("分数");
        tmp++;
        for (EvaluationComplexResult ecResult : list) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(ecResult.getEmpName());
            row.createCell(1).setCellValue(ecResult.getDeptShow());
            row.createCell(2).setCellValue(ecResult.getScore());
            tmp++;
        }

        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    (complexTaskName + "评教评分.xls", "utf-8"));
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

    @RequestMapping("/scoreImport/examList")
    public ModelAndView scoreImportExamList() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("personId", CommonUtil.getPersonId());
        mv.setViewName("business/educational/score/scoreImportExamList");
        return mv;
    }

    /**
     * 查看班主任所教班级的考试信息
     */
    @ResponseBody
    @RequestMapping("/scoreImport/getExamList")
    public Map<String, Object> getScoreClassList(ScoreImport scoreImport, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> scoreImports = new HashMap();
        List<ScoreExam> empList = scoreImportService.getScoreClassList(scoreImport);
        PageInfo<List<ScoreExam>> info = new PageInfo(empList);
        scoreImports.put("draw", draw);
        scoreImports.put("recordsTotal", info.getTotal());
        scoreImports.put("recordsFiltered", info.getTotal());
        scoreImports.put("data", empList);
        return scoreImports;
    }

    @RequestMapping("/scoreClass/getScoreListByClassGrid")
    public ModelAndView getScoreListByClassGrid(String id, String examId) {
        Student studentBean = new Student();
        ScoreImport scoreImports = new ScoreImport();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreStudentResultListByClass");
        studentBean.setClassId(id);
        scoreImports.setClassId(id);
        scoreImports.setScoreExamId(examId);
        List<Student> students = scoreImportService.getStudentListForScore(studentBean);
        List<Map<String, String>> score = new ArrayList<Map<String, String>>();
        List<ScoreImport> coreImports = scoreImportService.getScoreList(scoreImports);
        Map<String, String> map = new HashMap<String, String>();
        for (Student student : students) {
            map.put("studentName", student.getName());
            map.put("studentId", student.getStudentId());
            for (ScoreImport scoreImport : coreImports) {
                map.put(scoreImport.getTermId() + "_" + scoreImport.getCourseId(), scoreImport.getScore());
            }
        }
        score.add(map);
        //List<ScoreImport> list = scoreImportService.getScoreList(scoreImports);
        List<ScoreImport> examList = scoreImportService.getScoreExamList(scoreImports);
        List<ScoreImport> courseList = scoreImportService.getScoreCourseList(scoreImports);
        mv.addObject("id", id);
        mv.addObject("score", score);
        mv.addObject("examList", examList);
        mv.addObject("courseList", courseList);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/getScoreListByClass")
    public Map getScoreListByClass(String id, String examId) {
        ScoreImport scoreImports = new ScoreImport();
        Student studentBean = new Student();
        studentBean.setClassId(id);
        scoreImports.setClassId(id);
        scoreImports.setScoreExamId(examId);
        List<ScoreImport> list = scoreImportService.getScoreList(scoreImports);
        List<Map> data = new ArrayList<Map>();
        List<Student> students = scoreImportService.getStudentListForScore(studentBean);
        List<Map<String, String>> score = new ArrayList<Map<String, String>>();
        List<ScoreImport> examList = scoreImportService.getScoreExamList(scoreImports);
        for (Student student : students) {
            Map<String, String> map = new HashMap<String, String>();
            map.put("studentId", student.getStudentId());
            map.put("studentName", student.getName());
            scoreImports.setStudentId(student.getStudentId());
            List<ScoreImport> coreImports = scoreImportService.getScoreListByStudentId(scoreImports);
            for (ScoreImport scoreImport : coreImports) {
                map.put(scoreImport.getTermId() + "_" + scoreImport.getCourseId(), scoreImport.getScore());
            }
            data.add(map);
        }
        return CommonUtil.tableMap(data);
    }

    @RequestMapping("/scoreImport/selExamCourse")
    public ModelAndView selExamCourse(String examId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("examId", examId);
        mv.setViewName("/business/educational/score/courseList");
        return mv;
    }

    //考试科目列表
    @ResponseBody
    @RequestMapping("/scoreImport/getExamCourseList")
    public Map getExamCourseList(ExamCourse examCourse, String examId) {
        examCourse.setExamId(examId);
        return CommonUtil.tableMap(examService.getExamCourseList(examCourse));
    }

    @ResponseBody
    @RequestMapping("/scoreImport/delScore")
    public Message delScore(String ids) {
        scoreImportService.delScore(ids);
        return new Message(1, "清除成功！", null);
    }

    /**
     * 学生个人总成绩单/student/studentScoreList
     */
    @Resource
    private ScoreChangeService scoreChangeService;
    @Autowired
    SchoolReportDao schoolReportDao;
    @RequestMapping("/student/studentScoreList")
    public ModelAndView selectStudentCourse(String studentId) {
        ModelAndView mv = new ModelAndView();
        if (null == studentId || studentId.equals("")) {
            studentId = CommonUtil.getPersonId();
            mv.addObject("returnFlag", "0");
        } else {
            mv.addObject("returnFlag", "1");
        }
        List<ScoreImport> list1 = scoreImportService.getStudentScore(studentId);
        List<Student> student = scoreImportService.getStudentByStudent(studentId);
        if (student.size() > 0) {
            if (list1.size() > 0) {
                mv.setViewName("/business/educational/score/studentPersonScoreList");
                SchoolReport report = new SchoolReport();
                report.setStudentId(studentId);
                //获取学生的个人信息
                List<SchoolReport> schoolReportList = schoolReportDao.getStudentInfo(report);
/*
                List<ScoreImport> weekShow  = scoreImportService.getTermIdByScoreExamId(studentId);
                mv.addObject("weekShow",weekShow);
*/
                Student student1 = scoreChangeService.getStudentByStudentId(studentId);
                List<String> time = scoreChangeService.getStudentEndTime(studentId);
                List<SchoolReport> infoList = schoolReportDao.getSchoolReportList(report);
                for (SchoolReport schoolReport : infoList) {
                    if (schoolReport.getStudentSource()==null) {
                        schoolReport.setStudentSource("");
                    }
                }
                List<ScoreImport> studentArrayClassLooks = scoreImportService.getScoreByStudentIdScoreExamId(studentId);
                mv.addObject("arrayclassResultClassList", JsonUtils.toJson(infoList));
                ScoreImport scoreImport = null;
                if (studentArrayClassLooks.size() > 0) {
                    studentArrayClassLooks.get(0);
                }
                mv.addObject("arrayclassResultClass", student1);

                List row = new ArrayList();
                int L = (studentArrayClassLooks.size() / 2 + 1) > 30 ? studentArrayClassLooks.size() / 2 + 1 + 1 : 30;
                for (int i = 0; i < L; i++) {
                    row.add(i);
                }
                mv.addObject("row", row);

                ScoreImport scoreImport1 = scoreImportService.getStudentByStudentId(studentId);
                mv.addObject("studentName", scoreImport1.getStudentName());
                mv.addObject("sex", scoreImport1.getSex());
                mv.addObject("birthday", scoreImport1.getBirthday());

                ScoreImport scoreImport2 = scoreImportService.getStudentById(studentId);
/*
                List<ScoreImport>  arrayClassTimeList = scoreImportService.getCourseIdBy(studentId);
                mv.addObject("arrayClassTimeList",arrayClassTimeList);
*/
                if (null != scoreImport2) {
                    mv.addObject("entranceTime", scoreImport2.getEntranceTime());
                    mv.addObject("graduationTime", scoreImport2.getGraduationTime());
                    mv.addObject("majorCode", scoreImport2.getMajorCode());
                }
                return mv;
            } else {
                mv.setViewName("/business/educational/score/buildingScoreNull");
                return mv;
            }
        } else {
            mv.setViewName("/business/educational/score/buildingStudentNull");
            return mv;
        }
    }

    @RequestMapping("/scoreClass/courseGrid")
    public ModelAndView courseGrid(String examId, String scoreExamName, String classId, String className) {
        ModelAndView mv = new ModelAndView("business/educational/score/scoreCourseResultList");
        mv.addObject("scoreExamName", scoreExamName);
        mv.addObject("examId", examId);
        mv.addObject("classId", classId);
        mv.addObject("className", className);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/getCourseList")
    public Map getCourseList(ScoreImport scoreImport) {
        return CommonUtil.tableMap(scoreImportService.getCourseList(scoreImport));
    }

    @RequestMapping("/scoreClass/courseClass")
    public ModelAndView courseClass(String examId, String scoreExamName,
                                    String classId, String className, String subjectId,
                                    String courseShow, String courseFlag, String personId) {
        ModelAndView mv = new ModelAndView("/business/educational/score/scoreCourseClassList");
        mv.addObject("scoreExamName", scoreExamName);
        mv.addObject("examId", examId);
        mv.addObject("classId", classId);
        mv.addObject("className", className);
        mv.addObject("courseShow", courseShow);
        mv.addObject("courseFlag", courseFlag);
        mv.addObject("personId", personId);
        ScoreImport scoreImport = new ScoreImport();
        scoreImport.setTermId(examId);
        scoreImport.setClassId(classId);
        scoreImport.setSubjectId(subjectId);
        List<ScoreImport> list = scoreImportService.getCourseClassScoreList(scoreImport);
        mv.addObject("courseClassScoreList", JsonUtils.toJson(list));
        List row = new ArrayList();
        int L = (list.size() / 2 + 1) > 30 ? list.size() / 2 + 1 + 1 : 30;
        for (int i = 0; i < L; i++) {
            row.add(i);
        }
        mv.addObject("row", row);
        return mv;
    }

    @RequestMapping("/scoreExam/getStudentList")
    public ModelAndView getStudentList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreStudentList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/getScoreStudentList")
    public Map<String, Object> getScoreStudentList(String studentName, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> ScoreImports = new HashMap();
        List<ScoreImport> list = scoreImportService.getScoreStudentList(studentName);
        PageInfo<List<ScoreImport>> info = new PageInfo(list);
        ScoreImports.put("draw", draw);
        ScoreImports.put("recordsTotal", info.getTotal());
        ScoreImports.put("recordsFiltered", info.getTotal());
        ScoreImports.put("data", list);
        return ScoreImports;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/getScoreStudentImportList")
    public Map<String, List<ScoreImport>> getScoreStudentImportList(String studentName) {
        Map<String, List<ScoreImport>> examList = new HashMap<String, List<ScoreImport>>();
        examList.put("data", scoreImportService.getScoreStudentImportList());
        return examList;
    }

    @RequestMapping("/scoreImport/getListByStudent")
    public ModelAndView getListByStudent(String studentId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("studentId", studentId);
        mv.setViewName("/business/educational/score/editScoreByStudent");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/getScoreByStudent")
    public Map<String, List<ScoreImport>> getScoreByStudent(ScoreClass scoreClass) {
        Map<String, List<ScoreImport>> scoreImportMap = new HashMap<String, List<ScoreImport>>();
        String personId = scoreImportService.getPersonIdBySubjectIdScoreClassId(scoreClass);
        List<ScoreImport> scoreClassList = scoreImportService.getScoreClass(scoreClass);
        scoreImportMap.put("data", scoreClassList);
        return scoreImportMap;
    }

    @ResponseBody
    @RequestMapping("/scoreImport/getScoreCourse")
    public Map<String, List<ScoreImport>> getScoreCourse(ScoreImport scoreImport) {
        Map<String, List<ScoreImport>> scoreImportMap = new HashMap<>();
        List<ScoreImport> scoreClassList = scoreImportService.getScoreCourse(scoreImport);
        scoreImportMap.put("data", scoreClassList);
        return scoreImportMap;
    }

    @RequestMapping("/scoreImport/scoreDetails")
    public ModelAndView getListByStudent(ScoreImport scoreImport) {
        ModelAndView mv = new ModelAndView("/business/educational/score/scoreDetails");
        mv.addObject("data", scoreImport);
        return mv;
    }

}
