package com.goisan.educational.score.dao;

import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wq on 2017/10/12.
 */
@Repository
public interface ScoreExamDao {
    List<ScoreExam> getScoreExamList(ScoreExam scoreExam);
    ScoreExam getScoreExamById(String scoreExamId);
    void insertScoreExam(ScoreExam scoreExam);
    void updateScoreExamById(ScoreExam scoreExam);
    void deleteScoreExamById(String scoreExamId);
    void deleteSubjectByExamId(String scoreExamId);
    void deleteClassByExamId(String scoreExamId);
    void deleteScoreByExamId(String scoreExamId);
    void openScoreExam(String scoreExamId);
    List<ScoreExam> getOpenScoreExamList(ScoreExam scoreExam);
    List<ScoreImport> getOpenScoreList(ScoreImport scoreImport);
    List<ScoreExam> getScoreMakeupListByMakeup(ScoreExam scoreExam);
    //学生公开成绩查询
    List<ScoreImport> getStuOpenScoreExamList(ScoreImport scoreImport);
    //学生公开成绩详情列表
    List<ScoreImport> getStuOpenScoreList(ScoreImport scoreImport);
    //教师公开成绩查询
    List<ScoreImport> getTeaOpenScoreExamList(ScoreImport scoreImport);
    //教师公开成绩详情列表
    List<ScoreImport> getTeaOpenScoreList(ScoreImport scoreImport);
    //教师公开成绩三级详情列表
    List<ScoreImport> getTeaOpenScoreList2(ScoreImport scoreImport);
    /*查询教师角色*/
    List<ScoreImport> getScoreRoleByPersonId(@Param("roleId") String roleId,@Param("id") String id);
}
