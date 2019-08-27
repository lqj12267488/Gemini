package com.goisan.educational.score.service;

import com.goisan.educational.score.bean.ScoreClass;
import com.goisan.educational.score.bean.ScoreCourse;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import com.goisan.system.bean.Tree;

import java.util.List;

/**
 * Created by Administrator on 2017/10/12.
 */
public interface ScoreClassService {
    List<ScoreClass> getScoreClassList(ScoreClass scoreClass);
    ScoreClass getScoreClassById(String scoreClassId);
    void insertScoreClass(ScoreClass scoreClass);
    void updateScoreClassById(ScoreClass scoreClass);
    void deleteScoreClassById(String scoreClassId);
    ScoreCourse selectScoreCourse(String subjectId);
    List<Tree> getClassTreeByScoreClass();
    List<ScoreClass> getClassByScoreClassId(String scoreClassId);
    List<ScoreClass> getClassByScoreId(String scoreClassId);
    void delScoreClass(String scoreClassId);
    void updateScoreClassListByScoreClassId(String scoreClassId);
    void saveClass(String[] tmp, String signId);
    void insertScoreClassSubject(ScoreCourse scoreCourse);
    List<Object> selectScoreClassSubjectId(String subjectId);
    void deleteScoreClassByClass(ScoreClass scoreClass);
    List<ScoreClass> getScoreClassByIds(String scoreClassIds);
    void updatePersonIdByScore(String scoreClassId);
    List<Select2> getScoreClassTableDict(TableDict tableDict);
}
