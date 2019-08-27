package com.goisan.educational.exam.dao;

import com.goisan.educational.exam.bean.ExamTeacherCourse;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 123456 on 2018/4/24.
 */
@Repository
public interface ExamTeacherCourseDao {
    List<ExamTeacherCourse> getExamTeacherCourseList(ExamTeacherCourse examTeacherCourse);

    ExamTeacherCourse getExamTeacherCourseById(String id);

    void insertExamTeacherCourse(ExamTeacherCourse examTeacherCourse);

    void updateExamTeacherCourse(ExamTeacherCourse examTeacherCourse);

    void deleteExamTeacherCourse(ExamTeacherCourse examTeacherCourse);

    List<ExamTeacherCourse> getPersonIdDeptId(ExamTeacherCourse examTeacherCourse);
}
