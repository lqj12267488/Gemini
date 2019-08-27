package com.goisan.educational.courseconstr.service.impl;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.course.dao.CourseDao;
import com.goisan.educational.course.service.CourseService;
import com.goisan.educational.courseconstr.bean.CourseConstr;
import com.goisan.educational.courseconstr.dao.CourseConstrDao;
import com.goisan.educational.courseconstr.service.CourseConstrService;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CourseConstrServiceImpl implements CourseConstrService {
    @Resource
    private CourseConstrDao courseConstrDao;

     public List<CourseConstr> selectList(CourseConstr courseConstr){
         return courseConstrDao.selectList(courseConstr);
     };

     public void save(CourseConstr courseConstr){
         courseConstrDao.save(courseConstr);
     };

    public CourseConstr selectById(String id){
       return courseConstrDao.selectById(id);
    };

    public void update(CourseConstr courseConstr){
        courseConstrDao.update(courseConstr);
    };

    public void del(String id){
        courseConstrDao.del(id);
    };

    public List<CourseConstr> checkCourseConstrName(CourseConstr courseConstr){
        return courseConstrDao.checkCourseConstrName(courseConstr);
    };


    public List<CourseConstr> selectListMajor(CourseConstr courseConstr){
        return courseConstrDao.selectListMajor(courseConstr);
    };

    public void saveMajor(CourseConstr courseConstr){
        courseConstrDao.saveMajor(courseConstr);
    };

    public CourseConstr selectMajorById(String id){
        return courseConstrDao.selectMajorById(id);
    };

    public void updateMajor(CourseConstr courseConstr){
        courseConstrDao.updateMajor(courseConstr);
    };

    public void delMajor(String id){
        courseConstrDao.delMajor(id);
    };

    public List<CourseConstr> checkCourseConstrMajorName(CourseConstr courseConstr){
        return courseConstrDao.checkCourseConstrMajorName(courseConstr);
    };





}
