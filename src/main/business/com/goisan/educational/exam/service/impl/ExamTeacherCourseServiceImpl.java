package com.goisan.educational.exam.service.impl;

import com.goisan.educational.exam.bean.ExamTeacherCourse;
import com.goisan.educational.exam.dao.ExamTeacherCourseDao;
import com.goisan.educational.exam.service.ExamTeacherCourseService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 123456 on 2018/4/24.
 */
@Service
public class ExamTeacherCourseServiceImpl implements ExamTeacherCourseService {
    @Resource
    private ExamTeacherCourseDao examTeacherCourseDao;

    public List<ExamTeacherCourse> getExamTeacherCourseList(ExamTeacherCourse examTeacherCourse){
        return examTeacherCourseDao.getExamTeacherCourseList(examTeacherCourse);
    }

    public ExamTeacherCourse getExamTeacherCourseById(String id){
        return examTeacherCourseDao.getExamTeacherCourseById(id);
    }

    public void insertExamTeacherCourse(ExamTeacherCourse examTeacherCourse){
        examTeacherCourseDao.insertExamTeacherCourse(examTeacherCourse);
    }

    public void updateExamTeacherCourse(ExamTeacherCourse examTeacherCourse){
        examTeacherCourseDao.updateExamTeacherCourse(examTeacherCourse);
    }

    public void deleteExamTeacherCourse(ExamTeacherCourse examTeacherCourse){
        examTeacherCourseDao.deleteExamTeacherCourse(examTeacherCourse);
    }

    public List<ExamTeacherCourse> getPersonIdDeptId(ExamTeacherCourse examTeacherCourse){
        return examTeacherCourseDao.getPersonIdDeptId(examTeacherCourse);
    }
}
