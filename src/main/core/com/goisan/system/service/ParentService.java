package com.goisan.system.service;

import com.goisan.educational.teachingresult.bean.TeachingResult;
import com.goisan.system.bean.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

public interface ParentService {

    List<BaseBean> getParentList(BaseBean baseBean);

    void saveParent(BaseBean baseBean);

    BaseBean getParentById(String id);

    void updateParent(BaseBean baseBean);

    void delParent(String id);

    String checkParentIdcard(String idcard);

    List<Tree> getParsonStudentTree(String roleId);

    List<Tree> getSurveyParsonTree(String surveyId);

    List<TeacherBean> getCourseTeacherList(List ids);

    List<TeacherBean> getCourseListByTeacher(String teacherId);

    @Transactional
    List<Map> getScoreExamCourseList(String studentId,List<Select2> className);

    void updateStudentId(Parent baseBean);
}