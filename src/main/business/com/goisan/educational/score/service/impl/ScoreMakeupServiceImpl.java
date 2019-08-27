package com.goisan.educational.score.service.impl;

import com.goisan.educational.exam.bean.ExamCourseClass;
import com.goisan.educational.exam.bean.ExamStudent;
import com.goisan.educational.exam.dao.ExamDao;
import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.dao.ScoreImportDao;
import com.goisan.educational.score.dao.ScoreMakeupDao;
import com.goisan.educational.score.service.ScoreImportService;
import com.goisan.educational.score.service.ScoreMakeupService;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DecimalFormat;
import java.util.*;

/**
 * Created by wq on 2017/10/16.
 */
@Service
public class ScoreMakeupServiceImpl implements ScoreMakeupService {
    @Resource
    private ScoreMakeupDao scoreMakeupDao;

    @Autowired
    private ScoreImportDao scoreImportDao;

    @Autowired
    private ExamDao examDao;

    @Autowired
    private CommonService commonService;

    @Autowired
    private ScoreImportService scoreImportService;

    public List<ScoreExam> getScoreMakeupExamList(ScoreExam scoreExam) {
        return scoreMakeupDao.getScoreMakeupExamList(scoreExam);
    }

    public List<ScoreImport> getScoreMakeupList(ScoreImport scoreImport) {
        return scoreMakeupDao.getScoreMakeupList(scoreImport);
    }

    public void updateScoreMakeup(ScoreImport scoreImport) {
        scoreMakeupDao.updateScoreMakeup(scoreImport);
    }

    public List<ScoreImport> getScoreGraduateMakeupList(ScoreImport scoreImport) {
        return scoreMakeupDao.getScoreGraduateMakeupList(scoreImport);
    }

    public void updateScoreGraduateMakeup(ScoreImport scoreImport) {
        scoreMakeupDao.updateScoreGraduateMakeup(scoreImport);
    }

    public ScoreImport seleteScoreMakeupById(String id) {
        return scoreMakeupDao.seleteScoreMakeupById(id);
    }

    public List<Select2> checkImportPerson(String deptId) {
        return scoreMakeupDao.checkImportPerson(deptId);
    }

    public List<Select2> getMajorAndLevelByDept(String deptId) {
        return scoreMakeupDao.getMajorAndLevelByDept(deptId);
    }

    public List<Select2> getClassByMajorAndLevel(String majorCode) {
        return scoreMakeupDao.getClassByMajorAndLevel(majorCode);
    }

    public List<Select2> getStudentByExam(String scoreExamId) {
        return scoreMakeupDao.getStudentByExam(scoreExamId);
    }

    public List<Select2> getClassByExam(String scoreExamId) {
        return scoreMakeupDao.getClassByExam(scoreExamId);
    }

    public List<Select2> getCourseByExam(String scoreExamId) {
        return scoreMakeupDao.getCourseByExam(scoreExamId);
    }

    @Override
    public void updateScore(String id, String type, String score) {
        ScoreImport scoreImport = scoreMakeupDao.getScoreById(id);
        if (null != scoreImport && scoreImport.getExaminationStatus().equals("4")) {
            scoreImport.setExaminationStatus(type);
            CommonUtil.update(scoreImport);
            scoreImport.setScore(score);
            scoreMakeupDao.updateScoreExaminationStatusScore(scoreImport);
        } else {
            scoreMakeupDao.updateScore(id, type, score);
        }
    }

    @Override
    public void saveGraduateScore(String id, String type, String score) {
        scoreMakeupDao.saveGraduateScore(id, type, score);
    }

    @Override
    public void saveAfterGraduateScore(String id, String type, String score) {
        scoreMakeupDao.saveAfterGraduateScore(id, type, score);
    }

    @Override
    public void delMakeupScore(String ids) {
        scoreMakeupDao.delMakeupScore(ids);
    }

    @Override
    public void delGraduateMakeupScore(String ids) {
        scoreMakeupDao.delGraduateMakeupScore(ids);
    }

    public List<ScoreImport> getScoreAfterGraduateMakeupList(ScoreImport schoolImport) {
        return scoreMakeupDao.getScoreAfterGraduateMakeupList(schoolImport);
    }

    public void updateScoreAfterGraduateMakeup(ScoreImport schoolImport) {
        scoreMakeupDao.updateScoreAfterGraduateMakeup(schoolImport);
    }

    public boolean checkExcelTr(HSSFSheet sheet, String type) {

        try {

            if (sheet != null && type != null && !"".equals(type)) {


                HSSFRow row = sheet.getRow(1);

                if (row != null) {

                    List<String> tempList = null;

                    if ("1".equals(type)) {

                        tempList = this.getExamTr1();

                    } else if ("2".equals(type)) {

                        tempList = this.getExamTr2();

                    } else if ("3".equals(type)) {

                        tempList = this.getExamTr3();

                    } else if ("4".equals(type)) {

                        tempList = this.getExamTr4();
                    }

                    if (tempList != null && tempList.size() > 0) {

                        for (int i = 0; i < tempList.size(); i++) {

                            HSSFCell cell = row.getCell(i);

                            if (cell != null) {

                                if (!tempList.contains(cell.toString().trim())) {

                                    return false;
                                }
                            }
                        }

                        return true;
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    private List<String> getExamTr1() {

        List<String> tempList = new ArrayList<>();

        tempList.add("序号");
        tempList.add("学期");
        tempList.add("学生姓名");
        tempList.add("身份证号");
        tempList.add("课程");
        tempList.add("学生到课情况(满分10分)");
        tempList.add("学生作业情况(满分10分)");
        tempList.add("学生测验情况(满分10分)");
        tempList.add("学生课上提问情况(满分10分)");
        tempList.add("考试状态");
        tempList.add("成绩");
        tempList.add("合格情况");
        tempList.add("班级");
        tempList.add("系部");
        tempList.add("专业");
        tempList.add("考试方式");

        return tempList;
    }

    private List<String> getExamTr2() {

        List<String> tempList = new ArrayList<>();

        tempList.add("序号");
        tempList.add("学期");
        tempList.add("学生姓名");
        tempList.add("身份证号");
        tempList.add("课程");
        tempList.add("补考状态");
        tempList.add("补考成绩");
        tempList.add("班级");
        tempList.add("系部");
        tempList.add("专业");
        tempList.add("考试方式");

        return tempList;
    }

    private List<String> getExamTr3() {

        List<String> tempList = new ArrayList<>();

        tempList.add("序号");
        tempList.add("学期");
        tempList.add("学生姓名");
        tempList.add("身份证号");
        tempList.add("课程");
        tempList.add("毕业前补考状态");
        tempList.add("毕业前补考成绩");
        tempList.add("合格情况");
        tempList.add("班级");
        tempList.add("系部");
        tempList.add("专业");
        tempList.add("考试方式");

        return tempList;
    }

    private List<String> getExamTr4() {

        List<String> tempList = new ArrayList<>();

        tempList.add("序号");
        tempList.add("学期");
        tempList.add("学生姓名");
        tempList.add("身份证号");
        tempList.add("课程");
        tempList.add("毕业后补考状态");
        tempList.add("毕业后补考成绩");
        tempList.add("合格情况");
        tempList.add("班级");
        tempList.add("系部");
        tempList.add("专业");
        tempList.add("考试方式");

        return tempList;
    }

    public Map<String, Object> getQueryList(HttpServletRequest request) {

        try {

            String scoreExamId = request.getParameter("scoreExamId");

            if (scoreExamId != null && !"".equals(scoreExamId)) {

                Map<String, Object> modelMap = new HashMap<>();

                ExamStudent examStudent = new ExamStudent();
                examStudent.setExamId(scoreExamId);
                List<ExamStudent> studentList = examDao.getExamStudentList(examStudent);

                if (studentList != null && studentList.size() > 0) {

                    //List<Select2> studentInfo = new ArrayList<>();
                    List<Select2> classInfo = new ArrayList<>();
                    List<Select2> majorInfo = new ArrayList<>();

                    //List<String> studentNotInList = new ArrayList<>();
                    List<String> classNotInList = new ArrayList<>();
                    List<String> majorNotInList = new ArrayList<>();

                    for (ExamStudent es : studentList) {

                        if (es != null) {

//                            if(!studentNotInList.contains(es.getStudentId())){
//
//                                Select2 stuSel = new Select2();
//                                stuSel.setId(es.getStudentId());
//                                stuSel.setText(es.getStudentName());
//
//                                studentInfo.add(stuSel);
//                                studentNotInList.add(es.getStudentId());
//                            }

                            if (!classNotInList.contains(es.getClassId())) {

                                Select2 classSel = new Select2();
                                classSel.setId(es.getClassId());
                                classSel.setText(es.getClassShow());

                                classInfo.add(classSel);
                                classNotInList.add(es.getClassId());
                            }

                            if (!majorNotInList.contains(es.getMajorCode())) {

                                Select2 majorSel = new Select2();
                                majorSel.setId(es.getMajorCode());
                                majorSel.setText(es.getMajorShow());

                                majorInfo.add(majorSel);
                                majorNotInList.add(es.getMajorCode());
                            }
                        }
                    }

                    //modelMap.put("studentSelect",studentInfo);
                    modelMap.put("classSelect", classInfo);
                    modelMap.put("majorSelect", majorInfo);
                }

                List<ExamCourseClass> examCourseClassList = examDao.getExamCourseClassByExamId(scoreExamId);

                if (examCourseClassList != null && examCourseClassList.size() > 0) {

                    List<Select2> courseInfo = new ArrayList<>();

                    List<String> courseNotInList = new ArrayList<>();

                    for (ExamCourseClass ec : examCourseClassList) {

                        if (ec != null) {

                            if (!courseNotInList.contains(ec.getCourseId())) {

                                Select2 courseSel = new Select2();
                                courseSel.setId(ec.getCourseId());
                                courseSel.setText(ec.getCourseShow() + "--" + ec.getTrainingLevelShow());

                                courseInfo.add(courseSel);
                                courseNotInList.add(ec.getCourseId());
                            }
                        }
                    }

                    modelMap.put("courseSelect", courseInfo);
                }

                modelMap.put("teacherSelect", scoreImportDao.getTeacherSelect(scoreExamId));

                return modelMap;
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    public Message saveScoreCon(HttpServletRequest request) {

        try {
            String type = request.getParameter("type");

            if ("1".equals(type)) {

                return this.saveScore1(request.getParameterMap().keySet(), request);

            } else {

                Message message = this.saveScore2(request.getParameterMap().keySet(), request);

//                if ("2".equals(type)) {
//
//                    scoreImportService.checkHuanKaoScore();
//                }

                return message;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return new Message(0, "操作失败，请稍后重试！", null);
    }

    /**
     * 提交成绩
     * @param request
     * @return
     */
    @Override
    @Transactional
    public Message sumbitScore(HttpServletRequest request) {
        Set<String> set = request.getParameterMap().keySet();
        if (set != null && set.size() > 0) {
            List<Select2> ksztList = commonService.getSysDict("KSZT", "");
            List<String> notInId = new ArrayList<>();
            for (String name : set) {
                if (name != null && !"".equals(name) && !"type".equals(name)) {
                    String[] arrStr = name.split("_");
                    if (arrStr.length == 2) {
                        String id = arrStr[1];

                        if (id != null && !"".equals(id) && !notInId.contains(id)) {
                            notInId.add(id);
//                            保存成绩，并提交
                            ScoreImport scoreImport = scoreImportDao.getScoreImportById(id);

                            if (scoreImport != null) {
                                if ("1".equals(scoreImport.getOpenFlag())) {
                                    continue;
                                }

                                String score;
                                String examScore = "0";
//                                score = request.getParameter("score_" + id);
                                String examinationStatus = request.getParameter("examinationStatus_" + id);

                                String peacetimeScoreA = "0";
                                String peacetimeScoreB = "0";
                                String peacetimeScoreC = "0";
                                String peacetimeScoreD = "0";

                                peacetimeScoreA = request.getParameter("peacetimeScoreA_" + id);
                                peacetimeScoreB = request.getParameter("peacetimeScoreB_" + id);
                                peacetimeScoreC = request.getParameter("peacetimeScoreC_" + id);
                                peacetimeScoreD = request.getParameter("peacetimeScoreD_" + id);

                                scoreImport.setExaminationStatus(examinationStatus);
                                String examMethod = scoreImport.getExamMethod();
                                if (!"2".equals(examMethod)) {
                                    if ("1".equals(examinationStatus)) {
//                                        examScore = request.getParameter("examScore_" + id);
//
//                                        Double examScorePar =  Double.parseDouble(peacetimeScoreA) +
//                                                Double.parseDouble(peacetimeScoreB) +
//                                                Double.parseDouble(peacetimeScoreC) + Double.parseDouble(peacetimeScoreD)
//                                                +Double.parseDouble(request.getParameter("examScore_" + id))*0.6;
//                                        DecimalFormat decimalFormat = new DecimalFormat("0.0");
//                                        score = decimalFormat.format(examScorePar);
//                                        scoreImport.setScore(score);
//                                        scoreImport.setExamScore(examScore);
                                        examScore = request.getParameter("examScore_" + id);
                                        DecimalFormat decimalFormat = new DecimalFormat("0.0");
                                        Double examScorePar = null;
                                        if (null==peacetimeScoreA && null == peacetimeScoreB  && null == peacetimeScoreC && null == peacetimeScoreD){
                                            if (null==scoreImport.getPeacetimeScoreA()&&null==scoreImport.getPeacetimeScoreB()&&null==scoreImport.getPeacetimeScoreC()&&null==scoreImport.getPeacetimeScoreD()) {
                                                examScorePar = Double.parseDouble(request.getParameter("examScore_" + id)) * 0.6;
                                            }else {
                                                examScorePar = Double.parseDouble(scoreImport.getPeacetimeScoreA()) +
                                                        Double.parseDouble(scoreImport.getPeacetimeScoreB()) +
                                                        Double.parseDouble(scoreImport.getPeacetimeScoreC()) + Double.parseDouble(scoreImport.getPeacetimeScoreD())
                                                        + Double.parseDouble(request.getParameter("examScore_" + id)) * 0.6;
                                            }
                                        }else {
                                            examScorePar = Double.parseDouble(peacetimeScoreA) +
                                                    Double.parseDouble(peacetimeScoreB) +
                                                    Double.parseDouble(peacetimeScoreC) + Double.parseDouble(peacetimeScoreD)
                                                    + Double.parseDouble(request.getParameter("examScore_" + id)) * 0.6;
                                        }
                                        score = decimalFormat.format(examScorePar);
                                        scoreImport.setScore(score);
                                        scoreImport.setExamScore(examScore);

                                        if (null != score && !"".equals(score)) {
                                            double scoreDouble = Double.parseDouble(score);
                                            if (scoreDouble < 60) {
                                                scoreImport.setScoreType("1");
                                            } else {
                                                scoreImport.setScoreType("0");
                                            }
                                        } else {
                                            scoreImport.setScoreType("1");
                                        }
                                } else {
                                        for (Select2 kszt:ksztList) {
                                            if (kszt.getId().equals(examinationStatus)){
                                                scoreImport.setScore(kszt.getText());
                                                scoreImport.setExamScore(kszt.getText());
                                            }
                                        }
                                    scoreImport.setScoreType("1");
                                }
                            }else {
//                                考查课
                                    if ("1".equals(examinationStatus)) {
                                        score = request.getParameter("score_" + id);
                                        scoreImport.setScore(score);
                                      if (!"不合格".equals(score)&&!"超旷".equals(score)){
                                          scoreImport.setScoreType("0");
                                      }else {
                                          scoreImport.setScoreType("1");
                                      }
                                    }else {
                                        scoreImport.setScore("不合格");
                                        scoreImport.setScoreType("1");
                                    }
                            }
                                if (null!=peacetimeScoreA && null != peacetimeScoreB  && null != peacetimeScoreC && null != peacetimeScoreD){
                                    scoreImport.setPeacetimeScoreA(peacetimeScoreA);
                                    scoreImport.setPeacetimeScoreB(peacetimeScoreB);
                                    scoreImport.setPeacetimeScoreC(peacetimeScoreC);
                                    scoreImport.setPeacetimeScoreD(peacetimeScoreD);
                                }
                                scoreImport.setChangeDept(CommonUtil.getDefaultDept());
                                scoreImport.setChanger(CommonUtil.getPersonId());
                                scoreImport.setSubmitFlag("1");
//                                更改
                                scoreImportDao.sumbitById(scoreImport);
                            }
                        }
                    }
                }
            }
        }
        return new Message(0,"提交成功",null);
    }

    /**
     * 提交补考
     * @param request
     * @return
     */
    @Override
    public Message sumbitMakeupScore(HttpServletRequest request) {
        Set<String> set = request.getParameterMap().keySet();
        if (set != null && set.size() > 0) {
//            补考成绩
            List<Select2> bkcj = commonService.getSysDict("BYQBKCJ", "");
            List<String> notInId = new ArrayList<>();
            for (String name : set) {
                if (name != null && !"".equals(name) && !"type".equals(name)) {
                    String[] arrStr = name.split("_");
                    if (arrStr.length == 2) {
                        String id = arrStr[1];
                        if (id != null && !"".equals(id) && !notInId.contains(id)) {
                            notInId.add(id);
//                            保存成绩，并提交
                            ScoreImport scoreImport = scoreImportDao.getScoreImportById(id);

                            if (scoreImport != null) {
                                if ("1".equals(scoreImport.getOpenFlag())) {
                                    continue;
                                }

                                String score;
                                score = request.getParameter("score_" + id);
                                String examinationStatus = request.getParameter("examinationStatus_" + id);
                                scoreImport.setExaminationStatus(examinationStatus);
                                if ("1".equals(examinationStatus)) {
                                    for (Select2 select2 : bkcj) {
                                        if (select2.getId().equals(score)) {
                                            scoreImport.setScore(select2.getText());
                                            if (score.equals("1")){
                                                scoreImport.setScoreType("0");
                                            }else {
                                                scoreImport.setScoreType("1");
                                            }
                                            break;
                                        }
                                    }
                                }else {
                                    scoreImport.setScore("补不及");
                                    scoreImport.setScoreType("1");
                                }
                                scoreImport.setSubmitFlag("1");
                                scoreImport.setPeacetimeScoreA("0");
                                scoreImport.setPeacetimeScoreB("0");
                                scoreImport.setPeacetimeScoreC("0");
                                scoreImport.setPeacetimeScoreD("0");
                                scoreImport.setChangeDept(CommonUtil.getDefaultDept());
                                scoreImport.setChanger(CommonUtil.getPersonId());
                                scoreImportDao.sumbitById(scoreImport);
                            }
                        }
                    }
                }
            }
        }
        return new Message(0,"提交成功",null);
    }

    private Message saveScore1(Set<String> set, HttpServletRequest request) {

        try {

            if (set != null && set.size() > 0) {

                List<String> notInId = new ArrayList<>();
//                考试状态
                List<Select2> ksztList = commonService.getSysDict("KSZT", "");

                for (String name : set) {

                    if (name != null && !"".equals(name) && !"type".equals(name)) {

                        String[] arrStr = name.split("_");

                        if (arrStr.length == 2) {

                            String id = arrStr[1];

                            if (id != null && !"".equals(id) && !notInId.contains(id)) {

                                notInId.add(id);

                                ScoreImport scoreImport = scoreImportDao.getScoreImportById(id);

                                if (scoreImport != null) {

                                    if ("1".equals(scoreImport.getOpenFlag())) {

                                        continue;
                                    }

                                    String examinationStatus = request.getParameter("examinationStatus_" + id);

                                    String examMethod = scoreImport.getExamMethod();

                                    String peacetimeScoreA = "0";
                                    String peacetimeScoreB = "0";
                                    String peacetimeScoreC = "0";
                                    String peacetimeScoreD = "0";
                                    peacetimeScoreA = request.getParameter("peacetimeScoreA_" + id);
                                    peacetimeScoreB = request.getParameter("peacetimeScoreB_" + id);
                                    peacetimeScoreC = request.getParameter("peacetimeScoreC_" + id);
                                    peacetimeScoreD = request.getParameter("peacetimeScoreD_" + id);

                                        String score = "0";
                                        String examScore = "0";
                                        if ("1".equals(examinationStatus)) {
                                            score = request.getParameter("score_" + id);
                                            if ("1".equals(examMethod)) {
//                                            修改考试成绩
//
                                                examScore = request.getParameter("examScore_" + id);
                                                DecimalFormat decimalFormat = new DecimalFormat("0.0");
                                                Double examScorePar = null;
                                                if (null == peacetimeScoreA && null == peacetimeScoreB && null == peacetimeScoreC && null == peacetimeScoreD) {
                                                    if (null == scoreImport.getPeacetimeScoreA() && null == scoreImport.getPeacetimeScoreB() && null == scoreImport.getPeacetimeScoreC() && null == scoreImport.getPeacetimeScoreD()) {
                                                        examScorePar = Double.parseDouble(request.getParameter("examScore_" + id)) * 0.6;
                                                    } else {
                                                        examScorePar = Double.parseDouble(scoreImport.getPeacetimeScoreA()) +
                                                                Double.parseDouble(scoreImport.getPeacetimeScoreB()) +
                                                                Double.parseDouble(scoreImport.getPeacetimeScoreC()) + Double.parseDouble(scoreImport.getPeacetimeScoreD())
                                                                + Double.parseDouble(request.getParameter("examScore_" + id)) * 0.6;
                                                    }
                                                } else {
                                                    examScorePar = Double.parseDouble(peacetimeScoreA) +
                                                            Double.parseDouble(peacetimeScoreB) +
                                                            Double.parseDouble(peacetimeScoreC) + Double.parseDouble(peacetimeScoreD)
                                                            + Double.parseDouble(request.getParameter("examScore_" + id)) * 0.6;
                                                }
                                                score = decimalFormat.format(examScorePar);
                                            }
                                        } else {
                                            if ("1".equals(examMethod)) {
                                                String es = "";
                                                for (Select2 select2 : ksztList) {
//                                            if (select2 != null) {
                                                    if (select2.getId().equals(examinationStatus)) {
                                                        es = select2.getText();
                                                        break;
                                                    }
//                                            }
                                                }
                                                score = es;
                                                examScore = es;
                                            }
                                            else {
                                                score = "不合格";
                                            }
                                        }
                                    if (null!=peacetimeScoreA && null != peacetimeScoreB  && null != peacetimeScoreC && null != peacetimeScoreD){
                                        scoreImport.setPeacetimeScoreA(peacetimeScoreA);
                                        scoreImport.setPeacetimeScoreB(peacetimeScoreB);
                                        scoreImport.setPeacetimeScoreC(peacetimeScoreC);
                                        scoreImport.setPeacetimeScoreD(peacetimeScoreD);
                                    }
                                    scoreImport.setScore(score);
                                    scoreImport.setExamScore(examScore);
                                    scoreImport.setExaminationStatus(examinationStatus);
                                    scoreImportDao.updateStudentImportInfo(scoreImport);
                                }
                            }
                        }
                    }
                }

                return new Message(1, "暂存成功！", null);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new Message(0, "操作失败，请稍后重试！", null);
    }

    private Message saveScore2(Set<String> set, HttpServletRequest request) {

        try {
            if (set != null && set.size() > 0) {
                List<String> notInId = new ArrayList<>();

//                Map<String, String> kszt = commonService.getSysDicValueMap("KSZT");
//                补考状态
                Map<String, String> bkzt = commonService.getSysDicValueMap("BKZT");
//                补考成绩
                Map<String, String> bkcj = commonService.getSysDicValueMap("BYQBKCJ");
                for (String name : set) {
                    if (name != null && !"".equals(name) && !"type".equals(name)) {
                        String[] arrStr = name.split("_");
                        if (arrStr.length == 2) {
                            String id = arrStr[1];
                            if (id != null && !"".equals(id) && !notInId.contains(id)) {
                                notInId.add(id);
                                ScoreImport scoreImport = scoreImportDao.getScoreImportById(id);
                                if (scoreImport != null) {
                                    if ("1".equals(scoreImport.getOpenFlag())) {
                                        continue;
                                    }
                                    String score;
                                    String scoreType;
                                    score = request.getParameter("score_" + id);
                                    String examinationStatus = request.getParameter("examinationStatus_" + id);
//                                    存字典值
                                    if ("1".equals(examinationStatus)) {
                                        if (!"".equals(score)&&score!=null) {
                                            scoreImport.setScore(bkcj.get(score));
                                        }
                                    } else {
                                            scoreImport.setScore(bkcj.get("2"));
                                    }
//                                    scoreImport.setScoreType(examinationStatus);
                                    scoreImport.setExaminationStatus(examinationStatus);
                                    scoreImportDao.updateStudentImportInfo(scoreImport);
                                }
                            }
                        }
                    }
                }
                return new Message(1, "保存成功！", null);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new Message(0, "操作失败，请稍后重试！", null);
    }

    public List<ExamStudent> checkStudentAndCourse(List<ExamStudent> examStudentList, String courseId, String examId, String classId) {
        try {
            if (examStudentList != null && examStudentList.size() > 0 && courseId != null && !"".equals(courseId)) {
                List<ExamStudent> realExamStudentList = new ArrayList<>();
                List<ExamCourseClass> examCourseClassList = examDao.getExamCourseClassByCourseId(courseId, examId, classId);
                if (examCourseClassList != null && examCourseClassList.size() > 0) {
                    Map<String, Map<String, ExamCourseClass>> classMap = new HashMap<>();
                    for (ExamCourseClass ecc : examCourseClassList) {
                        if (ecc != null) {
                            Map<String, ExamCourseClass> tempMap = classMap.get(ecc.getClassId());
                            if (tempMap == null) {
                                tempMap = new HashMap<>();
                            }
                            tempMap.put(ecc.getExamId(), ecc);
                            classMap.put(ecc.getClassId(), tempMap);
                        }
                    }
                    if (classMap.size() > 0) {
                        for (ExamStudent es : examStudentList) {
                            if (es != null) {
                                Map<String, ExamCourseClass> tempMap = classMap.get(es.getClassId());
                                if (tempMap != null && tempMap.size() > 0) {
                                    ExamCourseClass ecc = tempMap.get(es.getExamId());
                                    if (ecc != null) {
                                        realExamStudentList.add(es);
                                    }
                                }
                            }
                        }
                    }
                }
                return realExamStudentList;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return examStudentList;
    }

    @Override
    public Integer isSumbit(ScoreImport scoreImport) {
        return scoreMakeupDao.isSumbit(scoreImport)>0?1:0;
    }
}
