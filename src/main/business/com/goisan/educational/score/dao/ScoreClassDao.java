package com.goisan.educational.score.dao;

import com.goisan.educational.score.bean.ScoreClass;
import com.goisan.educational.score.bean.ScoreCourse;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import com.goisan.system.bean.Tree;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/10/12.
 */
@Repository
public interface ScoreClassDao {
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
    void delScoreByClassId(String scoreClassId);
    void saveScoreClassAll(ScoreClass scoreClass);
    void updateScoreClassListByScoreClassId(String scoreClassId);
    void insertScoreClassSubject(ScoreCourse scoreCourse);
    List<Object> selectScoreClassSubjectId(String subjectId);
    void deleteScoreClassByClass(ScoreClass scoreClass);
    List<ScoreClass> getScoreClassByIds(@Param("scoreClassIds") String scoreClassIds);
    void updatePersonIdByScore(String scoreClassId);
    List<Select2> getScoreClassTableDict(TableDict tableDict);
}
