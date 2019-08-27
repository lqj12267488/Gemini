package com.goisan.educational.score.dao;

import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.score.bean.ScoreClass;
import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.bean.StudentScore;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/10/14.
 */
@Repository
public interface ScoreImportDao {
    void sumbitById(ScoreImport scoreImport);
    List<ScoreImport> getScoreImportList(ScoreImport scoreImport);
    List<ScoreImport> getScoreImportListByIdAndSumbit(ScoreImport scoreImport);

    List<Exam> getCount(Exam exam);

    void updateSubmitFlag(ScoreImport scoreImport);

    List<ScoreImport> getScoreImportList2(ScoreImport scoreImport);

    List<ScoreImport> getScoreImportList3(ScoreImport scoreImport);

    List<ScoreImport> getScoreImportList4(ScoreImport scoreImport);

    List<ScoreImport> getScoreImportList5(ScoreImport scoreImport);

    ScoreImport getScoreImportById(String id);

    void insertScoreImport(ScoreImport scoreImport);

    void updateScoreImportById(ScoreImport scoreImport);

    void deleteScoreImportById(@Param("ids") String ids);

    List<ScoreClass> selectScoreClass(ScoreClass scoreClass);

    List<ScoreImport> getScoreClass(ScoreClass scoreClass);

    void insertScoreImportByScoreClass(ScoreClass scoreClass);

    List<ScoreClass> selectScoreClassByScoreClass(ScoreClass scoreClass);

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

    List<ScoreExam> getScoreHead(@Param("classId") String classId, @Param("examId") String examId);

    List<StudentScore> getScores(@Param("classId") String id, @Param("examId") String examId);

    List<ScoreImport> getScoreImportListByScoreImport(ScoreImport scoreImport);

    void updateScore(@Param("id") String id,
                     @Param("peacetimeScoreA") String peacetimeScoreA, @Param("peacetimeScoreB") String peacetimeScoreB,
                     @Param("peacetimeScoreC") String peacetimeScoreC, @Param("peacetimeScoreD") String peacetimeScoreD,
                     @Param("type") String type, @Param("score") String score);

    void delScore(@Param("ids") String ids);

    List<ScoreImport> getScoreImportByClassId(String classId);

    List<ScoreImport> getScoreImportByPersonId();

    String getPersonIdBySubjectIdScoreClassId(ScoreClass scoreClass);

    void updatePersonIdByScoreImport(ScoreImport scoreImport);

    /**
     * 学生个人成绩单查看
     *
     * @return
     */
    List<ScoreImport> getScoreByStudentIdScoreExamId(String studentId);

    List<ScoreImport> getTermIdByScoreExamId(String scoreExamId);

    List<ScoreImport> getTermIdByStudentIdScoreExamId(ScoreImport scoreImport);

    ScoreImport getStudentByStudentId(String studentId);

    List<ScoreImport> getCourseIdBy(String scoreExamId);

    ScoreImport getStudentById(String studentId);

    List<ScoreImport> getStudentScore(String studentId);

    List<Student> getStudentByStudent(String studentId);

    List<ScoreClass> getNoScoreSubject(String classId);

    List<ScoreImport> getCourseList(ScoreImport scoreImport);

    List<ScoreImport> getCourseClassScoreList(ScoreImport scoreImport);

    List<ScoreImport> getScoreStudentList(@Param("studentName") String studentName);

    List<ScoreImport> getScoreStudentImportList();

    ScoreImport getStudentImportInfo(ScoreImport scoreImport);

    void saveStudentImportInfo(ScoreImport scoreImport);

    void updateStudentImportInfo(ScoreImport scoreImport);

    List<Select2> getTeacherSelect(@Param("scoreExamId") String scoreExamId);

    List<ScoreImport> getOtherScoreImport(ScoreImport scoreImport);

    List<ScoreImport> getOtherScoreImport2(ScoreImport scoreImport);

    List<Map> getNoScoreStudent(@Param("examId") String examId, @Param("teacherId") String teacherId, @Param("classId") String classId);

    void updateOpenFlag(@Param("openFlag") String openFlag, @Param("teachingTeacherId") String teachingTeacherId, @Param("scoreExamId") String scoreExamId, @Param("classId") String classId, @Param("courseId") String courseId);

    List<Map<String, String>> getDetails(String id);

    List<Map<String, String>> getCourseClass(@Param("id") String id, @Param("personId") String personId);

    List<String> check(@Param("termId") String termId, @Param("classId") String classId, @Param("course") String course);

    List<ScoreImport> getExaminationStatus(@Param("studentId") String studentId, @Param("courseId") String courseId, @Param("termId") String termId);

    List<ScoreExam> getScoreClassList(ScoreImport scoreImport);

    List<ScoreImport> getScoreClasses(ScoreImport scoreImport);

    List<ScoreImport> getScoreCourse(ScoreImport scoreImport);

    List<ScoreImport> getScoreImport(String scoreExamId);
}
