package com.goisan.educational.score.service;

import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.score.bean.*;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.Message;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/10/14.
 */
public interface ScoreImportService {
    List<ScoreImport> getScoreImportList(ScoreImport scoreImport);

    List<Exam> getCount(Exam exam);

    void updateSubmitFlag(ScoreImport scoreImport);

    ScoreImport getScoreImportById(String id);

    void insertScoreImport(ScoreImport scoreImport);

    void updateScoreImportById(ScoreImport scoreImport);

    void deleteScoreImportById(String id);

    List<ScoreClass> selectScoreClass(ScoreClass scoreClass);

    List<ScoreImport> getScoreClass(ScoreClass scoreClass);

    void insertScoreImportByScoreClass(ScoreClass scoreClass);

    List<ScoreClass> selectScoreClassByScoreClass(ScoreClass scoreClass);

    @Transactional
    void saveScoreImport(ScoreClass scoreClass);

    void deleteScoreImportByScoreClass(ScoreClass scoreClass);

    String selectStudentIdByName(ScoreImport scoreImport);

    String selectExaminationStatus(String examinationStatus);

    Integer updateScoreImport(ScoreImport scoreImport);

    List<ScoreImport> getScoreList(ScoreImport scoreImport);

    List<ScoreImport> getScoreExamList(ScoreImport scoreImport);

    List<ScoreImport> getScoreCourseList(ScoreImport scoreImport);

    List<Student> getStudentListForScore(Student student);

    List<ScoreImport> getScoreListById(ScoreImport scoreImport);

    List<ScoreImport> getScoreListByStudentId(ScoreImport scoreImport);

    List<ScoreExam> getExamByTeacher(@Param("exam") ScoreExam exam, @Param("personId") String personId);

    ScoreImport getScoreExaminationStatus(String studentId);

    List<ScoreExam> getScoreHead(String id, String examId);

    List<StudentScore> getScores(String id, String examId);

    void updateScore(String id, String peacetimeScoreA, String peacetimeScoreB,
                     String peacetimeScoreC, String peacetimeScoreD, String type, String score);

    void delScore(String ids);

    List<ScoreImport> getScoreImportByClassId(String classId);

    String getPersonIdBySubjectIdScoreClassId(ScoreClass scoreClass);

    void updatePersonIdByScoreImport(ScoreImport scoreImport);

    List<ScoreImport> getScoreByStudentIdScoreExamId(String studentId);

    List<ScoreImport> getTermIdByStudentIdScoreExamId(ScoreImport scoreImport);

    List<ScoreImport> getTermIdByScoreExamId(String scoreExamId);

    ScoreImport getStudentByStudentId(String studentId);

    List<ScoreImport> getCourseIdBy(String scoreExamId);

    ScoreImport getStudentById(String studentId);

    List<ScoreImport> getStudentScore(String studentId);

    List<Student> getStudentByStudent(String studentId);

    List<ScoreClass> getNoScoreSubject(String classId);

    List<ScoreImport> getCourseList(ScoreImport scoreImport);

    List<ScoreImport> getCourseClassScoreList(ScoreImport scoreImport);

    List<ScoreImport> getScoreStudentList(String classId);

    List<ScoreImport> getScoreStudentImportList();

    List<ScoreImport> checkScoreImportListOther(List<ScoreImport> scoreImportList);

    boolean readScoreExcel(HttpServletRequest request, HttpServletResponse response);

    boolean readFailCountExcel(HttpServletRequest request, HttpServletResponse response);

    boolean checkHuanKaoScore();

    Message checkNotHaveScoreInfo(String examId, String classId, String messageStr);

    Message openScore(String examId, String classId, String courseId);

    List<Map<String, String>> getDetails(String id);

    List<Map<String, String>> getCourseClass(String id, String personId);
    List<Map<String, String>> getCourseClass2(String id,String personId);

    List<String> check(String termId, String classId, String course);

    List<ScoreImport> getExaminationStatus(@Param("studentId") String studentId, @Param("courseId") String courseId, @Param("termId") String termId);

    List<ScoreExam> getScoreClassList(ScoreImport scoreImport);

    List<ScoreImport> getScoreClasses(ScoreImport scoreImport);

    List<ScoreImport> getScoreCourse(ScoreImport scoreImport);

    List<ScoreImport> getScoreImport(String scoreExamId);
}