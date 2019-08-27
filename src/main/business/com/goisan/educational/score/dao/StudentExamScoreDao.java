package com.goisan.educational.score.dao;

import com.goisan.educational.score.bean.ScoreImport;

import java.util.List;

/**
 * Created by wq on 2017/10/18.
 */
public interface StudentExamScoreDao {
    List<ScoreImport> getStudentExamList(ScoreImport scoreImport);
    List<ScoreImport> getStudentExamClassList(ScoreImport scoreImport);
    List<ScoreImport> getStudentExamScoreList(ScoreImport scoreImport);
    List<ScoreImport> getExamRole(String loginid);
}
