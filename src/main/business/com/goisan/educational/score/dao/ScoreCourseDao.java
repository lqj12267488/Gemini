package com.goisan.educational.score.dao;

import com.goisan.educational.score.bean.ScoreClass;
import com.goisan.educational.score.bean.ScoreCourse;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wq on 2017/10/12.
 */
public interface ScoreCourseDao {
    List<ScoreCourse> getScoreCourseList(ScoreCourse scoreCourse);
    List<Select2> getCourseByPlanAndClass(@Param("classInfo") String classInfo,@Param("term") String term);
    ScoreCourse getScoreCourseById(String subjectId);
    void insertScoreCourse(ScoreCourse scoreCourse);
    void updateScoreCourseById(ScoreCourse scoreCourse);
    void deleteScoreCourseById(String subjectId);
    List<Select2> getCourseByMajorShow(String majorShow);
    List<Select2> getCourseByType(String courseType);
    //关联教学计划导入
    void importCourse(ScoreCourse scoreCourse);
    void importClassPerson(ScoreCourse scoreCourse);
    //考试班级设置
    List<Tree> getClassTreeForScoreCourse();
    List<Tree> getClassTreeForPublishCourse();
    void insertScoreClass(ScoreClass scoreClass);
    List<ScoreClass> getClassBySubjectId(String subjectId);
    void deleteScoreClass(String scoreClassId);
    void deleteClassBySubjectId(String subjectId);
    void deleteScoreBySubjectId(String subjectId);
}
