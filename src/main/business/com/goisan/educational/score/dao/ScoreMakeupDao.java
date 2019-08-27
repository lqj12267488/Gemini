package com.goisan.educational.score.dao;

import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.system.bean.Select2;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wq on 2017/10/16.
 */

public interface ScoreMakeupDao {
    List<ScoreExam> getScoreMakeupExamList(ScoreExam scoreExam);

    List<ScoreImport> getScoreMakeupList(ScoreImport schoolImport);

    void updateScoreMakeup(ScoreImport schoolImport);

    List<ScoreImport> getScoreGraduateMakeupList(ScoreImport schoolImport);

    void updateScoreGraduateMakeup(ScoreImport schoolImport);

    ScoreImport seleteScoreMakeupById(String id);

    List<Select2> checkImportPerson(String deptId);

    List<Select2> getMajorAndLevelByDept(String deptId);

    List<Select2> getClassByMajorAndLevel(String majorCode);

    List<Select2> getStudentByExam(String scoreExamId);

    List<Select2> getClassByExam(String scoreExamId);

    List<Select2> getCourseByExam(String scoreExamId);

    void updateScore(@Param("id") String id, @Param("type") String type, @Param("score") String score);

    ScoreImport getScoreById(@Param("id") String id);

    void updateScoreExaminationStatusScore(ScoreImport scoreImport);

    void saveGraduateScore(@Param("id") String id, @Param("type") String type, @Param("score") String score);

    void saveAfterGraduateScore(@Param("id") String id, @Param("type") String type, @Param("score") String score);

    void delMakeupScore(@Param("ids") String ids);

    void delGraduateMakeupScore(@Param("ids") String ids);

    List<ScoreImport> getScoreAfterGraduateMakeupList(ScoreImport schoolImport);

    void updateScoreAfterGraduateMakeup(ScoreImport schoolImport);

    Integer isSumbit(ScoreImport scoreImport);

}
