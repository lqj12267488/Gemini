package com.goisan.system.dao;

import com.goisan.educational.teachingresult.bean.TeachingResult;
import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ParentDao {

    List<BaseBean> getParentList(BaseBean baseBean);

    void saveParent(BaseBean baseBean);

    BaseBean getParentById(String id);

    void updateParent(BaseBean baseBean);

    void delParent(String id);

    String checkParentIdcard(String idcard);

    List<Tree> getParsonStudentTree(String roleId);

    List<Tree> getSurveyParsonTree(String surveyId);

    List<Tree> getSurveyTeacherTree(String surveyId);

    List<Tree> getSurveyStudentTree(String surveyId);

    List<TeacherBean> getCourseTeacherList( @Param("ids")List ids);

    List<TeacherBean> getCourseListByTeacher(String teacherId);

    void updateStudentId(Parent parent);
}
