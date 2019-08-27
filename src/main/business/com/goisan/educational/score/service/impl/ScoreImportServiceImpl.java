package com.goisan.educational.score.service.impl;

import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.exam.bean.ExamCourseClass;
import com.goisan.educational.exam.dao.ExamDao;
import com.goisan.educational.score.bean.ScoreClass;
import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.bean.StudentScore;
import com.goisan.educational.score.dao.ScoreImportDao;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.educational.score.service.ScoreImportService;
import com.goisan.educational.score.tools.ExportFailCount;
import com.goisan.educational.score.tools.ExportScoreInfo;
import com.goisan.educational.score.tools.MakeupCount;
import com.goisan.educational.teachingtask.bean.TeachingTask;
import com.goisan.educational.teachingtask.dao.TeachingTaskDao;
import com.goisan.system.bean.EmpDeptRelation;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
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
 * Created by Administrator on 2017/10/14.
 */
@Service
@Transactional
public class ScoreImportServiceImpl implements ScoreImportService {
    @Resource
    private ScoreImportDao scoreImportDao;

    @Resource
    private TeachingTaskDao teachingTaskDao;

    @Autowired
    private ScoreChangeService scoreChangeService;

    @Autowired
    private ExamDao examDao;

    public List<ScoreImport> getScoreImportList(ScoreImport scoreImport) {
        return scoreImportDao.getScoreImportList(scoreImport);
    }

    public List<Exam> getCount(Exam exam) {
        return scoreImportDao.getCount(exam);
    }

    public void updateSubmitFlag(ScoreImport scoreImport) {
        scoreImportDao.updateSubmitFlag(scoreImport);
    }

    public ScoreImport getScoreImportById(String id) {
        return scoreImportDao.getScoreImportById(id);
    }

    public void insertScoreImport(ScoreImport scoreImport) {
        scoreImportDao.insertScoreImport(scoreImport);
    }

    public void updateScoreImportById(ScoreImport scoreImport) {
        scoreImportDao.updateScoreImportById(scoreImport);
    }

    public void deleteScoreImportById(String id) {
        scoreImportDao.deleteScoreImportById(id);
    }

    public List<ScoreClass> selectScoreClass(ScoreClass scoreClass) {
        return scoreImportDao.selectScoreClass(scoreClass);
    }

    public List<ScoreImport> getScoreClass(ScoreClass scoreClass) {
        return scoreImportDao.getScoreClass(scoreClass);
    }

    public void insertScoreImportByScoreClass(ScoreClass scoreClass) {

        scoreImportDao.insertScoreImportByScoreClass(scoreClass);
    }

    public List<ScoreClass> selectScoreClassByScoreClass(ScoreClass scoreClass) {
        return scoreImportDao.selectScoreClassByScoreClass(scoreClass);

    }

    public void deleteScoreImportByScoreClass(ScoreClass scoreClass) {
        scoreImportDao.deleteScoreImportByScoreClass(scoreClass);
    }

    public void saveScoreImport(ScoreClass scoreClass) {
        List<ScoreClass> scoreClassList = scoreImportDao.selectScoreClassByScoreClass(scoreClass);
        for (ScoreClass list : scoreClassList) {
            scoreImportDao.insertScoreImportByScoreClass(list);
        }
    }

    public String selectStudentIdByName(ScoreImport scoreImport) {
        return scoreImportDao.selectStudentIdByName(scoreImport);
    }

    public String selectExaminationStatus(String examinationStatus) {
        return scoreImportDao.selectExaminationStatus(examinationStatus);
    }

    public Integer updateScoreImport(ScoreImport scoreImport) {
        return scoreImportDao.updateScoreImport(scoreImport);
    }

    public List<ScoreImport> getScoreList(ScoreImport scoreImport) {
        return scoreImportDao.getScoreList(scoreImport);
    }

    public List<ScoreImport> getScoreExamList(ScoreImport scoreImport) {
        return scoreImportDao.getScoreExamList(scoreImport);
    }

    public List<ScoreImport> getScoreCourseList(ScoreImport scoreImport) {
        return scoreImportDao.getScoreCourseList(scoreImport);
    }

    public List<Student> getStudentListForScore(Student student) {
        return scoreImportDao.getStudentListForScore(student);
    }

    public List<ScoreImport> getScoreListById(ScoreImport scoreImport) {
        return scoreImportDao.getScoreListById(scoreImport);
    }

    @Override
    public List<ScoreImport> getScoreListByStudentId(ScoreImport scoreImport) {
        return scoreImportDao.getScoreListByStudentId(scoreImport);
    }

    @Override
    public List<ScoreExam> getExamByTeacher(ScoreExam exam, String personId) {
        return scoreImportDao.getExamByTeacher(exam, personId);
    }

    public ScoreImport getScoreExaminationStatus(String studentId) {
        return scoreImportDao.getScoreExaminationStatus(studentId);
    }

    @Override
    public List<ScoreExam> getScoreHead(String id, String examId) {
        return scoreImportDao.getScoreHead(id, examId);
    }

    @Override
    public List<StudentScore> getScores(String id, String examId) {
        return scoreImportDao.getScores(id, examId);
    }

    @Override
    public void updateScore(String id, String peacetimeScoreA, String peacetimeScoreB,
                            String peacetimeScoreC, String peacetimeScoreD,
                            String type, String score) {
        scoreImportDao.updateScore(id, peacetimeScoreA, peacetimeScoreB,
                peacetimeScoreC, peacetimeScoreD, type, score);
    }

    @Override
    public void delScore(String ids) {
        scoreImportDao.delScore(ids);
    }

    public List<ScoreImport> getScoreImportByClassId(String classId) {
        return scoreImportDao.getScoreImportByClassId(classId);
    }

    public String getPersonIdBySubjectIdScoreClassId(ScoreClass scoreClass) {
        return scoreImportDao.getPersonIdBySubjectIdScoreClassId(scoreClass);
    }

    public void updatePersonIdByScoreImport(ScoreImport scoreImport) {
        scoreImportDao.updatePersonIdByScoreImport(scoreImport);
    }

    public List<ScoreImport> getScoreByStudentIdScoreExamId(String studentId) {
        return scoreImportDao.getScoreByStudentIdScoreExamId(studentId);
    }

    public List<ScoreImport> getTermIdByStudentIdScoreExamId(ScoreImport scoreImport) {
        return scoreImportDao.getTermIdByStudentIdScoreExamId(scoreImport);
    }

    public List<ScoreImport> getTermIdByScoreExamId(String scoreExamId) {
        return scoreImportDao.getTermIdByScoreExamId(scoreExamId);
    }

    public ScoreImport getStudentByStudentId(String studentId) {
        return scoreImportDao.getStudentByStudentId(studentId);
    }

    public List<ScoreImport> getCourseIdBy(String scoreExamId) {
        return scoreImportDao.getCourseIdBy(scoreExamId);
    }

    public ScoreImport getStudentById(String studentId) {
        return scoreImportDao.getStudentById(studentId);
    }

    public List<ScoreImport> getStudentScore(String studentId) {
        return scoreImportDao.getStudentScore(studentId);
    }

    public List<Student> getStudentByStudent(String studentId) {
        return scoreImportDao.getStudentByStudent(studentId);
    }

    public List<ScoreClass> getNoScoreSubject(String classId) {
        return scoreImportDao.getNoScoreSubject(classId);
    }

    public List<ScoreImport> getCourseList(ScoreImport scoreImport) {
        return scoreImportDao.getCourseList(scoreImport);
    }

    public List<ScoreImport> getCourseClassScoreList(ScoreImport scoreImport) {
        return scoreImportDao.getCourseClassScoreList(scoreImport);
    }

    public List<ScoreImport> getScoreStudentList(String classId) {
        return scoreImportDao.getScoreStudentList(classId);
    }

    public List<ScoreImport> getScoreStudentImportList() {
        return scoreImportDao.getScoreStudentImportList();
    }

    public List<ScoreImport> checkScoreImportListOther(List<ScoreImport> scoreImportList) {

        try {

            if (scoreImportList != null && scoreImportList.size() > 0) {

                for (ScoreImport scoreImport : scoreImportList) {

                    if (scoreImport != null) {

                        String finalScore = "无成绩";
                        String finalMakeupScore = "无成绩";
                        String finalBeforeMakeupScore = "无成绩";

                        String finalExaminationStatus = "";
                        String finalMakeupExaminationStatus = "";
                        String finalBeforeMakeupExaminationStatus = "";

                        List<ScoreImport> otherList = scoreImportDao.getOtherScoreImport(scoreImport);

                        if (otherList != null) {

                            for (ScoreImport si : otherList) {

                                if (si != null) {

                                    if ("1".equals(si.getExamTypes())) {

                                        finalScore = si.getScore();
                                        finalExaminationStatus = si.getExaminationStatus();

                                    } else if ("2".equals(si.getExamTypes())) {

                                        finalMakeupScore = si.getScore();
                                        finalMakeupExaminationStatus = si.getExaminationStatus();

                                    } else if ("3".equals(si.getExamTypes())) {

                                        finalBeforeMakeupScore = si.getScore();
                                        finalBeforeMakeupExaminationStatus = si.getExaminationStatus();

                                    }
                                }
                            }
                        }

                        scoreImport.setFinalScore(finalScore);
                        scoreImport.setFinalMakeupScore(finalMakeupScore);
                        scoreImport.setFinalBeforeMakeupScore(finalBeforeMakeupScore);

                        scoreImport.setFinalExaminationStatus(finalExaminationStatus);
                        scoreImport.setFinalMakeupExaminationStatus(finalMakeupExaminationStatus);
                        scoreImport.setFinalBeforeMakeupExaminationStatus(finalBeforeMakeupExaminationStatus);
                    }
                }

                return scoreImportList;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return scoreImportList;
    }

    public boolean readScoreExcel(HttpServletRequest request, HttpServletResponse response) {

        OutputStream os = null;

        try {

            String scoreExamId = request.getParameter("scoreExamId");

            if (scoreExamId != null && !"".equals(scoreExamId)) {


                ScoreImport scoreImport = new ScoreImport();

                scoreImport.setScoreExamId(scoreExamId);

                List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());

                if (list.size() == 0 && !CommonUtil.getPersonId().equals("sa")) {
                    scoreImport.setTeachingTeacherId(CommonUtil.getPersonId());
                }

//                List<ScoreImport> scoreImportList = scoreImportDao.getScoreImportList(scoreImport);

//                班级成绩单，提交过滤
                List<ScoreImport> scoreImportList = scoreImportDao.getScoreImportListByIdAndSumbit(scoreImport);

                response.setContentType("application/vnd.ms-excel");
                response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("班级成绩单.xls", "utf-8"));
                os = response.getOutputStream();

                ExportScoreInfo esi = new ExportScoreInfo();
                esi.writeScoreInfo(scoreImportList, os, "学生成绩报告表");

                return true;
            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {

                if (os != null) {

                    os.close();
                }

            } catch (IOException ioe) {

                ioe.printStackTrace();
            }
        }

        return false;
    }

    public boolean readFailCountExcel(HttpServletRequest request, HttpServletResponse response) {

        OutputStream os = null;

        try {

            String classId = request.getParameter("classId");
            String examId = request.getParameter("examId");
            String termId = request.getParameter("term");

            if (examId != null && !"".equals(examId)) {

                Exam exam = examDao.selectExamById(examId);

                if (exam != null) {

                    List<MakeupCount> makeupCountList = this.checkMakeupCountList(examId,classId,termId);

                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("期末补考后挂科数统计表.xls", "utf-8"));
                    os = response.getOutputStream();

                    ExportFailCount efc = new ExportFailCount();

                    efc.writeOutFailCount(makeupCountList, os, exam.getTermShow() + "期末补考后挂科数统计表", "期末补考后挂科数统计表");

                    return true;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {

                if (os != null) {

                    os.close();
                }

            } catch (IOException ioe) {

                ioe.printStackTrace();
            }
        }

        return false;
    }

    private List<MakeupCount> checkMakeupCountList(String examId,String classId,String termId) {

        try {

            if (examId != null && !"".equals(examId)) {

                ScoreImport queryObj = new ScoreImport();

                queryObj.setScoreExamId(examId);
//                queryObj.setScoreType("4");
                queryObj.setScoreType("1");
//                当前班级
                queryObj.setClassId(classId);

                List<ScoreImport> scoreImportList = scoreImportDao.getScoreImportList4(queryObj);

                if (scoreImportList != null && scoreImportList.size() > 0) {

                    List<MakeupCount> makeupCountList = new ArrayList<>();

                    Map<String, MakeupCount> makeupCountMap = new HashMap<>();

                    for (ScoreImport scoreImport : scoreImportList) {

                        if (scoreImport != null) {

                            String studentId = scoreImport.getStudentId();

                            boolean isFirst = true;

                            MakeupCount makeupCount = makeupCountMap.get(studentId);

                            if (makeupCount == null) {

                                makeupCount = new MakeupCount();
                                makeupCount.setFailNum(1);

                                if ("1".equals(scoreImport.getExamMethod())) {

                                    makeupCount.setKaoShiNum(1);
                                }

                            } else {

                                isFirst = false;

                                makeupCount.setFailNum(makeupCount.getFailNum() + 1);

                                if ("1".equals(scoreImport.getExamMethod())) {
                                    makeupCount.setKaoShiNum(makeupCount.getKaoShiNum() + 1);
                                }
                            }


                            if (isFirst) {

                                makeupCount.setStudentName(scoreImport.getStudentName());
                                makeupCount.setClassName(scoreImport.getClassShow());
                                makeupCount.setStudentNum(scoreImport.getStudentNum());

//                                ExamCourseClass ecc = new ExamCourseClass();
//                                ecc.setClassId(scoreImport.getClassId());
//                                ecc.setExamId(examId);
//                                List<ExamCourseClass> examCourseClassList = examDao.getExamCourseClassByExamIdAndClassId(ecc);
//
//                                if (examCourseClassList != null) {
//
//                                    makeupCount.setCourseNum(examCourseClassList.size());
//                                }
//                                考试科目 要加上考查课。
                                TeachingTask task = new TeachingTask();
                                task.setClassInfo(scoreImport.getClassId());
                                task.setSemester(termId);
                                List<TeachingTask> tasks = teachingTaskDao.getTeachingTaskList3(task);
                                if (tasks!=null){
                                    makeupCount.setCourseNum(tasks.size());
                                }

                                makeupCountMap.put(studentId, makeupCount);
                                makeupCountList.add(makeupCount);
                            }
                        }
                    }

                    return makeupCountList;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    public boolean checkHuanKaoScore() {

        try {

            ScoreImport scoreImport = new ScoreImport();
            scoreImport.setExaminationStatus("4");

            List<ScoreImport> scoreImportList = scoreImportDao.getScoreImportList5(scoreImport);

            if (scoreImportList != null && scoreImportList.size() > 0) {

                for (ScoreImport si : scoreImportList) {

                    if (si != null) {

                        List<ScoreImport> otherList = scoreImportDao.getOtherScoreImport2(si);

                        if (otherList != null && otherList.size() > 0) {

                            for (ScoreImport otSi : otherList) {

                                if (otSi != null) {

                                    Exam exam = examDao.selectExamById(otSi.getScoreExamId());

                                    if (exam != null && "2".equals(exam.getExamTypes())) {

                                        si.setScore(otSi.getScore());

                                        String scoreType;

                                        if ("3".equals(otSi.getScoreType())) {

                                            scoreType = "1";

                                        } else if ("4".equals(otSi.getScoreType())) {

                                            scoreType = "2";

                                        } else {

                                            scoreType = otSi.getScoreType();
                                        }

                                        si.setScoreType(scoreType);
                                        si.setExaminationStatus(otSi.getExaminationStatus());

                                        scoreImportDao.updateStudentImportInfo(si);
//                                        scoreImportDao.deleteScoreImportById("'"+otSi.getId()+"'");
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    public Message checkNotHaveScoreInfo(String examId, String classId, String messageStr) {

        try {

            if (examId != null && !"".equals(examId)) {

                List<Map> noScore = scoreImportDao.getNoScoreStudent(examId, CommonUtil.getPersonId(), classId);

                if (noScore != null && noScore.size() > 0) {

                    String noStr = "以下学生，还没有导入成绩：\n";

                    for (Map map : noScore) {

                        if (map != null) {

                            noStr += "姓名：" + map.get("STUDENTNAME") + " 班级：" + map.get("CLASSNAME") + " 科目：" + map.get("COURSENAME") + "\n";
                        }
                    }
                    return new Message(1, messageStr + "\n" + noStr, "success");

                } else {

                    return new Message(1, messageStr, "success");
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    public Message openScore(String examId, String classId, String courseId) {

        try {

            if (examId != null && !"".equals(examId)) {

                scoreImportDao.updateOpenFlag("1", CommonUtil.getPersonId(), examId, classId, courseId);
                return new Message(1, "发布成功", "success");
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return new Message(0, "操作失败，请稍后重试", "error");
    }

    @Override
    public List<Map<String, String>> getDetails(String id) {
        return scoreImportDao.getDetails(id);
    }

    @Override
    public List<Map<String, String>> getCourseClass(String id, String personId) {
        return scoreImportDao.getCourseClass(id, personId);
    }

    @Override
    public List<String> check(String termId, String classId, String course) {
        return scoreImportDao.check(termId, classId, course);
    }

    @Override
    public List<ScoreImport> getExaminationStatus(String studentId, String courseId, String termId) {
        return scoreImportDao.getExaminationStatus(studentId, courseId, termId);
    }

    @Override
    public List<ScoreExam> getScoreClassList(ScoreImport scoreImport) {
        return scoreImportDao.getScoreClassList(scoreImport);
    }

    @Override
    public List<ScoreImport> getScoreClasses(ScoreImport scoreImport) {
        return scoreImportDao.getScoreClasses(scoreImport);
    }

    @Override
    public List<ScoreImport> getScoreCourse(ScoreImport scoreImport) {
        return scoreImportDao.getScoreCourse(scoreImport);
    }

    @Override
    public List<ScoreImport> getScoreImport(String scoreExamId) {
        return scoreImportDao.getScoreImport(scoreExamId);
    }
}
