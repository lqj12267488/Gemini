package com.goisan.educational.course.service;

import com.goisan.educational.course.bean.Course;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.SelectGroupForExcel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CourseService {

    Integer selCourseCountByCN(String courseName);
    List<Course> getCourseByName(Course course);

    List<Course> selectList(Course course);

    void save(Course course);

    Course selectById(String id);

    void update(Course course);

    void del(String id);

    //返回的Select2的id属性值为专业id
    List<Select2> getMajorByDepId(String deptId);

    List<Select2> getMajorByDeptId(String deptId);

    List<Course> checkCourseName(Course course);

    String getMaxCourseCoding(Course course);

    List<SelectGroupForExcel> getDepartmentMajorList(@Param("type")String type);

    List<SelectGroupForExcel> getMajorClassList();

    String getMajorCodeByMajorName(String id);

    List<Course> selectCourseList(Course course);
}
