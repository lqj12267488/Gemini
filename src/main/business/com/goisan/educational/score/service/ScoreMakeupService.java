package com.goisan.educational.score.service;

import com.goisan.educational.exam.bean.ExamStudent;
import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.system.bean.Select2;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by wq on 2017/10/16.
 */
@Service
public interface ScoreMakeupService {
    List<ScoreExam> getScoreMakeupExamList(ScoreExam scoreExam);

    List<ScoreImport> getScoreMakeupList(ScoreImport scoreImport);

    void updateScoreMakeup(ScoreImport scoreImport);

    List<ScoreImport> getScoreGraduateMakeupList(ScoreImport schoolImport);

    void updateScoreGraduateMakeup(ScoreImport scoreImport);

    ScoreImport seleteScoreMakeupById(String id);

    List<Select2> checkImportPerson(String deptId);

    List<Select2> getMajorAndLevelByDept(String deptId);

    List<Select2> getClassByMajorAndLevel(String majorCode);

    List<Select2> getStudentByExam(String scoreExamId);

    List<Select2> getClassByExam(String scoreExamId);

    List<Select2> getCourseByExam(String scoreExamId);

    void updateScore(String id, String datum, String datum1);

    void saveGraduateScore(String id, String datum, String datum1);

    void saveAfterGraduateScore(String id, String datum, String datum1);

    void delMakeupScore(String ids);

    void delGraduateMakeupScore(String ids);

    List<ScoreImport> getScoreAfterGraduateMakeupList(ScoreImport schoolImport);

    void updateScoreAfterGraduateMakeup(ScoreImport schoolImport);

    boolean checkExcelTr(HSSFSheet sheet, String type);

    Map<String,Object> getQueryList(HttpServletRequest request);

    Message saveScoreCon(HttpServletRequest request);

    Message sumbitScore(HttpServletRequest request);
    Message sumbitMakeupScore(HttpServletRequest request);

    List<ExamStudent> checkStudentAndCourse(List<ExamStudent> examStudentList, String courseId, String scoreExamId, String classId);

    Integer isSumbit(ScoreImport scoreImport);
}
