package com.goisan.educational.score.service;

import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;

import java.util.List;

/**
 * Created by wq on 2017/10/12.
 */
public interface ScoreExamService {
    List<ScoreExam> getScoreExamList(ScoreExam scoreExam);
    ScoreExam getScoreExamById(String scoreExamId);
    void insertScoreExam(ScoreExam scoreExam);
    void updateScoreExamById(ScoreExam scoreExam);
    void deleteScoreExamById(String scoreExamId);
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
    List<ScoreImport> getScoreRoleByPersonId(String roleId,String id);
}
