package com.goisan.educational.exam.bean;

import com.goisan.system.bean.BaseBean;

public class ExamTopic extends BaseBean{
    private String id;//主键id

    private String semester;//学期

    private String examCourse;//考试科目

    private String examId;//考试名称
    private String examShow;

    private String departmentsId;//系部

    private String majorCode;//专业

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getExamCourse() {
        return examCourse;
    }

    public void setExamCourse(String examCourse) {
        this.examCourse = examCourse;
    }

    public String getExamId() {
        return examId;
    }

    public void setExamId(String examId) {
        this.examId = examId;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getExamShow() {
        return examShow;
    }

    public void setExamShow(String examShow) {
        this.examShow = examShow;
    }
}
