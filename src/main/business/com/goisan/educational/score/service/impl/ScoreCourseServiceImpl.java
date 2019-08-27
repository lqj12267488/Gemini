package com.goisan.educational.score.service.impl;

import com.goisan.educational.score.bean.ScoreClass;
import com.goisan.educational.score.bean.ScoreCourse;
import com.goisan.educational.score.dao.ScoreCourseDao;
import com.goisan.educational.score.service.ScoreCourseService;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wq on 2017/10/12.
 */
@Service
public class ScoreCourseServiceImpl implements ScoreCourseService{
    @Resource
    private ScoreCourseDao scoreCourseDao;

    @Override
    public List<Select2> getCourseByPlanAndClass(String classInfo,String term) {
        return scoreCourseDao.getCourseByPlanAndClass(classInfo,term);
    }

    public List<ScoreCourse> getScoreCourseList(ScoreCourse scoreCourse){
        return scoreCourseDao.getScoreCourseList(scoreCourse);
    }
    public ScoreCourse getScoreCourseById(String subjectId){
        return scoreCourseDao.getScoreCourseById(subjectId);
    }
    public void insertScoreCourse(ScoreCourse scoreCourse){
        scoreCourseDao.insertScoreCourse(scoreCourse);
    }
    public void updateScoreCourseById(ScoreCourse scoreCourse){
        scoreCourseDao.updateScoreCourseById(scoreCourse);
    }
    public void deleteScoreCourseById(String subjectId){
        scoreCourseDao.deleteScoreCourseById(subjectId);
    }
    public List<Select2> getCourseByMajorShow(String majorShow) {
        return scoreCourseDao.getCourseByMajorShow(majorShow);
    }
    public List<Select2> getCourseByType(String courseType) {
        return scoreCourseDao.getCourseByType(courseType);
    }
    //关联教学计划导入
    public void importCourse(ScoreCourse scoreCourse){
        scoreCourseDao.importCourse(scoreCourse);
    }
    public void importClassPerson(ScoreCourse scoreCourse){
        scoreCourseDao.importClassPerson(scoreCourse);
    }
    //考试班级设置
    /*获取系部-专业-班级下拉树*/
    public List<Tree> getClassTreeForScoreCourse() {
        return scoreCourseDao.getClassTreeForScoreCourse();
    }
    public List<Tree> getClassTreeForPublishCourse() {
        return scoreCourseDao.getClassTreeForPublishCourse();
    }
    public List<ScoreClass> getClassBySubjectId(String subjectId) {
        return scoreCourseDao.getClassBySubjectId(subjectId);
    }
    //保存所选班级
    public void saveClassAll(ScoreClass scoreClass,String[] classIds){
        scoreCourseDao.deleteClassBySubjectId(scoreClass.getSubjectId());
        for (int i = 0 ; i < classIds.length ; i ++){
            if(classIds[i].length()!=6) {
                scoreClass.setScoreClassId(CommonUtil.getUUID());
                scoreClass.setClassId(classIds[i]);
                scoreClass.setCreator(CommonUtil.getPersonId());
                scoreClass.setCreateDept(CommonUtil.getDefaultDept());
                scoreCourseDao.insertScoreClass(scoreClass);
            }
        }
    }
    //通过课程主键ID删除考试班级
    public void deleteClassBySubjectId(String subjectId){
        scoreCourseDao.deleteClassBySubjectId(subjectId);
    }
    public void deleteScoreBySubjectId(String subjectId){
        scoreCourseDao.deleteScoreBySubjectId(subjectId);
    }
}
