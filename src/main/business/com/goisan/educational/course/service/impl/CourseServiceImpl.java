package com.goisan.educational.course.service.impl;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.course.dao.CourseDao;
import com.goisan.educational.course.service.CourseService;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.SelectGroupForExcel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {
    @Resource
    private CourseDao courseDao;

    @Override
    public Integer selCourseCountByCN(String courseName) {
        return courseDao.selCourseCountByCN(courseName);
    }

    @Override
    public List<Course> getCourseByName(Course course) {
        return this.courseDao.getCourseByName(course);
    }

    public List<Course> selectList(Course course) {
        return courseDao.selectList(course);
    }

    public void save(Course course) {
        courseDao.save(course);
    }

    public Course selectById(String id) {
        return courseDao.selectById(id);
    }

    public void update(Course course) {
        courseDao.update(course);
    }

    public void del(String id) {
        courseDao.del(id);
    }

    //返回的Select2的id属性值为专业id
    public List<Select2> getMajorByDepId(String deptId){

        return courseDao.getMajorByDepId(deptId);
    }

    public List<Select2> getMajorByDeptId(String deptId){
        return courseDao.getMajorByDeptId(deptId);
    }

    public List<Course> checkCourseName(Course course){
        return courseDao.checkCourseName(course);
    }

    public String getMaxCourseCoding(Course course) {
        return courseDao.getMaxCourseCoding(course);
    }

    public List<SelectGroupForExcel> getDepartmentMajorList(String type) {
        return courseDao.getDepartmentMajorList(type);
    }

    public List<SelectGroupForExcel> getMajorClassList(){
        return courseDao.getMajorClassList();
    }

    public  String getMajorCodeByMajorName(String id){ return courseDao.getMajorCodeByMajorName(id);}

    @Override
    public List<Course> selectCourseList(Course course) {
        return courseDao.selectCourseList(course);
    }
}
