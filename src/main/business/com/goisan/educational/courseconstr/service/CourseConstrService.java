package com.goisan.educational.courseconstr.service;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.courseconstr.bean.CourseConstr;
import com.goisan.system.bean.Select2;

import java.util.List;

public interface CourseConstrService {

    List<CourseConstr> selectList(CourseConstr courseConstr);

    void save(CourseConstr courseConstr);

    CourseConstr selectById(String id);

    void update(CourseConstr courseConstr);

    void del(String id);


    List<CourseConstr> checkCourseConstrName(CourseConstr courseConstr);

    List<CourseConstr> selectListMajor(CourseConstr courseConstr);

    void saveMajor(CourseConstr courseConstr);

    CourseConstr selectMajorById(String id);

    void updateMajor(CourseConstr courseConstr);

    void delMajor(String id);

    List<CourseConstr> checkCourseConstrMajorName(CourseConstr courseConstr);


}
