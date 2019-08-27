package com.goisan.educational.courseSign.service.impl;

import com.goisan.educational.courseSign.bean.CourseSign;
import com.goisan.educational.courseSign.bean.CourseSignClass;
import com.goisan.educational.courseSign.dao.CourseSignDao;
import com.goisan.educational.courseSign.service.CourseSignService;
import com.goisan.system.bean.Tree;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by admin on 2017/8/9.
 */
@Service
@Transactional
public class CourseSignServiceImpl implements CourseSignService {
    @Resource
    private CourseSignDao courseSignDao;

    public void saveCourseSign(CourseSign sign){
        courseSignDao.saveCourseSign(sign);
    }

    public void updateCourseSign(CourseSign sign){
        courseSignDao.updateCourseSign(sign);
    }

    public void delCourseSign(String signId){
        courseSignDao.delCourseSign(signId);
        courseSignDao.delCourseSignClass(signId);
    }

    public CourseSign getCourseSignByid(String signId){
        return courseSignDao.getCourseSignByid(signId);
    }

    public List<CourseSign> getCourseSignList(CourseSign coursesign){
        return courseSignDao.getCourseSignList(coursesign);
    }

    public CourseSignClass getCourseDetailsByOne(String signId) {
        return courseSignDao.getCourseDetailsByOne(signId);
    }

    public List<CourseSignClass> getClassBySignId(String signId) {
        return courseSignDao.getClassBySignId(signId);
    }

    public void saveCourseClass(CourseSignClass courseSignClass) {
        courseSignDao.saveCourseClass(courseSignClass);
    }

    public void saveCourseClassAll(CourseSignClass courseSignClass) {
        courseSignDao.saveCourseClassAll(courseSignClass);
    }

    public void updateCourseSignClass(CourseSignClass courseSignClass) {
        courseSignDao.updateCourseSignClass(courseSignClass);
    }

    public List<Tree> getClassTreeBySign(String id) {
        return courseSignDao.getClassTreeBySign(  id);
    }

    public void saveClass(String[] tmp, String signId){
        CourseSignClass courseSignClass = courseSignDao.getClassBySignId(signId).get(0);
        System.out.println(courseSignClass.getDepartmentsId());
        courseSignDao.delCourseSignClass(signId);
        for (int i = 0 ; i < tmp.length ; i ++){
            courseSignClass.setClassId(tmp[i]);
            courseSignClass.setId(CommonUtil.getUUID());
            courseSignDao.saveCourseClassAll(courseSignClass);
        }
        courseSignDao.updateSignListBySignId(signId);
    }

}
