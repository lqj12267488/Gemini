package com.goisan.educational.exam.service;

import com.goisan.educational.exam.bean.ExamTeacherCourse;

import java.util.List;

/**
 * Created by 123456 on 2018/4/24.
 */
public interface ExamTeacherCourseService {

    List<ExamTeacherCourse> getExamTeacherCourseList(ExamTeacherCourse examTeacherCourse);

    ExamTeacherCourse getExamTeacherCourseById(String id);

    void insertExamTeacherCourse(ExamTeacherCourse examTeacherCourse);

    void updateExamTeacherCourse(ExamTeacherCourse examTeacherCourse);

    void deleteExamTeacherCourse(ExamTeacherCourse examTeacherCourse);

    List<ExamTeacherCourse> getPersonIdDeptId(ExamTeacherCourse examTeacherCourse);
}
