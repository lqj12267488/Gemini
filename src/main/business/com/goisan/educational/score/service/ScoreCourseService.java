package com.goisan.educational.score.service;

import com.goisan.educational.score.bean.ScoreClass;
import com.goisan.educational.score.bean.ScoreCourse;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;

import java.util.List;

/**
 * Created by wq on 2017/10/12.
 */
public interface ScoreCourseService {
    List<Select2> getCourseByPlanAndClass(String classInfo,String term);
    List<ScoreCourse> getScoreCourseList(ScoreCourse scoreCourse);
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
    List<ScoreClass> getClassBySubjectId(String subjectId);
    void deleteClassBySubjectId(String subjectId);
    void deleteScoreBySubjectId(String subjectId);
    void saveClassAll(ScoreClass scoreClass, String[] classIds);
}
