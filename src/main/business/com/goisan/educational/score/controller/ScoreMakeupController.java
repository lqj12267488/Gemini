package com.goisan.educational.score.controller;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.course.dao.CourseDao;
import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.exam.bean.ExamCourseClass;
import com.goisan.educational.exam.bean.ExamStudent;
import com.goisan.educational.exam.dao.ExamDao;
import com.goisan.educational.exam.service.ExamService;
import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.dao.ScoreImportDao;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.educational.score.service.ScoreImportService;
import com.goisan.educational.score.service.ScoreMakeupService;
import com.goisan.educational.teachingtask.bean.TeachingTask;
import com.goisan.educational.teachingtask.service.TeachingTaskService;
import com.goisan.educational.textbook.service.TextBookService;
import com.goisan.system.bean.EmpDeptRelation;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
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
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2017/10/16.
 */
@Controller
public class ScoreMakeupController {
    @Resource
    private ScoreMakeupService scoreMakeupService;
    @Resource
    private CommonService commonService;
    @Autowired
    private ExamService examService;
    @Autowired
    private ExamDao examDao;
    @Autowired
    private CourseDao courseDao;
    @Resource
    private TextBookService textBookService;
    @Autowired
    private ScoreImportDao scoreImportDao;
    @Autowired
    private ScoreImportService scoreImportService;
    @Autowired
    private TeachingTaskService teachingTaskService;
    @Autowired
    private EmpService empService;
    @Autowired
    private ScoreChangeService scoreChangeService;

    @RequestMapping("/scoreMakeup/finalExamList")
    public ModelAndView finalExamList(String type) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreMakeupFinalExam");
        mv.addObject("type", type);
        return mv;
    }

    @RequestMapping("/scoreMakeup/examList")
    public ModelAndView examList(String type) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreMakeupExam");
        mv.addObject("type", type);
        return mv;
    }

    /**
     * 毕业后补考查询
     *
     * @param type
     * @return
     */
    @RequestMapping("/scoreMakeup/examAfterList")
    public ModelAndView examAfterList(String type) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreMakeupAfterExam");
        mv.addObject("type", type);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/getScoreMakeupExamList")
    public Map<String, List<ScoreExam>> getScoreMakeupExamList(ScoreExam scoreExam) {
        Map<String, List<ScoreExam>> map = new HashMap<String, List<ScoreExam>>();
        map.put("data", scoreMakeupService.getScoreMakeupExamList(scoreExam));
        return map;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/getScoreMakeupExamList1111")
    public Map<String, List<ScoreImport>> getScoreMakeupExamList1111(ScoreImport scoreImport) {
        String examMethod = scoreImport.getExamMethod();
        List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
        if (list.size() == 0 && !CommonUtil.getPersonId().equals("sa")) {
            scoreImport.setTeachingTeacherId(CommonUtil.getPersonId());
        }
        Map<String, List<ScoreImport>> map = new HashMap<>();
        String s = textBookService.getUserTypeByPersonId(CommonUtil.getPersonId());
        List<ScoreImport> scoreImports = null;
        if ("1".equals(s)) {
            String personName = CommonUtil.getPersonName();
            List<ScoreImport> scoreImports1 = scoreImportService.checkScoreImportListOther(scoreImportDao.getScoreImportList(scoreImport));
            for (ScoreImport saa : scoreImports1) {
                if (personName.equals(saa.getStudentName())) {
                    scoreImports.add(saa);
                }
            }
        } else {
            scoreImports = scoreImportService.checkScoreImportListOther(scoreImportDao.getScoreImportList(scoreImport));
        }
        map.put("data", scoreImports);
        return map;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/getScoreEndTime")
    public Message getScoreEndTime(String scoreEndTime) {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date dt1 = df.parse(scoreEndTime);
            Date dt2 = df.parse(df.format(new Date()));
            if (dt1.getTime() > dt2.getTime()) {
                return new Message(1, "", "");
            } else if (dt1.getTime() < dt2.getTime()) {
                return new Message(0, "", "");
            } else {
                return new Message(1, "", "");
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return new Message(1, "", "");
    }

    @RequestMapping("/scoreMakeup/import")
    public ModelAndView scoreMakeupList(String type, String scoreExamId, String openFlag, String courseId, String normalScoreEndTime, String classId, String termId, String examMethod) {
        ModelAndView mv = new ModelAndView();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date dt1 = df.parse(normalScoreEndTime);
            Date dt2 = df.parse(df.format(new Date()));
            if (dt1.getTime() > dt2.getTime()) {
                mv.addObject("normalType", "1");
            } else if (dt1.getTime() < dt2.getTime()) {
                mv.addObject("normalType", "0");
            } else {
                mv.addObject("normalType", "1");
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        mv.addObject("type", type);
        mv.addObject("openFlag", openFlag);
        Exam exam = examService.selectExamById(scoreExamId);
        mv.addObject("editFlag", examService.checkScoreTime(scoreExamId) ? "1" : "0");
        String deptId = CommonUtil.getDefaultDept();
        String flag = "";
        if (deptId.equals("001011")) {
            flag = "1";
        }
        mv.addObject("flag", flag);
        if (exam != null) {
            mv.addObject("scoreExamId", exam.getExamId());
            mv.addObject("scoreExamName", exam.getExamName());
            mv.addObject("term", exam.getTerm());
            mv.addObject("courseId", courseId);
            mv.addObject("classId", classId);
            mv.addObject("termId", termId);
            mv.addObject("examMethod", examMethod);

//            是否已提交
            ScoreImport scoreImport = new ScoreImport();
            scoreImport.setScoreExamId(scoreExamId);
            scoreImport.setCourseId(courseId);
            scoreImport.setClassId(classId);
            scoreImport.setTermId(termId);

            Integer isSumbit = scoreMakeupService.isSumbit(scoreImport);
            mv.addObject("isSumbit", isSumbit);
            if (type.equals("1")) {
                if ("1".equals(examMethod)) {
                    mv.setViewName("/business/educational/score/scoreFinalExamList");
                } else {
                    mv.setViewName("/business/educational/score/scoreFinalExamList2");
                }
            } else if (type.equals("2")) {
                mv.setViewName("/business/educational/score/scoreFinalExamMakeupList");
            } else if (type.equals("3")) {
                mv.setViewName("/business/educational/score/scoreFinalExamBeforeMakeupList");
            } else if (type.equals("4")) {
                mv.setViewName("/business/educational/score/scoreFinalExamAfterMakeupList");
            }
            return mv;
        }

        return null;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/getScoreMakeupList")
    public Map<String, List<ScoreImport>> getScoreMakeupList(ScoreImport scoreImport) {
        Map<String, List<ScoreImport>> map = new HashMap<String, List<ScoreImport>>();
        scoreImport.setPersonId(CommonUtil.getPersonId());
        map.put("data", scoreMakeupService.getScoreMakeupList(scoreImport));
        return map;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/updateScoreMakeup")
    public ModelAndView updateScoreMakeup(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreMakeupEdit");
        ScoreImport scoreImport = scoreMakeupService.seleteScoreMakeupById(id);
        mv.addObject("head", "补考成绩录入");
        mv.addObject("scoreImport", scoreImport);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/saveScoreExam")
    public Message saveScoreImport(ScoreImport scoreImport) {
        scoreImport.setChanger(CommonUtil.getPersonId());
        scoreImport.setChangeDept(CommonUtil.getDefaultDept());
        scoreMakeupService.updateScoreMakeup(scoreImport);
        return new Message(1, "补考成绩录入成功！", "success");
    }

    @RequestMapping("/scoreGraduateMakeup/import")
    public ModelAndView scoreGraduateMakeupList(String type, String scoreExamId, String scoreExamName, String term) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreGraduateMakeupList");
        mv.addObject("type", type);
        mv.addObject("scoreExamId", scoreExamId);
        mv.addObject("scoreExamName", scoreExamName);
        mv.addObject("term", term);
        return mv;
    }

    @RequestMapping("/scoreGraduateMakeup/importAfterGraduation")
    public ModelAndView scoreAfterGraduateMakeupList(String type, String scoreExamId, String scoreExamName, String term) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreAfterGraduateMakeupList");
        mv.addObject("type", type);
        mv.addObject("scoreExamId", scoreExamId);
        mv.addObject("scoreExamName", scoreExamName);
        mv.addObject("term", term);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/getScoreGraduateMakeupList")
    public Map<String, List<ScoreImport>> getScoreGraduateMakeupList(ScoreImport scoreImport) {
        Map<String, List<ScoreImport>> map = new HashMap<String, List<ScoreImport>>();
        scoreImport.setPersonId(CommonUtil.getPersonId());
        map.put("data", scoreMakeupService.getScoreGraduateMakeupList(scoreImport));
        return map;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/getScoreAfterGraduateMakeupList")
    public Map<String, List<ScoreImport>> getScoreAfterGraduateMakeupList(ScoreImport scoreImport) {
        Map<String, List<ScoreImport>> map = new HashMap<String, List<ScoreImport>>();
        scoreImport.setPersonId(CommonUtil.getPersonId());
        map.put("data", scoreMakeupService.getScoreAfterGraduateMakeupList(scoreImport));
        return map;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/updateScoreGraduateMakeup")
    public ModelAndView updateScoreGraduateMakeup(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreGraduateMakeupEdit");
        ScoreImport scoreImport = scoreMakeupService.seleteScoreMakeupById(id);
        mv.addObject("head", "毕业补考成绩录入");
        mv.addObject("scoreImport", scoreImport);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/saveScoreGraduateMakeup")
    public Message saveScoreGraduateMakeup(ScoreImport scoreImport) {
        scoreImport.setChanger(CommonUtil.getPersonId());
        scoreImport.setChangeDept(CommonUtil.getDefaultDept());
        scoreMakeupService.updateScoreGraduateMakeup(scoreImport);
        return new Message(1, "毕业补考成绩录入成功！", "success");
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/getMajorAndLevelByDept")
    public List<Select2> getMajorAndLevelByDept(String deptId) {
        List<Select2> list = scoreMakeupService.getMajorAndLevelByDept(deptId);
        return list;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/getClassByMajorAndLevel")
    public List<Select2> getClassIdByMajor(String majorCode) {
        List<Select2> list = scoreMakeupService.getClassByMajorAndLevel(majorCode);
        return list;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/checkImportPerson")
    public List<Select2> checkImportPerson(String deptId) {
        return scoreMakeupService.checkImportPerson(deptId);
    }

    //导入界面跳转
    @ResponseBody
    @RequestMapping("/scoreMakeup/scoreMakeupImport")
    public ModelAndView scoreMakeupImport(String type, String scoreExamId, String normalType,String courseId) {

        if (scoreExamId != null && !"".equals(scoreExamId)) {

            Exam exam = examService.selectExamById(scoreExamId);

            if (exam != null) {

                ModelAndView mv = new ModelAndView();
                mv.setViewName("/business/educational/score/scoreMakeupImport");
                mv.addObject("type", type);
                mv.addObject("normalType", normalType);
                mv.addObject("scoreExamId", scoreExamId);
                mv.addObject("scoreExamName", exam.getExamName());
                mv.addObject("courseId", courseId);
                return mv;
            }
        }

        return null;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/checkExportMakeupScore")
    public Message checkExportMakeupScore(HttpServletRequest request) {

        String scoreExamId = request.getParameter("scoreExamId");
        if (scoreExamId != null && !"".equals(scoreExamId)) {
            Exam exam = examService.selectExamById(scoreExamId);
            if (exam != null) {
                List<Select2> termType = commonService.getSysDict("XQ", "");
                boolean jaowu = false;
                List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
                if (list.size() > 0 || CommonUtil.getPersonId().equals("sa")) {
                    jaowu = true;
                }
                String term = request.getParameter("term");
                String courseId = request.getParameter("courseId");
                String type = request.getParameter("type");
                ExamStudent examStudent = new ExamStudent();
                examStudent.setExamId(scoreExamId);
                if (!jaowu) {
                    if ("3".equals(type) || "4".equals(type)) {
                        examStudent.setTerm(term);
                    }
                }
                List<ExamStudent> studentList = scoreMakeupService.checkStudentAndCourse(examDao.getExamStudentList(examStudent), courseId, scoreExamId, request.getParameter("classId"));
                if (studentList.size() > 0) {
                    return new Message(0, null, null);
                } else {
                    return new Message(1, null, null);
                }
            }
        }
        return new Message(1, null, null);
    }

    //导出及导出模版
    @ResponseBody
    @RequestMapping("/scoreMakeup/exportMakeupScore")
    public void exportMakeupScore(HttpServletRequest request, HttpServletResponse response) {
        String scoreExamId = request.getParameter("scoreExamId");
        String examMethod = request.getParameter("examMethod");
        if (scoreExamId != null && !"".equals(scoreExamId)) {
            Exam exam = examService.selectExamById(scoreExamId);
            if (exam != null) {
                List<Select2> termType = commonService.getSysDict("XQ", "");
                boolean jaowu = false;
                List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
                if (list.size() > 0 || CommonUtil.getPersonId().equals("sa")) {
                    jaowu = true;
                }
                String term = request.getParameter("term");
                String courseId = request.getParameter("courseId");
                String type = request.getParameter("type");
                ExamStudent examStudent = new ExamStudent();
                examStudent.setExamId(scoreExamId);
                if (!jaowu) {
                    if ("3".equals(type) || "4".equals(type)) {
                        examStudent.setTerm(term);
                    }
                }
                if ("2".equals(type) || "3".equals(type) || "4".equals(type)) {
                    examStudent.setCourseId(courseId);
                }
                List<ExamStudent> studentList = scoreMakeupService.checkStudentAndCourse(examDao.getExamStudentList(examStudent), courseId, scoreExamId, request.getParameter("classId"));
                String fileName;
                HSSFWorkbook wb = new HSSFWorkbook();
                if (studentList != null && studentList.size() > 0) {
                    List<Select2> kccj = commonService.getSysDict("KCCJ", "");
//                    考试状态
                    List<Select2> kszt = commonService.getSysDict("KSZT", "");
                    // 补考成绩状态
                    List<Select2> bkcjzt = commonService.getSysDict("BKCJZT", "");
//                    补考状态
                    List<Select2> bkzt = commonService.getSysDict("BKZT", "");
//                  补考成绩
                    List<Select2> bkcj = commonService.getSysDict("BYQBKCJ", "");

                    String[] bkztList = new String[bkzt.size()];
                    for (int j = 0; j < bkzt.size(); j++) {
                        bkztList[j] = bkzt.get(j).getText();
                    }

//                            补考成绩
                    String[] bkcjList = new String[bkcj.size()];
                    for (int j = 0; j < bkcj.size(); j++) {
                        bkcjList[j] = bkcj.get(j).getText();
                    }

                    String kccjList = "";
                    for (Select2 kc : kccj) {
                        kccjList += "," + kc.getText();
                    }
                    String bkcjztList = "";
                    for (Select2 bk : bkcjzt) {
                        bkcjztList += "," + bk.getText();
                    }
                    String ksztList = "";
                    for (Select2 bk : kszt) {
                        ksztList += "," + bk.getText();
                    }
                    HSSFSheet sheet;
                    //创建HSSFSheet对象
                    if (type.equals("1")) {
                        sheet = wb.createSheet("期末成绩单");
                        fileName = exam.getExamName() + "期末成绩单.xls";
                    } else if (type.equals("2")) {
                        sheet = wb.createSheet("补考成绩单");
                        fileName = exam.getExamName() + "补考成绩单.xls";
                    } else if (type.equals("3")) {
                        sheet = wb.createSheet("毕业前补考成绩单");
                        fileName = exam.getExamName() + "毕业前补考成绩单.xls";
                    } else {
                        sheet = wb.createSheet("毕业后补考成绩单");
                        fileName = exam.getExamName() + "毕业后补考成绩单.xls";
                    }
                    //创建HSSFRow对象
                    int tmp = 0;
                    HSSFRow row1 = sheet.createRow(tmp);
                    row1.createCell(3).setCellValue(fileName);
                    tmp++;
                    HSSFRow row2 = sheet.createRow(tmp);
                    row2.createCell(0).setCellValue("序号");
                    row2.createCell(1).setCellValue("学期");
                    row2.createCell(2).setCellValue("学生姓名");
                    row2.createCell(3).setCellValue("身份证号");
                    row2.createCell(4).setCellValue("课程");
                    if (type.equals("1")) {
                        row2.createCell(5).setCellValue("学生到课情况(满分10分)");
                        row2.createCell(6).setCellValue("学生作业情况(满分10分)");
                        row2.createCell(7).setCellValue("学生测验情况(满分10分)");
                        row2.createCell(8).setCellValue("学生课上提问情况(满分10分)");
                        row2.createCell(9).setCellValue("考试状态");
                        if ("1".equals(examMethod)) {
                            row2.createCell(10).setCellValue("成绩");
                            row2.createCell(11).setCellValue("班级");
                            row2.createCell(12).setCellValue("系部");
                            row2.createCell(13).setCellValue("专业");
                            row2.createCell(14).setCellValue("考试方式");
                        } else {
                            row2.createCell(10).setCellValue("成绩");
                            row2.createCell(11).setCellValue("班级");
                            row2.createCell(12).setCellValue("系部");
                            row2.createCell(13).setCellValue("专业");
                            row2.createCell(14).setCellValue("考试方式");
                        }
                    } else if (type.equals("2")) {
                        row2.createCell(5).setCellValue("补考状态");
                        row2.createCell(6).setCellValue("补考成绩");
                        row2.createCell(7).setCellValue("班级");
                        row2.createCell(8).setCellValue("系部");
                        row2.createCell(9).setCellValue("专业");
                        row2.createCell(10).setCellValue("考试方式");
                    } else if (type.equals("3")) {
                        row2.createCell(5).setCellValue("毕业前补考状态");
                        row2.createCell(6).setCellValue("毕业前补考成绩");
                        row2.createCell(7).setCellValue("班级");
                        row2.createCell(8).setCellValue("系部");
                        row2.createCell(9).setCellValue("专业");
                        row2.createCell(10).setCellValue("考试方式");
                    } else if (type.equals("4")) {
                        row2.createCell(5).setCellValue("毕业后补考状态");
                        row2.createCell(6).setCellValue("毕业后补考成绩");
                        row2.createCell(7).setCellValue("班级");
                        row2.createCell(8).setCellValue("系部");
                        row2.createCell(9).setCellValue("专业");
                        row2.createCell(10).setCellValue("考试方式");
                    }
                    tmp++;
                    int i = 1;
                    Course course = null;
//                    if (!jaowu) {
                    course = courseDao.selectById(courseId);
//                    }
                    for (ExamStudent es : studentList) {
                        HSSFRow row = sheet.createRow(tmp);
                        row.createCell(0).setCellValue(i);
                        String termName = "";
                        if (type.equals("1") || type.equals("2")) {
                            for (Select2 status : termType) {
                                if (status.getId().equals(term)) {
                                    termName = status.getText();
                                    break;
                                }
                            }
                            row.createCell(1).setCellValue(termName);
                        } else {
                            row.createCell(1).setCellValue(es.getTermShow());
                        }
                        row.createCell(2).setCellValue(es.getStudentName());
                        row.createCell(3).setCellValue(es.getStudentId());
                        if (course != null) {
                            if ("".equals(course.getTrainingLevel()) || null == course.getTrainingLevel()) {
                                row.createCell(4).setCellValue(course.getCourseName());
                            } else {
                                row.createCell(4).setCellValue(course.getCourseName() + "--" + course.getTrainingLevel());
                            }
                        }
                        if (type.equals("1")) {
                            if ("1".equals(examMethod)) {
                                String[] status = new String[kszt.size()];
                                for (int j = 0; j < kszt.size(); j++) {
                                    status[j] = kszt.get(j).getText();
                                }
//
                                setHSSFValidation(sheet, status, 2, 65535, 9, 9);
                                row.createCell(9).setCellValue(es.getStatusShow());
                                row.createCell(11).setCellValue(es.getClassShow());
                                row.createCell(12).setCellValue(es.getDepartmentShow());
                            } else if ("2".equals(examMethod)) {
                                String[] status = new String[kszt.size()];
                                for (int j = 0; j < kszt.size(); j++) {
                                    status[j] = kszt.get(j).getText();
                                }
                                setHSSFValidation(sheet, status, 2, 65535, 9, 9);

//                                考查下拉
                                String[] kcList = new String[kccj.size()];
                                for (int j = 0; j < kccj.size(); j++) {
                                    kcList[j] = kccj.get(j).getText();
                                }
                                setHSSFValidation(sheet, kcList, 2, 65535, 10, 10);
                                row.createCell(11).setCellValue(es.getClassShow());
                                row.createCell(12).setCellValue(es.getDepartmentShow());
                            }
                            if (es.getMajorShow() != null) {
                                if ("1".equals(examMethod)) {
                                    row.createCell(13).setCellValue(es.getMajorShow().replace("--", ""));
                                } else {
                                    row.createCell(13).setCellValue(es.getMajorShow().replace("--", ""));
                                }
                            }

                            if (!"0".equals(es.getStatus())) {
                                row.createCell(5).setCellValue("0");
                                row.createCell(6).setCellValue("0");
                                row.createCell(7).setCellValue("0");
                                row.createCell(8).setCellValue("0");
                                if ("1".equals(es.getStatus())) {
                                    row.createCell(9).setCellValue("缓考");
                                }
                                if ("2".equals(es.getStatus())) {
                                    row.createCell(9).setCellValue("超旷");
                                }
                                if ("3".equals(es.getStatus())) {
                                    row.createCell(9).setCellValue("当兵");
                                }
                                //row.createCell(10).setCellValue("缓考");
                                row.createCell(10).setCellValue("不合格");
                            }
                            if ("1".equals(examMethod)) {
                                row.createCell(14).setCellValue("考试");
                            } else {
                                row.createCell(14).setCellValue("考查");
                            }
                        } else if (type.equals("2")) {
                            setHSSFValidation(sheet, bkcjList, 2, 65535, 6, 6);
                            setHSSFValidation(sheet, bkztList, 2, 65535, 5, 5);
                            row.createCell(7).setCellValue(es.getClassShow());
                            row.createCell(8).setCellValue(es.getDepartmentShow());
                            if (es.getMajorShow() != null) {
                                row.createCell(9).setCellValue(es.getMajorShow().replace("--", ""));
                            }
                            if ("1".equals(examMethod)) {
                                row.createCell(10).setCellValue("考试");
                            } else {
                                row.createCell(10).setCellValue("考查");
                            }

                        } else if (type.equals("3")) {

                            setHSSFValidation(sheet, bkztList, 2, 65535, 5, 5);
                            setHSSFValidation(sheet, bkcjList, 2, 65535, 6, 6);

//                            row.createCell(6).setCellValue("");
                            row.createCell(7).setCellValue(es.getClassShow());
                            row.createCell(8).setCellValue(es.getDepartmentShow());
                            if (es.getMajorShow() != null) {
                                row.createCell(9).setCellValue(es.getMajorShow().replace("--", ""));
                            }
                            if ("1".equals(examMethod)) {
                                row.createCell(10).setCellValue("考试");
                            } else {
                                row.createCell(10).setCellValue("考查");
                            }
                        } else if (type.equals("4")) {

                            setHSSFValidation(sheet, bkztList, 2, 65535, 5, 5);
                            setHSSFValidation(sheet, bkcjList, 2, 65535, 6, 6);

//                            row.createCell(5).setCellValue("");
//                            row.createCell(6).setCellValue("");
                            row.createCell(7).setCellValue(es.getClassShow());
                            row.createCell(8).setCellValue(es.getDepartmentShow());
                            if (es.getMajorShow() != null) {
                                row.createCell(9).setCellValue(es.getMajorShow().replace("--", ""));
                            }
                            if ("1".equals(examMethod)) {
                                row.createCell(10).setCellValue("考试");
                            } else {
                                row.createCell(10).setCellValue("考查");
                            }
                        }
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
                    sheet.autoSizeColumn(7);
                    sheet.autoSizeColumn(8);
                    sheet.autoSizeColumn(9);
                    sheet.autoSizeColumn(10);
                    sheet.autoSizeColumn(11);
                    sheet.autoSizeColumn(12);
                    sheet.autoSizeColumn(13);
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
    @RequestMapping("/scoreMakeup/exportMakeupScoreForData")
    public void exportMakeupScoreForData(HttpServletRequest request, HttpServletResponse response, ScoreImport
            scoreImport) {

        String scoreExamId = request.getParameter("scoreExamId");

        if (scoreExamId != null && !"".equals(scoreExamId)) {

            Exam exam = examService.selectExamById(scoreExamId);

            if (exam != null) {

                List<Select2> kccj = commonService.getSysDict("KCCJ", "");
                List<Select2> kszt = commonService.getSysDict("KSZT", " DIC_CODE <>'4' ");
                // 补考成绩状态
                List<Select2> bkcjzt = commonService.getSysDict("BKCJZT", "");
                String kccjList = "";
                for (Select2 kc : kccj) {
                    kccjList += "," + kc.getText();
                }
                String bkcjztList = "";
                for (Select2 bk : bkcjzt) {
                    bkcjztList += "," + bk.getText();
                }
                String ksztList = "";
                for (Select2 bk : kszt) {
                    ksztList += "," + bk.getText();
                }

                String type = request.getParameter("type");
                Map<String, String> xq = commonService.getSysDicValueMap("XQ");
                String term = xq.get(exam.getTerm());
                String scoreExamName = exam.getExamName();

                scoreImport.setScoreExamId(exam.getExamId());

                List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());

                if (list.size() == 0 && !CommonUtil.getPersonId().equals("sa")) {
                    scoreImport.setTeachingTeacherId(CommonUtil.getPersonId());
                }

                String studentName = request.getParameter("studentName");

                try {

                    if (studentName != null) {

                        studentName = new String(studentName.getBytes("iso-8859-1"), "utf-8");
                    }

                } catch (Exception e) {

                    e.printStackTrace();
                }

                scoreImport.setStudentName(studentName);

                List<ScoreImport> studentList = scoreImportService.checkScoreImportListOther(scoreImportDao.getScoreImportList2(scoreImport));

                String fileName;
                //创建HSSFWorkbook对象
                HSSFWorkbook wb = new HSSFWorkbook();
                HSSFSheet sheet;
                //创建HSSFSheet对象
                if (type.equals("1")) {
                    sheet = wb.createSheet("期末成绩单");
                    fileName = scoreExamName + "期末成绩单导出.xls";
                } else if (type.equals("2")) {
                    sheet = wb.createSheet("补考成绩单");
                    fileName = scoreExamName + "补考成绩单导出.xls";
                } else if (type.equals("3")) {
                    sheet = wb.createSheet("毕业前补考成绩单");
                    fileName = scoreExamName + "毕业前补考成绩单导出.xls";
                } else {
                    sheet = wb.createSheet("毕业后补考成绩单");
                    fileName = scoreExamName + "毕业后补考成绩单导出.xls";
                }
                //创建HSSFRow对象
                int tmp = 0;
                HSSFRow row1 = sheet.createRow(tmp);
                row1.createCell(0).setCellValue(term);
                row1.createCell(3).setCellValue(fileName);
                tmp++;

                HSSFRow row2 = sheet.createRow(tmp);

                row2.createCell(0).setCellValue("序号");
                row2.createCell(1).setCellValue("学期");
                /**
                 *修改顺序
                 */
                row2.createCell(2).setCellValue("系部");
                row2.createCell(3).setCellValue("专业");
                row2.createCell(4).setCellValue("班级");
//                row2.createCell(2).setCellValue("学号");
//                row2.createCell(3).setCellValue("学生姓名");
//                row2.createCell(4).setCellValue("身份证号");
//                row2.createCell(5).setCellValue("课程");
                row2.createCell(5).setCellValue("学号");
                row2.createCell(6).setCellValue("学生姓名");
                row2.createCell(7).setCellValue("身份证号");
                row2.createCell(8).setCellValue("课程");

                if (type.equals("1")) {

//                    row2.createCell(6).setCellValue("学生到课情况(满分10分)");
//                    row2.createCell(7).setCellValue("学生作业情况(满分10分)");
//                    row2.createCell(8).setCellValue("学生测验情况(满分10分)");
//                    row2.createCell(9).setCellValue("学生课上提问情况(满分10分)");
//                    row2.createCell(10).setCellValue("考试状态");
//                    row2.createCell(11).setCellValue("成绩");
//                    row2.createCell(12).setCellValue("班级");
//                    row2.createCell(13).setCellValue("系部");
//                    row2.createCell(14).setCellValue("专业");
//                    row2.createCell(15).setCellValue("考试方式");
                    row2.createCell(9).setCellValue("学生到课情况(满分10分)");
                    row2.createCell(10).setCellValue("学生作业情况(满分10分)");
                    row2.createCell(11).setCellValue("学生测验情况(满分10分)");
                    row2.createCell(12).setCellValue("学生课上提问情况(满分10分)");
                    row2.createCell(13).setCellValue("期末成绩");
                    row2.createCell(14).setCellValue("考试状态");
                    row2.createCell(15).setCellValue("考试方式");

                } else if (type.equals("2")) {

//                    row2.createCell(6).setCellValue("期末成绩");
//                    row2.createCell(7).setCellValue("补考状态");
//                    row2.createCell(8).setCellValue("补考成绩");
//                    row2.createCell(9).setCellValue("班级");
//                    row2.createCell(10).setCellValue("系部");
//                    row2.createCell(11).setCellValue("专业");
//                    row2.createCell(12).setCellValue("考试方式");
                    row2.createCell(9).setCellValue("期末成绩");
                    row2.createCell(10).setCellValue("补考成绩");
                    row2.createCell(11).setCellValue("补考状态");
                    row2.createCell(12).setCellValue("考试方式");

                } else if (type.equals("3")) {

//                    row2.createCell(6).setCellValue("期末成绩");
//                    row2.createCell(7).setCellValue("期末补考成绩");
//                    row2.createCell(8).setCellValue("毕业前补考状态");
//                    row2.createCell(9).setCellValue("毕业前补考成绩");
//                    row2.createCell(10).setCellValue("班级");
//                    row2.createCell(11).setCellValue("系部");
//                    row2.createCell(12).setCellValue("专业");
//                    row2.createCell(13).setCellValue("考试方式");

                    row2.createCell(9).setCellValue("期末成绩");
                    row2.createCell(10).setCellValue("期末补考成绩");
                    row2.createCell(11).setCellValue("毕业前补考成绩");
                    row2.createCell(12).setCellValue("毕业前补考状态");
                    row2.createCell(13).setCellValue("考试方式");

                } else if (type.equals("4")) {

//                    row2.createCell(6).setCellValue("期末成绩");
//                    row2.createCell(7).setCellValue("期末补考成绩");
//                    row2.createCell(8).setCellValue("毕业前补考成绩");
//                    row2.createCell(9).setCellValue("毕业后补考状态");
//                    row2.createCell(10).setCellValue("毕业后补考成绩");
//                    row2.createCell(11).setCellValue("班级");
//                    row2.createCell(12).setCellValue("系部");
//                    row2.createCell(13).setCellValue("专业");
//                    row2.createCell(14).setCellValue("考试方式");
                    row2.createCell(9).setCellValue("期末成绩");
                    row2.createCell(10).setCellValue("期末补考成绩");
                    row2.createCell(11).setCellValue("毕业前补考成绩");
                    row2.createCell(12).setCellValue("毕业后补考成绩");
                    row2.createCell(13).setCellValue("毕业后补考状态");
                    row2.createCell(14).setCellValue("考试方式");
                }

                tmp++;
                int i = 1;

                for (ScoreImport es : studentList) {

                    HSSFRow row = sheet.createRow(tmp);
                    row.createCell(0).setCellValue(i);
                    row.createCell(1).setCellValue(es.getTermShow());
                    row.createCell(2).setCellValue(es.getDepartmentsId());
                    if (es.getMajorCode() != null) {
                        row.createCell(3).setCellValue(es.getMajorCode().replace("--", ""));
                    }
                    row.createCell(4).setCellValue(es.getClassId());
                    row.createCell(5).setCellValue(es.getStudentNum());
                    row.createCell(6).setCellValue(es.getStudentName());
                    row.createCell(7).setCellValue(es.getStudentId());
                    row.createCell(8).setCellValue(es.getCourseShow());
                    if (type.equals("1")) {
                        row.createCell(9).setCellValue(es.getPeacetimeScoreA());
                        row.createCell(10).setCellValue(es.getPeacetimeScoreB());
                        row.createCell(11).setCellValue(es.getPeacetimeScoreC());
                        row.createCell(12).setCellValue(es.getPeacetimeScoreD());
                        row.createCell(13).setCellValue(es.getScore());
                        row.createCell(14).setCellValue(es.getExaminationStatus());
                        row.createCell(15).setCellValue(es.getExamMethod());

                    } else if (type.equals("2")) {

                        row.createCell(9).setCellValue(es.getFinalScore());
                        row.createCell(10).setCellValue(es.getScore());
                        row.createCell(11).setCellValue(es.getExaminationStatus());
                        row.createCell(12).setCellValue(es.getExamMethod());

                    } else if (type.equals("3")) {

                        row.createCell(9).setCellValue(es.getFinalScore());
                        row.createCell(10).setCellValue(es.getFinalMakeupScore());
                        row.createCell(11).setCellValue(es.getScore());
                        row.createCell(12).setCellValue(es.getExaminationStatus());
                        row.createCell(13).setCellValue(es.getExamMethod());

                    } else if (type.equals("4")) {
                        row.createCell(9).setCellValue(es.getFinalScore());
                        row.createCell(10).setCellValue(es.getFinalMakeupScore());
                        row.createCell(11).setCellValue(es.getFinalBeforeMakeupScore());
                        row.createCell(12).setCellValue(es.getScore());
                        row.createCell(13).setCellValue(es.getExaminationStatus());
                        row.createCell(14).setCellValue(es.getExamMethod());
                    }
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
                sheet.autoSizeColumn(7);
                sheet.autoSizeColumn(8);
                sheet.autoSizeColumn(9);
                sheet.autoSizeColumn(10);
                sheet.autoSizeColumn(11);
                sheet.autoSizeColumn(12);
                sheet.autoSizeColumn(13);
                sheet.autoSizeColumn(14);

                OutputStream os = null;
                response.setContentType("application/vnd.ms-excel");
                try {
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                            (fileName, "utf-8"));
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
        }
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/importMakeupScore1109")
    public Message importMakeupScore1109(@RequestParam(value = "file", required = false) CommonsMultipartFile
                                                 file, String type, String scoreExamId, String classId, String examMethod, String normalType,String courseId) {
        int count = 0;
        if (scoreExamId != null && !"".equals(scoreExamId)) {
            Exam exam = examService.selectExamById(scoreExamId);
            if (exam != null) {

//                补考状态
                List<Select2> bkzt = commonService.getSysDict("KSZTCX", "");
//                    补考成绩
                List<Select2> bkcj = commonService.getSysDict("BYQBKCJ", "");

                List<Select2> kccj = commonService.getSysDict("KCCJ", "");
                List<Select2> statuses = commonService.getSysDict("KSZT", "");
                List<Select2> examType = commonService.getSysDict("KHFS", "");
                List<Select2> scoreType = commonService.getSysDict("CJZT", "");
                List<Select2> termType = commonService.getSysDict("XQ", "");
                Map<String, String> cjzt = commonService.getSysDicMap("CJZT");
                boolean jaowu = false;
                List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
                if (list.size() > 0 || CommonUtil.getPersonId().equals("sa")) {
                    jaowu = true;
                }
                try {
                    HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
                    HSSFSheet sheet = workbook.getSheetAt(0);
                    int end = sheet.getLastRowNum();
                    for (int i = 2; i <= end; i++) {
                        HSSFRow row = sheet.getRow(i);
                        if (type.equals("1")) {
                            if (!scoreMakeupService.checkExcelTr(sheet, type) && i == 2) {
                                return new Message(0, "抱歉！请检查上传模板！", null);
                            }
                            HSSFCell termCell = row.getCell(1);
                            HSSFCell cell1 = row.getCell(3);
                            HSSFCell courseCell = row.getCell(4);
                            if ((termCell == null || "".equals(termCell.toString())) && (cell1 == null || "".equals(cell1.toString())) && (courseCell == null || "".equals(courseCell.toString()))) {
                                break;
                            }
                            if (termCell != null && !"".equals(termCell.toString()) && cell1 != null && courseCell != null && !"".equals(cell1.toString()) && !"".equals(courseCell.toString())) {
                                String term = "";
                                for (Select2 status : termType) {
                                    if (status.getText().equals(termCell.toString())) {
                                        term = status.getId();
                                        break;
                                    }
                                }
                                if (!jaowu) {
                                    boolean bRet = false;
                                    List<Select2> teachingTeskList = teachingTaskService.checkCourseForTeacher(CommonUtil.getPersonId(), term, scoreExamId);
                                    if (teachingTeskList != null && teachingTeskList.size() > 0) {
                                        for (Select2 select2 : teachingTeskList) {
                                            if (select2 != null) {
                                                if (select2.getText().equals(courseCell.toString())) {
                                                    bRet = true;
                                                }
                                            }
                                        }
                                    }
                                    if (!bRet) {
                                        return new Message(0, "抱歉，本次考试您没有" + courseCell.toString() + "的相关课程成绩可以导入！", null);
                                    }
                                }
                                if (term != null && !"".equals(term)) {
                                    ExamStudent examStudent = new ExamStudent();
                                    examStudent.setExamId(scoreExamId);
                                    examStudent.setStudentId(cell1.toString());
                                    List<ExamStudent> studentList = examDao.getExamStudentList(examStudent);
                                    if (studentList != null && studentList.size() > 0) {
                                        ExamStudent es = studentList.get(0);
                                        if (es != null) {
                                            Course selectEdCourse = null;
                                            Course course = new Course();
                                            course.setCourseName(courseCell.toString().split("--")[0]);
                                            course.setTrainingLevel(es.getTrainingLevel());
                                            List<Course> courseList = courseDao.selectList2(course);
                                            if (courseList != null && courseList.size() > 0) {
                                                ExamCourseClass ecc = new ExamCourseClass();
                                                ecc.setExamId(scoreExamId);
                                                ecc.setClassId(es.getClassId());
                                                ecc.setTrainingLevel(es.getTrainingLevel());
                                                List<ExamCourseClass> checkList = examDao.getExamCourseClassByExamIdAndClassId(ecc);
                                                if (checkList == null || checkList.size() == 0) {
                                                    return new Message(0, "抱歉！" + es.getStudentName() + "同学所在的" + es.getClassShow() + "在" + exam.getExamName() + "的考试中，" + courseCell.toString() + "课程，并未在考试范围之内！", null);
                                                }
                                                OUT:
                                                for (int x = 0; x < checkList.size(); x++) {
                                                    ExamCourseClass examCourseClass = checkList.get(x);
                                                    if (examCourseClass != null) {
                                                        for (int y = 0; y < courseList.size(); y++) {
                                                            Course tempCourse = courseList.get(y);
                                                            if (tempCourse != null && examCourseClass.getCourseId().equals(tempCourse.getCourseId()) && examCourseClass.getCourseId() != null && tempCourse.getCourseId() != null && !"".equals(examCourseClass.getCourseId())) {
                                                                selectEdCourse = tempCourse;
                                                                break OUT;
                                                            }
                                                        }
                                                    }
                                                }
                                                if (selectEdCourse == null) {
                                                    return new Message(0, "抱歉！" + es.getStudentName() + "同学所在的" + es.getClassShow() + "在" + exam.getExamName() + "的考试中，" + courseCell.toString() + "课程，并未在考试范围之内！", null);
                                                }
                                                int addOrEdit = 0;
                                                ScoreImport scoreImport = new ScoreImport();
                                                scoreImport.setDepartmentsId(es.getDepartmentsId());
                                                scoreImport.setMajorCode(es.getMajorCode());
                                                scoreImport.setScoreExamId(scoreExamId);
                                                scoreImport.setCourseId(selectEdCourse.getCourseId());
                                                scoreImport.setStudentId(es.getStudentId());
                                                scoreImport.setTermId(term);
                                                ScoreImport oldScoreImport = scoreImportDao.getStudentImportInfo(scoreImport);
                                                if (oldScoreImport != null) {
                                                    if ("1".equals(oldScoreImport.getOpenFlag())) {
                                                        continue;
                                                    }
                                                    scoreImport = oldScoreImport;
                                                    CommonUtil.update(scoreImport);
                                                    addOrEdit = 1;
                                                } else {
                                                    scoreImport.setId(CommonUtil.getUUID());
                                                    CommonUtil.save(scoreImport);
                                                }
                                                scoreImport.setScoreExamName(exam.getExamName());
                                                scoreImport.setClassId(es.getClassId());
                                                scoreImport.setStudentName(es.getStudentName());
                                                scoreImport.setPersonId(CommonUtil.getPersonId());
                                                scoreImport.setTrainingLevel(es.getTrainingLevel());
                                                scoreImport.setTeachingTeacherId(CommonUtil.getPersonId());
                                                String peacetimeScoreA = "0";
                                                String peacetimeScoreB = "0";
                                                String peacetimeScoreC = "0";
                                                String peacetimeScoreD = "0";
                                                if ("1".equals(normalType)) {
                                                    System.err.println("sdasdasdasdasdasdaasd");
                                                    if (row.getCell(5) != null && !"".equals(row.getCell(5).toString())) {
                                                        peacetimeScoreA = row.getCell(5).toString();
                                                    }
                                                    if (row.getCell(6) != null && !"".equals(row.getCell(6).toString())) {
                                                        peacetimeScoreB = row.getCell(6).toString();
                                                    }
                                                    if (row.getCell(7) != null && !"".equals(row.getCell(7).toString())) {
                                                        peacetimeScoreC = row.getCell(7).toString();
                                                    }
                                                    if (row.getCell(8) != null && !"".equals(row.getCell(8).toString())) {
                                                        peacetimeScoreD = row.getCell(8).toString();
                                                    }
                                                }
                                                System.err.println(row.getCell(9));
                                                if (row.getCell(9) != null && !"".equals(row.getCell(9).toString())) {
                                                    for (Select2 status : statuses) {
                                                        if (status.getText().equals(row.getCell(9).toString())) {
                                                            scoreImport.setExaminationStatus(status.getId());
                                                            break;
                                                        }
                                                    }
                                                    if ("正常".equals(row.getCell(9).toString())) {

                                                        if (row.getCell(10) != null && !"".equals(row.getCell(10).toString())) {
//                                                            判断考试类型
                                                            if ("1".equals(examMethod)) {
                                                                //                                                        平时成绩
                                                                double usualGra = Double.parseDouble(peacetimeScoreA) +
                                                                        Double.parseDouble(peacetimeScoreB) +
                                                                        Double.parseDouble(peacetimeScoreC) + Double.parseDouble(peacetimeScoreD);
//                                                        考试成绩
                                                                double examScore = Double.parseDouble(row.getCell
                                                                        (10).toString());
//                                                        期末成绩
                                                                double finalScore = usualGra + examScore * 0.6;
                                                                DecimalFormat decimalFormat = new DecimalFormat("0.0");
                                                                String finalScoreFormat = decimalFormat.format
                                                                        (finalScore);
//                                                                考试成绩
                                                                scoreImport.setExamScore(row.getCell(10).toString());
                                                                scoreImport.setScore(finalScoreFormat);
                                                            } else {
//                                                                考查类型
                                                                for (Select2 kc : kccj) {
                                                                    if (kc.getText().equals(row.getCell(10).toString())) {
                                                                        scoreImport.setScore(kc.getText());
                                                                        scoreImport.setExamScore(kc.getText());
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                        } else {
                                                            if ("1".equals(examMethod)) {
                                                                scoreImport.setScore("0");
                                                                scoreImport.setExamScore("0");
                                                            } else {
                                                                scoreImport.setScore("不合格");
                                                                scoreImport.setExamScore("不合格");
                                                            }
                                                        }
                                                    } else {
                                                        if ("1".equals(examMethod)) {
                                                            scoreImport.setScore(row.getCell(9).toString());
                                                            scoreImport.setExamScore(row.getCell(9).toString());
                                                        } else {
                                                            scoreImport.setScore("不合格");
                                                            scoreImport.setExamScore("不合格");
                                                        }
                                                    }
                                                }
//                                                如果不填，默认是？
                                                else {
                                                    if (row.getCell(10) != null && !"".equals(row.getCell(10))) {

                                                        scoreImport.setExaminationStatus("1");
                                                        if ("1".equals(examMethod)) {
                                                            double usualGra = Double.parseDouble(peacetimeScoreA) +
                                                                    Double.parseDouble(peacetimeScoreB) +
                                                                    Double.parseDouble(peacetimeScoreC) + Double.parseDouble(peacetimeScoreD);
//                                                        考试成绩
                                                            double examScore = Double.parseDouble(row.getCell
                                                                    (10).toString());
//                                                        期末成绩
                                                            double finalScore = usualGra + examScore * 0.6;
                                                            DecimalFormat decimalFormat = new DecimalFormat("0.0");
                                                            String finalScoreFormat = decimalFormat.format
                                                                    (finalScore);
                                                            scoreImport.setScore(finalScoreFormat);
                                                            scoreImport.setExamScore(row.getCell(10).toString());
                                                        } else {
                                                            scoreImport.setScore(row.getCell(10).toString());
                                                            scoreImport.setExamScore(row.getCell(10).toString());
                                                        }
                                                    } else {
                                                        scoreImport.setExaminationStatus("4");
                                                        if ("1".equals(examMethod)) {
                                                            scoreImport.setScore("缺考");
                                                            scoreImport.setExamScore("缺考");
                                                        } else {
                                                            scoreImport.setScore("不合格");
                                                            scoreImport.setExamScore("不合格");
                                                        }
                                                    }
                                                }
                                                if("1".equals(normalType)){
                                                    scoreImport.setPeacetimeScoreA(peacetimeScoreA);
                                                    scoreImport.setPeacetimeScoreB(peacetimeScoreB);
                                                    scoreImport.setPeacetimeScoreC(peacetimeScoreC);
                                                    scoreImport.setPeacetimeScoreD(peacetimeScoreD);
                                                }else{

                                                }
                                                scoreImport.setExamMethod(examMethod);
                                                TeachingTask teachingTask = teachingTaskService.getTeachingTaskByClassIdAndCourseIdAndSemester(scoreImport.getClassId(), scoreImport.getCourseId(), scoreImport.getTermId());
                                                if (teachingTask != null) {
                                                    scoreImport.setPlanId(teachingTask.getId());
                                                    scoreImport.setTeachingTeacherId(teachingTask.getTeacherId());
                                                }
                                                if (!"0".equals(es.getStatus())) {
                                                    scoreImport.setPeacetimeScoreA("0");
                                                    scoreImport.setPeacetimeScoreB("0");
                                                    scoreImport.setPeacetimeScoreC("0");
                                                    scoreImport.setPeacetimeScoreD("0");
                                                    scoreImport.setScore(row.getCell(9).toString());
                                                    scoreImport.setExaminationStatus(cjzt.get(row.getCell(9).toString()));
                                                    scoreImport.setScoreType(cjzt.get(row.getCell(9).toString()));
                                                }
                                                if (scoreImport.getCourseId().equals(courseId)) {
                                                    if (addOrEdit == 0) {
                                                        scoreImportDao.saveStudentImportInfo(scoreImport);
                                                    } else {
                                                        scoreImportDao.updateStudentImportInfo(scoreImport);
                                                    }
                                                    count++;
                                                }
                                            } else {
                                                return new Message(0, "抱歉！" + es.getClassShow() + "并没有" + courseCell.toString() + "课程。", null);
                                            }
                                        } else {
                                            return new Message(0, "抱歉！" + row.getCell(1).toString() + "考生并未找到！请检查身份证是否正确", null);
                                        }
                                    } else {
                                        return new Message(0, "抱歉！" + row.getCell(1).toString() + "考生并未找到！请检查身份证是否正确", null);
                                    }
                                } else {
                                    return new Message(0, "并未找到" + termCell.toString() + "的学期", null);
                                }
                            } else {
                                return new Message(0, "抱歉！学期、身份证和课程名称不能为空", null);
                            }
                        } else if (type.equals("2")) {
                            if (!scoreMakeupService.checkExcelTr(sheet, type) && i == 2) {
                                return new Message(0, "抱歉！请检查上传模板！", null);
                            }

//                            补考
                            HSSFCell termCell = row.getCell(1);
                            HSSFCell cell1 = row.getCell(3);
                            HSSFCell courseCell = row.getCell(4);
                            HSSFCell chengji = row.getCell(6);
                            if ((termCell == null || "".equals(termCell.toString())) && (cell1 == null || "".equals(cell1.toString())) && (courseCell == null || "".equals(courseCell.toString()))) {
                                break;
                            }
                            if (termCell != null && !"".equals(termCell.toString()) && cell1 != null && courseCell != null && !"".equals(cell1.toString()) && !"".equals(courseCell.toString())) {
                                String term = "";
                                for (Select2 status : termType) {
                                    if (status.getText().equals(termCell.toString())) {
                                        term = status.getId();
                                        break;
                                    }
                                }
                                if (!jaowu) {
                                    boolean bRet = false;
                                    List<Select2> teachingTeskList = teachingTaskService.checkCourseForTeacher(CommonUtil.getPersonId(), term, scoreExamId);
                                    if (teachingTeskList != null && teachingTeskList.size() > 0) {
                                        for (Select2 select2 : teachingTeskList) {
                                            if (select2 != null) {
                                                if (select2.getText().equals(courseCell.toString())) {
                                                    bRet = true;
                                                }
                                            }
                                        }
                                    }
                                    if (!bRet) {
                                        return new Message(0, "抱歉，本次考试您没有" + courseCell.toString() + "的相关课程成绩可以导入！", null);
                                    }
                                }
                                if (term != null && !"".equals(term)) {
                                    ExamStudent examStudent = new ExamStudent();
                                    examStudent.setExamId(scoreExamId);
                                    examStudent.setStudentId(cell1.toString());
                                    List<ExamStudent> studentList = examDao.getExamStudentList(examStudent);
                                    if (studentList != null && studentList.size() > 0) {
                                        ExamStudent es = studentList.get(0);
                                        if (es != null) {
                                            Course selectEdCourse = null;
                                            Course course = new Course();
                                            course.setCourseName(courseCell.toString().split("--")[0]);
                                            course.setTrainingLevel(es.getTrainingLevel());
                                            List<Course> courseList = courseDao.selectList2(course);
                                            if (courseList != null && courseList.size() > 0) {
                                                ExamCourseClass ecc = new ExamCourseClass();
                                                ecc.setExamId(scoreExamId);
                                                ecc.setClassId(es.getClassId());
                                                ecc.setTrainingLevel(es.getTrainingLevel());
                                                List<ExamCourseClass> checkList = examDao.getExamCourseClassByExamIdAndClassId(ecc);
                                                if (checkList == null || checkList.size() == 0) {
                                                    return new Message(0, "抱歉！" + es.getStudentName() + "同学所在的" + es.getClassShow() + "在" + exam.getExamName() + "的考试中，" + courseCell.toString() + "课程，并未在考试范围之内！", null);
                                                }
                                                OUT:
                                                for (int x = 0; x < checkList.size(); x++) {
                                                    ExamCourseClass examCourseClass = checkList.get(x);
                                                    if (examCourseClass != null) {
                                                        for (int y = 0; y < courseList.size(); y++) {
                                                            Course tempCourse = courseList.get(y);
                                                            if (tempCourse != null && examCourseClass.getCourseId().equals(tempCourse.getCourseId()) && examCourseClass.getCourseId() != null && tempCourse.getCourseId() != null && !"".equals(examCourseClass.getCourseId())) {
                                                                selectEdCourse = tempCourse;
                                                                break OUT;
                                                            }
                                                        }
                                                    }
                                                }
                                                if (selectEdCourse == null) {
                                                    return new Message(0, "抱歉！" + es.getStudentName() + "同学所在的" + es.getClassShow() + "在" + exam.getExamName() + "的考试中，" + courseCell.toString() + "课程，并未在考试范围之内！", null);
                                                }
                                                int addOrEdit = 0;
                                                ScoreImport scoreImport = new ScoreImport();
                                                scoreImport.setDepartmentsId(es.getDepartmentsId());
                                                scoreImport.setMajorCode(es.getMajorCode());
                                                scoreImport.setScoreExamId(scoreExamId);
                                                scoreImport.setCourseId(selectEdCourse.getCourseId());
                                                scoreImport.setStudentId(es.getStudentId());
                                                scoreImport.setTermId(term);
                                                ScoreImport oldScoreImport = scoreImportDao.getStudentImportInfo(scoreImport);
                                                if (oldScoreImport != null) {
                                                    if ("1".equals(oldScoreImport.getOpenFlag())) {
                                                        continue;
                                                    }
                                                    scoreImport = oldScoreImport;
                                                    CommonUtil.update(scoreImport);
                                                    addOrEdit = 1;
                                                } else {
                                                    scoreImport.setId(CommonUtil.getUUID());
                                                    CommonUtil.save(scoreImport);
                                                }
                                                scoreImport.setScoreExamName(exam.getExamName());
                                                scoreImport.setClassId(es.getClassId());
                                                scoreImport.setStudentName(es.getStudentName());
                                                scoreImport.setPersonId(CommonUtil.getPersonId());
                                                scoreImport.setTrainingLevel(es.getTrainingLevel());
                                                scoreImport.setTeachingTeacherId(CommonUtil.getPersonId());
                                                if (row.getCell(5) != null && !"".equals(row.getCell(5).toString())) {
                                                    String cell5 = row.getCell(5).toString();
                                                    if ("正常".equals(cell5)) {
                                                        scoreImport.setExaminationStatus("1");
                                                        if (row.getCell(6) != null) {
                                                            scoreImport.setScore(row.getCell(6).toString());
                                                        } else {
                                                            scoreImport.setScore("补不及");
                                                        }
                                                    } else {
                                                        scoreImport.setScore("补不及");
                                                        for (Select2 bk : bkzt) {
                                                            if (bk.getText().equals(row.getCell(5).toString())) {
                                                                scoreImport.setExaminationStatus(bk.getId());
                                                                break;
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    if (row.getCell(6) != null && !"".equals(row.getCell(6).toString())) {
                                                        scoreImport.setExaminationStatus("1");
                                                        scoreImport.setScore(row.getCell(6).toString());
                                                    } else {
                                                        scoreImport.setExaminationStatus("10");
                                                        scoreImport.setScore("补不及");
                                                    }
                                                }
                                                scoreImport.setExamMethod(examMethod);

                                                TeachingTask teachingTask = teachingTaskService.getTeachingTaskByClassIdAndCourseIdAndSemester(scoreImport.getClassId(), scoreImport.getCourseId(), scoreImport.getTermId());
                                                if (teachingTask != null) {
                                                    scoreImport.setPlanId(teachingTask.getId());
                                                    scoreImport.setTeachingTeacherId(teachingTask.getTeacherId());
                                                }
//                                                List<ScoreImport> ss = scoreImportDao.getExaminationStatus(scoreImport.getStudentId(), scoreImport.getCourseId(), scoreImport.getTermId());//判断学生考试状态是不是缓考
//                                                if (ss.size() > 0) {
                                                if (scoreImport.getCourseId().equals(courseId)) {
                                                    if (addOrEdit == 0) {
                                                        scoreImportDao.saveStudentImportInfo(scoreImport);
                                                    } else {
                                                        scoreImportDao.updateStudentImportInfo(scoreImport);
                                                    }
                                                    count++;
                                                }
//                                                } else {
//                                                    if (addOrEdit == 0) {
//                                                        scoreImportDao.saveStudentImportInfo(scoreImport);
//                                                    } else {
//                                                        scoreImportDao.updateStudentImportInfo(scoreImport);
//                                                    }
//                                                }

                                            } else {
                                                return new Message(0, "抱歉！" + es.getClassShow() + "并没有" + courseCell.toString() + "课程。", null);
                                            }
                                        } else {
                                            return new Message(0, "抱歉！" + row.getCell(1).toString() + "考生并未找到！请检查身份证是否正确", null);
                                        }
                                    } else {
                                        return new Message(0, "抱歉！" + row.getCell(1).toString() + "考生并未找到！请检查身份证是否正确", null);
                                    }
                                } else {
                                    return new Message(0, "并未找到" + termCell.toString() + "的学期", null);
                                }
                            } else {
                                return new Message(0, "抱歉！学期、身份证和课程名称不能为空", null);
                            }
                        } else if ("3".equals(type)) {

                            if (!scoreMakeupService.checkExcelTr(sheet, type) && i == 2) {
                                return new Message(0, "抱歉！请检查上传模板！", null);
                            }
                            HSSFCell termCell = row.getCell(1);
                            HSSFCell cell1 = row.getCell(3);
                            HSSFCell courseCell = row.getCell(4);
                            if ((termCell == null || "".equals(termCell.toString())) && (cell1 == null || "".equals(cell1.toString())) && (courseCell == null || "".equals(courseCell.toString()))) {
                                break;
                            }
                            if (termCell != null && !"".equals(termCell.toString()) && cell1 != null && courseCell != null && !"".equals(cell1.toString()) && !"".equals(courseCell.toString())) {
                                String term = "";
                                for (Select2 status : termType) {
                                    if (status.getText().equals(termCell.toString())) {
                                        term = status.getId();
                                        break;
                                    }
                                }
                                if (!jaowu) {
                                    boolean bRet = false;
                                    List<Select2> teachingTeskList = teachingTaskService.checkCourseForTeacher(CommonUtil.getPersonId(), term, scoreExamId);
                                    if (teachingTeskList != null && teachingTeskList.size() > 0) {
                                        for (Select2 select2 : teachingTeskList) {
                                            if (select2 != null) {
                                                if (select2.getText().equals(courseCell.toString())) {
                                                    bRet = true;
                                                }
                                            }
                                        }
                                    }
                                    if (!bRet) {
                                        return new Message(0, "抱歉，本次考试您没有" + courseCell.toString() + "的相关课程成绩可以导入！", null);
                                    }
                                }
                                if (term != null && !"".equals(term)) {
                                    ExamStudent examStudent = new ExamStudent();
                                    examStudent.setExamId(scoreExamId);
                                    examStudent.setStudentId(cell1.toString());
                                    examStudent.setTerm(term);
                                    List<ExamStudent> studentList = examDao.getExamStudentList(examStudent);
                                    if (studentList != null && studentList.size() > 0) {
                                        ExamStudent es = studentList.get(0);
                                        if (es != null) {
                                            Course selectEdCourse = null;
                                            Course course = new Course();
                                            course.setCourseName(courseCell.toString().split("--")[0]);
                                            course.setTrainingLevel(es.getTrainingLevel());
                                            List<Course> courseList = courseDao.selectList2(course);
                                            if (courseList != null && courseList.size() > 0) {
                                                ExamCourseClass ecc = new ExamCourseClass();
                                                ecc.setExamId(scoreExamId);
                                                ecc.setClassId(es.getClassId());
                                                ecc.setTrainingLevel(es.getTrainingLevel());
                                                List<ExamCourseClass> checkList = examDao.getExamCourseClassByExamIdAndClassId(ecc);
                                                if (checkList == null || checkList.size() == 0) {
                                                    return new Message(0, "抱歉！" + es.getStudentName() + "同学所在的" + es.getClassShow() + "在" + exam.getExamName() + "的考试中，" + courseCell.toString() + "课程，并未在考试范围之内！", null);
                                                }
                                                OUT:
                                                for (int x = 0; x < checkList.size(); x++) {
                                                    ExamCourseClass examCourseClass = checkList.get(x);
                                                    if (examCourseClass != null) {
                                                        for (int y = 0; y < courseList.size(); y++) {
                                                            Course tempCourse = courseList.get(y);
                                                            if (tempCourse != null && examCourseClass.getCourseId().equals(tempCourse.getCourseId()) && examCourseClass.getCourseId() != null && tempCourse.getCourseId() != null && !"".equals(examCourseClass.getCourseId())) {
                                                                selectEdCourse = tempCourse;
                                                                break OUT;
                                                            }
                                                        }
                                                    }
                                                }
                                                if (selectEdCourse == null) {
                                                    return new Message(0, "抱歉！" + es.getStudentName() + "同学所在的" + es.getClassShow() + "在" + exam.getExamName() + "的考试中，" + courseCell.toString() + "课程，并未在考试范围之内！", null);
                                                }
                                                int addOrEdit = 0;
                                                ScoreImport scoreImport = new ScoreImport();
                                                scoreImport.setDepartmentsId(es.getDepartmentsId());
                                                scoreImport.setMajorCode(es.getMajorCode());
                                                scoreImport.setScoreExamId(scoreExamId);
                                                scoreImport.setCourseId(selectEdCourse.getCourseId());
                                                scoreImport.setStudentId(es.getStudentId());
                                                scoreImport.setTermId(term);
                                                ScoreImport oldScoreImport = scoreImportDao.getStudentImportInfo(scoreImport);
                                                if (oldScoreImport != null) {
                                                    if ("1".equals(oldScoreImport.getOpenFlag())) {
                                                        continue;
                                                    }
                                                    scoreImport = oldScoreImport;
                                                    CommonUtil.update(scoreImport);
                                                    addOrEdit = 1;

                                                } else {
                                                    scoreImport.setId(CommonUtil.getUUID());
                                                    CommonUtil.save(scoreImport);
                                                }
                                                scoreImport.setScoreExamName(exam.getExamName());
                                                scoreImport.setClassId(es.getClassId());
                                                scoreImport.setStudentName(es.getStudentName());
                                                scoreImport.setPersonId(CommonUtil.getPersonId());
                                                scoreImport.setTrainingLevel(es.getTrainingLevel());
                                                scoreImport.setTeachingTeacherId(CommonUtil.getPersonId());
                                                if (row.getCell(5) != null && !"".equals(row.getCell(5).toString())) {
                                                    String cell5 = row.getCell(5).toString();
                                                    if ("正常".equals(cell5)) {
                                                        scoreImport.setExaminationStatus("1");
                                                        if (row.getCell(6) != null) {
//                                                            scoreImport.setScore(row.getCell(6).toString());
//                                                            scoreImport.setScoreType("9");
//                                                            scoreImport.setExaminationStatus("9");
                                                            scoreImport.setScore(row.getCell(6).toString());
                                                        } else {
//                                                            scoreImport.setScore("0");
                                                            scoreImport.setScore("补不及");
                                                        }
                                                        /*if (row.getCell(7) != null) {
                                                            for (Select2 status : scoreType) {
                                                                if (status.getText().equals(row.getCell(7).toString())) {
                                                                    scoreImport.setScoreType(status.getId());
                                                                    break;
                                                                }
                                                            }
                                                        } else {
                                                            scoreImport.setScoreType("4");
                                                        }*/
                                                    } else {
                                                        scoreImport.setScore("补不及");
                                                        for (Select2 bk : bkzt) {
                                                            if (bk.getText().equals(row.getCell(5).toString())) {
                                                                scoreImport.setExaminationStatus(bk.getId());
                                                                break;
                                                            }
                                                        }
//                                                        scoreImport.setScore(row.getCell(5).toString());
//                                                        scoreImport.setExaminationStatus(cjzt.get(row.getCell(5).toString()));
//                                                        scoreImport.setScoreType(cjzt.get(row.getCell(5).toString()));
                                                    }
                                                } else {
//                                                    scoreImport.setExaminationStatus("1");
//                                                    scoreImport.setScore("0");
//                                                    scoreImport.setScoreType("4");
                                                    if (row.getCell(6) != null && !"".equals(row.getCell(6).toString())) {
                                                        scoreImport.setExaminationStatus("1");
                                                        scoreImport.setScore(row.getCell(6).toString());
                                                    } else {
                                                        scoreImport.setExaminationStatus("10");
                                                        scoreImport.setScore("补不及");
                                                    }
                                                }
                                                scoreImport.setExamMethod(examMethod);
                                                TeachingTask teachingTask = teachingTaskService.getTeachingTaskByClassIdAndCourseIdAndSemester(scoreImport.getClassId(), scoreImport.getCourseId(), scoreImport.getTermId());
                                                if (teachingTask != null) {
                                                    scoreImport.setPlanId(teachingTask.getId());
                                                    scoreImport.setTeachingTeacherId(teachingTask.getTeacherId());
                                                }
                                                if (scoreImport.getCourseId().equals(courseId)) {
                                                    if (addOrEdit == 0) {
                                                        scoreImportDao.saveStudentImportInfo(scoreImport);
                                                    } else {
                                                        scoreImportDao.updateStudentImportInfo(scoreImport);
                                                    }
                                                    count++;
                                                }
                                            } else {
                                                return new Message(0, "抱歉！" + es.getClassShow() + "并没有" + courseCell.toString() + "课程。", null);
                                            }
                                        } else {
                                            return new Message(0, "抱歉！" + row.getCell(1).toString() + "考生并未找到！请检查身份证是否正确", null);
                                        }
                                    } else {
                                        return new Message(0, "抱歉！" + row.getCell(1).toString() + "考生并未找到！请检查身份证是否正确", null);
                                    }
                                } else {
                                    return new Message(0, "并未找到" + termCell.toString() + "的学期", null);
                                }
                            } else {
                                return new Message(0, "抱歉！学期、身份证和课程名称不能为空", null);
                            }
                        } else if ("4".equals(type)) {
                            if (!scoreMakeupService.checkExcelTr(sheet, type) && i == 2) {
                                return new Message(0, "抱歉！请检查上传模板！", null);
                            }
                            HSSFCell termCell = row.getCell(1);
                            HSSFCell cell1 = row.getCell(3);
                            HSSFCell courseCell = row.getCell(4);
                            if ((termCell == null || "".equals(termCell.toString())) && (cell1 == null || "".equals(cell1.toString())) && (courseCell == null || "".equals(courseCell.toString()))) {
                                break;
                            }
                            if (termCell != null && !"".equals(termCell.toString()) && cell1 != null && courseCell != null && !"".equals(cell1.toString()) && !"".equals(courseCell.toString())) {
                                String term = "";
                                for (Select2 status : termType) {
                                    if (status.getText().equals(termCell.toString())) {
                                        term = status.getId();
                                        break;
                                    }
                                }
                                if (!jaowu) {
                                    boolean bRet = false;
                                    List<Select2> teachingTeskList = teachingTaskService.checkCourseForTeacher(CommonUtil.getPersonId(), term, scoreExamId);
                                    if (teachingTeskList != null && teachingTeskList.size() > 0) {
                                        for (Select2 select2 : teachingTeskList) {
                                            if (select2 != null) {
                                                if (select2.getText().equals(courseCell.toString())) {
                                                    bRet = true;
                                                }
                                            }
                                        }
                                    }
                                    if (!bRet) {
                                        return new Message(0, "抱歉，本次考试您没有" + courseCell.toString() + "的相关课程成绩可以导入！", null);
                                    }
                                }
                                if (term != null && !"".equals(term)) {
                                    ExamStudent examStudent = new ExamStudent();
                                    examStudent.setExamId(scoreExamId);
                                    examStudent.setStudentId(cell1.toString());
                                    examStudent.setTerm(term);
                                    List<ExamStudent> studentList = examDao.getExamStudentList(examStudent);
                                    if (studentList != null && studentList.size() > 0) {
                                        ExamStudent es = studentList.get(0);
                                        if (es != null) {
                                            Course selectEdCourse = null;
                                            Course course = new Course();
                                            course.setCourseName(courseCell.toString().split("--")[0]);
                                            course.setTrainingLevel(es.getTrainingLevel());
                                            List<Course> courseList = courseDao.selectList2(course);
                                            if (courseList != null && courseList.size() > 0) {
                                                ExamCourseClass ecc = new ExamCourseClass();
                                                ecc.setExamId(scoreExamId);
                                                ecc.setClassId(es.getClassId());
                                                ecc.setTrainingLevel(es.getTrainingLevel());
                                                List<ExamCourseClass> checkList = examDao.getExamCourseClassByExamIdAndClassId(ecc);
                                                if (checkList == null || checkList.size() == 0) {
                                                    return new Message(0, "抱歉！" + es.getStudentName() + "同学所在的" + es.getClassShow() + "在" + exam.getExamName() + "的考试中，" + courseCell.toString() + "课程，并未在考试范围之内！", null);
                                                }
                                                OUT:
                                                for (int x = 0; x < checkList.size(); x++) {
                                                    ExamCourseClass examCourseClass = checkList.get(x);
                                                    if (examCourseClass != null) {
                                                        for (int y = 0; y < courseList.size(); y++) {
                                                            Course tempCourse = courseList.get(y);
                                                            if (tempCourse != null && examCourseClass.getCourseId().equals(tempCourse.getCourseId()) && examCourseClass.getCourseId() != null && tempCourse.getCourseId() != null && !"".equals(examCourseClass.getCourseId())) {
                                                                selectEdCourse = tempCourse;
                                                                break OUT;
                                                            }
                                                        }
                                                    }
                                                }
                                                if (selectEdCourse == null) {
                                                    return new Message(0, "抱歉！" + es.getStudentName() + "同学所在的" + es.getClassShow() + "在" + exam.getExamName() + "的考试中，" + courseCell.toString() + "课程，并未在考试范围之内！", null);
                                                }
                                                int addOrEdit = 0;
                                                ScoreImport scoreImport = new ScoreImport();
                                                scoreImport.setDepartmentsId(es.getDepartmentsId());
                                                scoreImport.setMajorCode(es.getMajorCode());
                                                scoreImport.setScoreExamId(scoreExamId);
                                                scoreImport.setCourseId(selectEdCourse.getCourseId());
                                                scoreImport.setStudentId(es.getStudentId());
                                                scoreImport.setTermId(term);
                                                scoreImport.setScore(row.getCell(8).toString());
                                                ScoreImport oldScoreImport = scoreImportDao.getStudentImportInfo(scoreImport);
                                                if (oldScoreImport != null) {
                                                    if ("1".equals(oldScoreImport.getOpenFlag())) {
                                                        continue;
                                                    }
                                                    scoreImport = oldScoreImport;
                                                    CommonUtil.update(scoreImport);
                                                    addOrEdit = 1;
                                                } else {
                                                    scoreImport.setId(CommonUtil.getUUID());
                                                    CommonUtil.save(scoreImport);
                                                }
                                                scoreImport.setScoreExamName(exam.getExamName());
                                                scoreImport.setClassId(es.getClassId());
                                                scoreImport.setStudentName(es.getStudentName());
                                                scoreImport.setPersonId(CommonUtil.getPersonId());
                                                scoreImport.setTrainingLevel(es.getTrainingLevel());
                                                scoreImport.setTeachingTeacherId(CommonUtil.getPersonId());
                                                if (row.getCell(5) != null && !"".equals(row.getCell(5).toString())) {
                                                    String cell5 = row.getCell(5).toString();

                                                    for (Select2 bk : bkzt) {
                                                        if (bk.getText().equals(row.getCell(5).toString())) {
                                                            scoreImport.setExaminationStatus(bk.getId());
                                                            break;
                                                        }
                                                    }

                                                    if ("正常".equals(cell5)) {
                                                        if (row.getCell(6) != null) {
                                                            scoreImport.setScore(row.getCell(6).toString());


//                                                            scoreImport.setExaminationStatus("9");
//                                                            scoreImport.setScoreType("9");
                                                        } else {
                                                            scoreImport.setScore("补不及");
                                                        }
                                                        /*if (row.getCell(7) != null) {
                                                            for (Select2 status : scoreType) {
                                                                if (status.getText().equals(row.getCell(7).toString())) {
                                                                    scoreImport.setScoreType(status.getId());
                                                                    break;
                                                                }
                                                            }
                                                        } else {
                                                            scoreImport.setScoreType("4");
                                                        }*/
                                                    } else {
                                                        scoreImport.setScore("补不及");
//                                                        scoreImport.setExaminationStatus(cjzt.get(row.getCell(5).toString()));
//                                                        scoreImport.setScoreType(cjzt.get(row.getCell(5).toString()));
                                                    }
                                                } else {
                                                    if (row.getCell(6) != null && !"".equals(row.getCell(6).toString())) {
                                                        scoreImport.setExaminationStatus("1");
                                                        scoreImport.setScore(row.getCell(6).toString());
                                                    } else {
                                                        scoreImport.setExaminationStatus("10");
                                                        scoreImport.setScore("补不及");
                                                    }
//                                                    scoreImport.setScore("0");
//                                                    scoreImport.setScoreType("4");
                                                }

                                                scoreImport.setExamMethod(examMethod);
                                                TeachingTask teachingTask = teachingTaskService.getTeachingTaskByClassIdAndCourseIdAndSemester(scoreImport.getClassId(), scoreImport.getCourseId(), scoreImport.getTermId());
                                                if (teachingTask != null) {
                                                    scoreImport.setPlanId(teachingTask.getId());
                                                    scoreImport.setTeachingTeacherId(teachingTask.getTeacherId());
                                                }
                                                if (scoreImport.getCourseId().equals(courseId)) {
                                                    if (addOrEdit == 0) {
                                                        scoreImportDao.saveStudentImportInfo(scoreImport);
                                                    } else {
                                                        scoreImportDao.updateStudentImportInfo(scoreImport);
                                                    }
                                                    count++;
                                                }

                                            } else {
                                                return new Message(0, "抱歉！" + es.getClassShow() + "并没有" + courseCell.toString() + "课程。", null);
                                            }
                                        } else {
                                            return new Message(0, "抱歉！" + row.getCell(1).toString() + "考生并未找到！请检查身份证是否正确", null);
                                        }
                                    } else {
                                        return new Message(0, "抱歉！" + row.getCell(1).toString() + "考生并未找到！请检查身份证是否正确", null);
                                    }
                                } else {
                                    return new Message(0, "并未找到" + termCell.toString() + "的学期", null);
                                }
                            } else {
                                return new Message(0, "抱歉！学期、身份证和课程名称不能为空", null);
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    String msg = "";
                    if (count == 0) {
                        msg = "请确认导入模版是否正确！";
                    } else {
                        msg = "导入" + count + "条正确，第" + (count + 1) + "条数据异常。请修改后重新上传！";
                    }
                    return new Message(0, msg, "info");
                }
            }
        }
//        if ("2".equals(type)) {
//            scoreImportService.checkHuanKaoScore();
//        }
        return scoreImportService.checkNotHaveScoreInfo(scoreExamId, classId, "共计" + count + "条，导入成功！");
    }

    //导入
    @ResponseBody
    @RequestMapping("/scoreMakeup/importMakeupScore")
    public Message importMakeupScore(@RequestParam(value = "file", required = false) CommonsMultipartFile
                                             file, String type, String scoreExamId) {

        List<Select2> statuses = commonService.getSysDict("KSZT", "");
        List<Select2> kccj = commonService.getSysDict("KCCJ", "");
        List<Select2> bkcjzt = commonService.getSysDict("BKCJZT", "");

        int count = 0;
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                ScoreImport scoreImport = new ScoreImport();
                HSSFRow row = sheet.getRow(i);
                if (type.equals("1")) {
                    if (row.getCell(5) != null) {
                        for (Select2 status : statuses) {
                            if (status.getText().equals(row.getCell(5).toString())) {
                                scoreImport.setMakeupStatus(status.getId());
                                break;
                            }
                        }
                    } else {
                        scoreImport.setMakeupStatus("1");
                    }
                    HSSFCell score = row.getCell(6);
                    for (Select2 bk : bkcjzt) {
                        if (bk.getText().equals(row.getCell(6).toString())) {
                            scoreImport.setMakeupScore(bk.getId());
                            break;
                        }
                    }
                    for (Select2 kc : kccj) {
                        if (kc.getText().equals(row.getCell(6).toString())) {
                            scoreImport.setMakeupScore(kc.getId());
                            break;
                        }
                    }
                    if (null == scoreImport.getMakeupScore() || scoreImport.getMakeupScore().equals("")) {
                        score.setCellType(score.CELL_TYPE_STRING);
                        scoreImport.setMakeupScore(CommonUtil.changeToInteger(score) + "");
                    }
                    scoreImport.setId(row.getCell(11).toString());
                    scoreMakeupService.updateScore(scoreImport.getId(), scoreImport.getMakeupStatus(), scoreImport.getMakeupScore());
                    count++;
                } else if (type.equals("2")) {
                    if (row.getCell(6) != null) {
                        for (Select2 status : statuses) {
                            if (status.getText().equals(row.getCell(6).toString())) {
                                scoreImport.setGraduateMakeupStatus(status.getId());
                                break;
                            }
                        }
                    } else {
                        scoreImport.setGraduateMakeupStatus("1");
                    }
                    HSSFCell score = row.getCell(7);
                    for (Select2 kc : bkcjzt) {
                        if (kc.getText().equals(score.toString())) {
                            scoreImport.setGraduateMakeupScore(kc.getId());
                            break;
                        }
                    }
                    if (null == scoreImport.getGraduateMakeupScore()) {
                        scoreImport.setGraduateMakeupScore("");
                    }
                    scoreImport.setId(row.getCell(11).toString());
                    scoreMakeupService.updateScoreGraduateMakeup(scoreImport);
                    count++;
                } else {
                    String id = row.getCell(11).toString();
                    String afertGraduateMakeupStatus = "";
                    String afertGraduateMakeupScore = "";

                    if (row.getCell(7) != null) {
                        for (Select2 status : statuses) {
                            if (status.getText().equals(row.getCell(7).toString())) {
                                afertGraduateMakeupStatus = status.getId();
                                break;
                            }
                        }
                    }
                    HSSFCell score = row.getCell(8);
                    for (Select2 kc : bkcjzt) {
                        if (kc.getText().equals(score.toString())) {
                            afertGraduateMakeupScore = kc.getId();
                            break;
                        }
                    }
                    scoreMakeupService.saveAfterGraduateScore(id, afertGraduateMakeupStatus, afertGraduateMakeupScore);
                    count++;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "";
            if (count == 0) {
                msg = "请确认导入模版是否正确！";
            } else {
                msg = "导入" + count + "条成功，第" + (count + 1) + "条数据异常。导入失败！";
            }
            return new Message(0, msg, "info");
        }
        return new Message(1, "共计" + count + "条，导入成功！", "success");
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/saveScore")
    public Message saveScore(HttpServletRequest request) {
        return scoreMakeupService.saveScoreCon(request);
    }

    /**
     * 提交成绩
     *
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreMakeup/sumbitScore")
    public Message sumbitScore(HttpServletRequest request) {
        return scoreMakeupService.sumbitScore(request);
    }

    /**
     * 提交补考成绩，毕业前补考成绩，毕业后补考成绩
     *
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreMakeup/sumbitScoreMakeup")
    public Message sumbitScoreMakeup(HttpServletRequest request) {
        return scoreMakeupService.sumbitMakeupScore(request);
    }

    @ResponseBody
    @RequestMapping("/scoreGraduateMakeup/saveScore")
    public Message saveGraduateScore(HttpServletRequest request) {
        Map parameterMap = request.getParameterMap();
        Set<String> set = parameterMap.keySet();
        for (String id : set) {
            String[] data = (String[]) parameterMap.get(id);
            if (id.length() == 36) {
                scoreMakeupService.saveGraduateScore(id, data[0], data[1]);
            }
        }
        return new Message(1, "保存成功！", null);
    }

    @ResponseBody
    @RequestMapping("/scoreAfterGraduateMakeup/saveScore")
    public Message saveAfterGraduateScore(HttpServletRequest request) {
        Map parameterMap = request.getParameterMap();
        Set<String> set = parameterMap.keySet();
        for (String id : set) {
            String[] data = (String[]) parameterMap.get(id);
            if (id.length() == 36) {
                scoreMakeupService.saveAfterGraduateScore(id, data[0], data[1]);
            }
        }
        return new Message(1, "保存成功！", null);
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/delMakeupScore")
    public Message delMakeupScore(String ids) {
        scoreMakeupService.delMakeupScore(ids);
        return new Message(1, "清除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/delGraduateMakeupScore")
    public Message delGraduateMakeupScore(String ids) {
        scoreMakeupService.delGraduateMakeupScore(ids);
        return new Message(1, "清除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/getQueryList")
    public Map<String, Object> getQueryList(HttpServletRequest request) {
        return scoreMakeupService.getQueryList(request);
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/delScoreImport")
    public Message delScoreImport(String ids) {
        scoreImportDao.deleteScoreImportById(ids);
        return new Message(1, "清除成功！", null);
    }

    @RequestMapping("/score/export")
    public void exportTeacherResult(ScoreImport scoreImport, HttpServletResponse response) {
        String type = "";
        switch (scoreImport.getScoreType()) {
            case "1":
                type = "合格";
                break;
            case "2":
                type = "不合格";
                break;
            case "3":
                type = "补及";
                break;
            case "4":
                type = "补不及";
                break;
            case "5":
                type = "所有";
                break;
        }

        String name = "";
        List<ScoreImport> scoreImports = scoreImportService.checkScoreImportListOther(scoreImportDao.getScoreImportList3(scoreImport));
        String term = "";
        if (scoreImports.size() != 0) {
            term = scoreImports.get(0).getTermShow();
            int col = 0;
            switch (scoreImport.getExamTypes()) {
                case "1":
                    name = term + type + "期末成绩";
                    col = 7;
                    break;
                case "2":
                    name = term + type + "期末补考成绩";
                    col = 8;
                    break;
                case "3":
                    name = term + type + "毕业前补考成绩";
                    col = 9;
                    break;
                case "4":
                    name = term + type + "毕业后补考成绩";
                    col = 10;
                    break;
                case "5":
                    name = "毕业学生名单";
                    col = 4;
                    break;
                case "6":
                    name = "不毕业学生名单";
                    col = 4;
                    break;

            }
            //创建HSSFWorkbook对象
            HSSFWorkbook wb = new HSSFWorkbook();
            //创建HSSFSheet对象
            HSSFSheet sheet = wb.createSheet(name);

            Font valueFont = wb.createFont();
            valueFont.setFontHeightInPoints((short) 12);//字体大小

            HSSFCellStyle valueStyle = wb.createCellStyle();

            valueStyle.setBorderLeft(BorderStyle.THIN);//左边框
            valueStyle.setBorderTop(BorderStyle.THIN);//上边框
            valueStyle.setBorderRight(BorderStyle.THIN);//右边框
            valueStyle.setBorderBottom(BorderStyle.THIN); //下边框
            valueStyle.setAlignment(HorizontalAlignment.CENTER); // 居中

            valueStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
            valueStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

            valueStyle.setFont(valueFont);

            Font headerFont = wb.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 12);//字体大小

            HSSFCellStyle cellStyle = wb.createCellStyle();

            cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
            cellStyle.setBorderTop(BorderStyle.THIN);//上边框
            cellStyle.setBorderRight(BorderStyle.THIN);//右边框
            cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
            cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中

            cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
            cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

            cellStyle.setFont(headerFont);

            HSSFCellStyle headerStyle = wb.createCellStyle();

            headerStyle.cloneStyleFrom(cellStyle);
            headerStyle.setFont(headerFont);

            headerStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
            headerStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

            sheet.setDefaultRowHeightInPoints(20);
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, col));
            sheet.createRow(0).createCell(0).setCellValue(name);
            sheet.getRow(0).getCell(0).setCellStyle(cellStyle);

            sheet.getRow(0).setHeight((short) 800);

            int index = 1;

            HSSFRow headRow = sheet.createRow(index);
            HSSFCell headCell0 = headRow.createCell(0);

            headCell0.setCellValue("序号");
            headCell0.setCellStyle(cellStyle);
            if (Integer.parseInt(scoreImport.getExamTypes()) < 5) {
                HSSFCell headCell11 = headRow.createCell(1);
                headCell11.setCellStyle(cellStyle);
                headCell11.setCellValue("学号");
                HSSFCell headCell1 = headRow.createCell(2);
                headCell1.setCellStyle(cellStyle);
                headCell1.setCellValue("姓名");
                HSSFCell headCell2 = headRow.createCell(3);
                headCell2.setCellStyle(cellStyle);
                headCell2.setCellValue("班级");
                HSSFCell headCell3 = headRow.createCell(4);
                headCell3.setCellStyle(cellStyle);
                headCell3.setCellValue("科目");
                HSSFCell headCell4 = headRow.createCell(5);
                headCell4.setCellStyle(cellStyle);
                headCell4.setCellValue("考核方式");
                HSSFCell headCell5 = headRow.createCell(6);
                headCell5.setCellStyle(cellStyle);
                headCell5.setCellValue("任课教师");
                HSSFCell headCell6 = headRow.createCell(7);
                headCell6.setCellStyle(cellStyle);
                headCell6.setCellValue("期末成绩");
                if (Integer.parseInt(scoreImport.getExamTypes()) > 1) {
                    HSSFCell headCell7 = headRow.createCell(8);
                    headCell7.setCellStyle(cellStyle);
                    headCell7.setCellValue("期末补考成绩");
                }
                if (Integer.parseInt(scoreImport.getExamTypes()) > 2) {
                    HSSFCell headCell7 = headRow.createCell(9);
                    headCell7.setCellStyle(cellStyle);
                    headCell7.setCellValue("毕业前补考成绩");
                }
                if (Integer.parseInt(scoreImport.getExamTypes()) > 3) {
                    HSSFCell headCell7 = headRow.createCell(10);
                    headCell7.setCellStyle(cellStyle);
                    headCell7.setCellValue("毕业后补考成绩");
                }
            } else {
                HSSFCell headCell1 = headRow.createCell(1);
                headCell1.setCellStyle(cellStyle);
                headCell1.setCellValue("专业");
                HSSFCell headCell2 = headRow.createCell(2);
                headCell2.setCellStyle(cellStyle);
                headCell2.setCellValue("班级");
                HSSFCell headCell3 = headRow.createCell(3);
                headCell3.setCellStyle(cellStyle);
                headCell3.setCellValue("姓名");
                HSSFCell headCell4 = headRow.createCell(4);
                headCell4.setCellStyle(cellStyle);
                headCell4.setCellValue("学号");
            }
            for (int i = 0; i < scoreImports.size(); i++) {
                index++;
                HSSFRow row = sheet.createRow(index);
                HSSFCell cell0 = row.createCell(0);
                cell0.setCellStyle(valueStyle);
                cell0.setCellValue(i + 1);
                if (Integer.parseInt(scoreImport.getExamTypes()) < 5) {
                    HSSFCell cell11 = row.createCell(1);
                    cell11.setCellStyle(valueStyle);
                    cell11.setCellValue(scoreImports.get(i).getStudentNum());
                    HSSFCell cell1 = row.createCell(2);
                    cell1.setCellStyle(valueStyle);
                    cell1.setCellValue(scoreImports.get(i).getStudentName());
                    HSSFCell cell2 = row.createCell(3);
                    cell2.setCellStyle(valueStyle);
                    cell2.setCellValue(scoreImports.get(i).getClassId());
                    HSSFCell cell3 = row.createCell(4);
                    cell3.setCellStyle(valueStyle);
                    cell3.setCellValue(scoreImports.get(i).getCourseShow());
                    HSSFCell cell4 = row.createCell(5);
                    cell4.setCellStyle(valueStyle);
                    cell4.setCellValue(scoreImports.get(i).getExamMethod());
                    HSSFCell cell5 = row.createCell(6);
                    cell5.setCellStyle(valueStyle);
                    cell5.setCellValue(scoreImports.get(i).getTeachingTeacherId());
                    HSSFCell cell6 = row.createCell(7);
                    cell6.setCellStyle(valueStyle);
                    cell6.setCellValue(scoreImports.get(i).getFinalScore());
                    if (Integer.parseInt(scoreImport.getExamTypes()) > 1) {
                        HSSFCell cell7 = row.createCell(8);
                        cell7.setCellStyle(valueStyle);
                        cell7.setCellValue(scoreImports.get(i).getFinalMakeupScore());
                    }
                    if (Integer.parseInt(scoreImport.getExamTypes()) > 2) {
                        HSSFCell cell8 = row.createCell(9);
                        cell8.setCellStyle(valueStyle);
                        cell8.setCellValue(scoreImports.get(i).getFinalBeforeMakeupScore());
                    }
                    if (Integer.parseInt(scoreImport.getExamTypes()) > 3) {
                        HSSFCell cell9 = row.createCell(10);
                        cell9.setCellStyle(valueStyle);
                        cell9.setCellValue(scoreImports.get(i).getScore());
                    }
                } else {
                    HSSFCell cell1 = row.createCell(1);
                    cell1.setCellStyle(valueStyle);
                    cell1.setCellValue(scoreImports.get(i).getMajorCode());
                    HSSFCell cell2 = row.createCell(2);
                    cell2.setCellStyle(valueStyle);
                    cell2.setCellValue(scoreImports.get(i).getClassId());
                    HSSFCell cell3 = row.createCell(3);
                    cell3.setCellStyle(valueStyle);
                    cell3.setCellValue(scoreImports.get(i).getStudentName());
                    HSSFCell cell4 = row.createCell(4);
                    cell4.setCellStyle(valueStyle);
                    cell4.setCellValue(scoreImports.get(i).getStudentNum());
                }
            }

            sheet.setColumnWidth(1, 6000);
            sheet.setColumnWidth(2, 6000);
            sheet.setColumnWidth(3, 6000);
            sheet.setColumnWidth(4, 6000);
            sheet.setColumnWidth(5, 6000);
            sheet.setColumnWidth(6, 6000);
            sheet.setColumnWidth(7, 6000);
            sheet.setColumnWidth(8, 6000);
            sheet.setColumnWidth(9, 6000);
            sheet.setColumnWidth(10, 6000);

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

    @ResponseBody
    @RequestMapping("/scoreMakeup/exportScoreImport")
    public void exportScoreImport(HttpServletRequest request, HttpServletResponse response) {
        scoreImportService.readScoreExcel(request, response);
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/exportFailCount")
    public void exportFailCount(HttpServletRequest request, HttpServletResponse response) {
        scoreImportService.readFailCountExcel(request, response);
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/toCheckedClass")
    public ModelAndView toCheckedClass(String scoreExamId, String examTypes, String scoreType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/checkedClass");
        mv.addObject("scoreExamId", scoreExamId);
        mv.addObject("examTypes", examTypes);
        mv.addObject("scoreType", scoreType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/changeOpenFlag")
    public Message changeOpenFlag(String scoreExamId, String classId, String courseId) {
        return scoreImportService.openScore(scoreExamId, classId, courseId);
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/toCheckCourseForTeacher")
    public ModelAndView toCheckCourseForTeacher(String scoreExamId, String type) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/checkedCourse");
        mv.addObject("scoreExamId", scoreExamId);
        mv.addObject("type", type);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/checkCourseForTeacher")
    public List<Select2> checkCourseForTeacher(String semester, String examId) {
        return teachingTaskService.checkCourseForTeacher(CommonUtil.getPersonId(), semester, examId);
    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/getTeachingTaskSemester")
    public List<Select2> getTeachingTaskSemester() {
        return teachingTaskService.checkSemesterForTeacher(CommonUtil.getPersonId());
    }

    /**
     * 按班级分类导出
     */
    @RequestMapping("/score/exportAllClass")
    public void exportAllClass(ScoreImport scoreImport, HttpServletResponse response) {
        int num = 1;
        String name = "sheet";
        scoreImport.setScoreType("5");
        List<ScoreImport> scoreImports = scoreImportService.checkScoreImportListOther(scoreImportDao.getScoreImportList3(scoreImport));
        //scoreImportService.checkScoreImportListOther(scoreImportDao.getScoreImportList(scoreImport));
        if (scoreImports.size() != 0) {
            //创建HSSFWorkbook对象
            HSSFWorkbook wb = new HSSFWorkbook();
            //创建HSSFSheet对象
            HSSFSheet sheet = wb.createSheet(name + num);
            Font valueFont = wb.createFont();
            valueFont.setFontHeightInPoints((short) 12);//字体大小

            HSSFCellStyle valueStyle = wb.createCellStyle();

            valueStyle.setBorderLeft(BorderStyle.THIN);//左边框
            valueStyle.setBorderTop(BorderStyle.THIN);//上边框
            valueStyle.setBorderRight(BorderStyle.THIN);//右边框
            valueStyle.setBorderBottom(BorderStyle.THIN); //下边框
            valueStyle.setAlignment(HorizontalAlignment.CENTER); // 居中

            valueStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
            valueStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

            valueStyle.setFont(valueFont);

            Font headerFont = wb.createFont();
            headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            headerFont.setFontHeightInPoints((short) 12);//字体大小

            HSSFCellStyle cellStyle = wb.createCellStyle();

            cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
            cellStyle.setBorderTop(BorderStyle.THIN);//上边框
            cellStyle.setBorderRight(BorderStyle.THIN);//右边框
            cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
            cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中

            cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
            cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

            cellStyle.setFont(headerFont);

            HSSFCellStyle headerStyle = wb.createCellStyle();

            headerStyle.cloneStyleFrom(cellStyle);
            headerStyle.setFont(headerFont);

            headerStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
            headerStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

            sheet.setDefaultRowHeightInPoints(20);
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 8));
            sheet.createRow(0).createCell(0).setCellValue("班级期末补考情况");
            sheet.getRow(0).getCell(0).setCellStyle(cellStyle);
            sheet.getRow(0).setHeight((short) 800);
            sheet.setColumnWidth(1, 6500);
            sheet.setColumnWidth(2, 6000);
            sheet.setColumnWidth(3, 6000);
            sheet.setColumnWidth(4, 6000);
            sheet.setColumnWidth(5, 6000);
            sheet.setColumnWidth(6, 6000);
            sheet.setColumnWidth(7, 6000);
            sheet.setColumnWidth(8, 6000);
            int index = 1;

            HSSFRow headRow = sheet.createRow(index);
            HSSFCell headCell0 = headRow.createCell(0);
            headCell0.setCellValue("序号");
            headCell0.setCellStyle(cellStyle);
            HSSFCell headCell11 = headRow.createCell(1);
            headCell11.setCellStyle(cellStyle);
            headCell11.setCellValue("学号");
            HSSFCell headCell1 = headRow.createCell(2);
            headCell1.setCellStyle(cellStyle);
            headCell1.setCellValue("姓名");
            HSSFCell headCell2 = headRow.createCell(3);
            headCell2.setCellStyle(cellStyle);
            headCell2.setCellValue("班级");
            HSSFCell headCell3 = headRow.createCell(4);
            headCell3.setCellStyle(cellStyle);
            headCell3.setCellValue("科目");
            HSSFCell headCell4 = headRow.createCell(5);
            headCell4.setCellStyle(cellStyle);
            headCell4.setCellValue("考核方式");
            HSSFCell headCell5 = headRow.createCell(6);
            headCell5.setCellStyle(cellStyle);
            headCell5.setCellValue("任课教师");
            HSSFCell headCell6 = headRow.createCell(7);
            headCell6.setCellStyle(cellStyle);
            headCell6.setCellValue("期末成绩");
            HSSFCell headCell7 = headRow.createCell(8);
            headCell7.setCellStyle(cellStyle);
            headCell7.setCellValue("期末补考成绩");

            for (int i = 0; i < scoreImports.size(); i++) {
                index++;
                HSSFRow row = sheet.createRow(index);
                int a = scoreImports.size();
                if (i + 1 != a && !scoreImports.get(i).getClassId().equals(scoreImports.get(i + 1).getClassId())) {
                    index = 1;
                    num++;
                    sheet = wb.createSheet(name + num);
                    valueFont.setFontHeightInPoints((short) 12);//字体大小

                    valueStyle.setBorderLeft(BorderStyle.THIN);//左边框
                    valueStyle.setBorderTop(BorderStyle.THIN);//上边框
                    valueStyle.setBorderRight(BorderStyle.THIN);//右边框
                    valueStyle.setBorderBottom(BorderStyle.THIN); //下边框
                    valueStyle.setAlignment(HorizontalAlignment.CENTER); // 居中

                    valueStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
                    valueStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中
                    valueStyle.setFont(valueFont);
                    headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                    headerFont.setFontHeightInPoints((short) 12);//字体大小

                    cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
                    cellStyle.setBorderTop(BorderStyle.THIN);//上边框
                    cellStyle.setBorderRight(BorderStyle.THIN);//右边框
                    cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
                    cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中

                    cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
                    cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

                    cellStyle.setFont(headerFont);

                    headerStyle.cloneStyleFrom(cellStyle);
                    headerStyle.setFont(headerFont);

                    headerStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
                    headerStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

                    sheet.setDefaultRowHeightInPoints(20);
                    sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 8));
                    sheet.createRow(0).createCell(0).setCellValue("班级期末补考情况");
                    sheet.getRow(0).getCell(0).setCellStyle(cellStyle);
                    sheet.getRow(0).setHeight((short) 800);
                    sheet.setColumnWidth(1, 6500);
                    sheet.setColumnWidth(2, 6000);
                    sheet.setColumnWidth(3, 6000);
                    sheet.setColumnWidth(4, 6000);
                    sheet.setColumnWidth(5, 6000);
                    sheet.setColumnWidth(6, 6000);
                    sheet.setColumnWidth(7, 6000);
                    sheet.setColumnWidth(8, 6000);
                    headRow = sheet.createRow(index);
                    headCell0 = headRow.createCell(0);
                    headCell0.setCellValue("序号");
                    headCell0.setCellStyle(cellStyle);
                    headCell11 = headRow.createCell(1);
                    headCell11.setCellStyle(cellStyle);
                    headCell11.setCellValue("学号");
                    headCell1 = headRow.createCell(2);
                    headCell1.setCellStyle(cellStyle);
                    headCell1.setCellValue("姓名");
                    headCell2 = headRow.createCell(3);
                    headCell2.setCellStyle(cellStyle);
                    headCell2.setCellValue("班级");
                    headCell3 = headRow.createCell(4);
                    headCell3.setCellStyle(cellStyle);
                    headCell3.setCellValue("科目");
                    headCell4 = headRow.createCell(5);
                    headCell4.setCellStyle(cellStyle);
                    headCell4.setCellValue("考核方式");
                    headCell5 = headRow.createCell(6);
                    headCell5.setCellStyle(cellStyle);
                    headCell5.setCellValue("任课教师");
                    headCell6 = headRow.createCell(7);
                    headCell6.setCellStyle(cellStyle);
                    headCell6.setCellValue("期末成绩");
                    headCell7 = headRow.createCell(8);
                    headCell7.setCellStyle(cellStyle);
                    headCell7.setCellValue("期末补考成绩");
                }
                HSSFCell cell0 = row.createCell(0);
                cell0.setCellStyle(valueStyle);
                cell0.setCellValue(i + 1);
                HSSFCell cell11 = row.createCell(1);
                cell11.setCellStyle(valueStyle);
                cell11.setCellValue(scoreImports.get(i).getStudentNum());
                HSSFCell cell1 = row.createCell(2);
                cell1.setCellStyle(valueStyle);
                cell1.setCellValue(scoreImports.get(i).getStudentName());
                HSSFCell cell2 = row.createCell(3);
                cell2.setCellStyle(valueStyle);
                cell2.setCellValue(scoreImports.get(i).getClassId());
                HSSFCell cell3 = row.createCell(4);
                cell3.setCellStyle(valueStyle);
                cell3.setCellValue(scoreImports.get(i).getCourseShow());
                HSSFCell cell4 = row.createCell(5);
                cell4.setCellStyle(valueStyle);
                cell4.setCellValue(scoreImports.get(i).getExamMethod());
                HSSFCell cell5 = row.createCell(6);
                cell5.setCellStyle(valueStyle);
                cell5.setCellValue(scoreImports.get(i).getTeachingTeacherId());
                HSSFCell cell6 = row.createCell(7);
                cell6.setCellStyle(valueStyle);
                cell6.setCellValue(scoreImports.get(i).getFinalScore());
                HSSFCell cell7 = row.createCell(8);
                cell7.setCellStyle(valueStyle);
                cell7.setCellValue(scoreImports.get(i).getFinalMakeupScore());
            }

            OutputStream os = null;
            response.setContentType("application/vnd.ms-excel");
            try {
                response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("班级期末补考情况" + ".xls", "utf-8"));
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

    @RequestMapping("/scoreExam/seeDetails")
    public ModelAndView seeDetails(String id, String type) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreMakeuoFinalExamDetails");
        mv.addObject("id", id);
        mv.addObject("type", type);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreExam/getDetails")
    public Map<String, List<Map<String, String>>> getDetails(String id) {
        Map<String, List<Map<String, String>>> map = new HashMap<>();
        map.put("data", scoreImportService.getDetails(id));
        return map;
    }

    @ResponseBody
    @RequestMapping("/scoreExam/getCourseClass")
    public Map<String, List<Map<String, String>>> getCourseClass(String id,String queryFlag) {
        List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
        Map<String, List<Map<String, String>>> map = new HashMap<>();
        boolean b = false;
        for (EmpDeptRelation empDeptRelation : list) {
            if (empDeptRelation.getPersonId().equals(CommonUtil.getPersonId())) {
                b = true;
            }
        }
        if (b) {
            if ("2".equals(queryFlag))  {
                map.put("data", scoreImportService.getCourseClass2(id, null));
            }else {
                map.put("data", scoreImportService.getCourseClass(id, null));
            }
        } else {
            if ("2".equals(queryFlag)){
                map.put("data", scoreImportService.getCourseClass2(id, CommonUtil.getPersonId()));
            }else {
                map.put("data", scoreImportService.getCourseClass(id, CommonUtil.getPersonId()));
            }
        }
        return map;
    }

    @RequestMapping("/scoreExam/toCourseClass")
    public ModelAndView toCourseClass(String id, String type, String openFlag,String queryFlag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/courseClass");
        mv.addObject("id", id);
        mv.addObject("type", type);
        mv.addObject("openFlag", openFlag);
        mv.addObject("queryFlag", queryFlag);
//        带上考查方式
        return mv;
    }


    @ResponseBody
    @RequestMapping("/scoreMakeup/check")
    public Message check(String termId, String classId, String course, String scoreExamId, String flag) {
        if ("100".equals(flag)) {//判断是否是其他考试 如果是就不用校验
            ScoreImport scoreImport = new ScoreImport();
            scoreImport.setTermId(termId);
            scoreImport.setClassId(classId);
            scoreImport.setCourseId(course);
            scoreImport.setScoreExamId(scoreExamId);
            List<ScoreImport> data = scoreImportService.getScoreExamList(scoreImport);
            if (data.size() == 0) {
                return new Message(2, "提交失败", null);
            } else {
                scoreImportService.updateSubmitFlag(scoreImport);
                return new Message(1, "提交成功", null);
            }
        } else {
            List<String> list = scoreImportService.check(termId, classId, course);
            if (list.size() > 0 || "1".equals(flag)) {
                ScoreImport scoreImport = new ScoreImport();
                scoreImport.setTermId(termId);
                scoreImport.setClassId(classId);
                scoreImport.setCourseId(course);
                scoreImport.setScoreExamId(scoreExamId);
                List<ScoreImport> data = scoreImportService.getScoreExamList(scoreImport);
                if (data.size() == 0) {
                    return new Message(2, null, null);
                }
               /* else {
                    scoreImportService.updateSubmitFlag(scoreImport);
                }*/

                return new Message(1, null, null);
            } else {
                return new Message(0, null, null);
            }
        }

    }

    @ResponseBody
    @RequestMapping("/scoreMakeup/checkCount")
    public Message checkCount(Exam exam) {
        List<Exam> list = scoreImportService.getCount(exam);
        if (list.size() > 0) {
            return new Message(1, null, null);
        } else {
            return new Message(0, null, null);
        }
    }

    /**
     * 判断是否数字
     */
    public boolean isNumer(String str) {
        //Pattern pattern = Pattern.compile("[0-9]+.?[0-9]*");
        Pattern pattern = Pattern.compile("^[0-9]+(.[0-9]+)?$");

        Matcher isNum = pattern.matcher(str);
        if (!isNum.matches()) {
            return false;
        }
        return true;
    }


}
