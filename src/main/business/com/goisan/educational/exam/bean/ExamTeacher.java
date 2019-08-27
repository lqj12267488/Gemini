package com.goisan.educational.exam.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/8/9.
 */
public class ExamTeacher extends BaseBean {
    private String id;
    private String examId;
    private String teacherPersonId;
    private String teacherDeptId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getExamId() {
        return examId;
    }

    public void setExamId(String examId) {
        this.examId = examId;
    }

    public String getTeacherPersonId() {
        return teacherPersonId;
    }

    public void setTeacherPersonId(String teacherPersonId) {
        this.teacherPersonId = teacherPersonId;
    }

    public String getTeacherDeptId() {
        return teacherDeptId;
    }

    public void setTeacherDeptId(String teacherDeptId) {
        this.teacherDeptId = teacherDeptId;
    }



}
