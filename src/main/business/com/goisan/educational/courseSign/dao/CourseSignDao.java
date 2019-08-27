package com.goisan.educational.courseSign.dao;

import com.goisan.educational.courseSign.bean.CourseSign;
import com.goisan.educational.courseSign.bean.CourseSignClass;
import com.goisan.system.bean.Tree;

import java.util.List;

/**
 * Created by admin on 2017/8/9.
 */
public interface CourseSignDao {

    void saveCourseSign(CourseSign sign);

    void updateCourseSign(CourseSign sign);

    void delCourseSign(String signId);

    CourseSign getCourseSignByid(String signId);

    List<CourseSign> getCourseSignList(CourseSign coursesign);

    List<CourseSignClass> getClassBySignId(String signId);

    CourseSignClass getCourseDetailsByOne(String signId);

    void saveCourseClass(CourseSignClass courseSignClass);

    void saveCourseClassAll(CourseSignClass courseSignClass);

    void updateCourseSignClass(CourseSignClass courseSignClass);

    void delCourseSignClass(String signId);

    List<Tree> getClassTreeBySign(String id);

    void updateSignListBySignId(String signId);
}
