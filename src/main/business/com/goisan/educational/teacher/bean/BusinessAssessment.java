package com.goisan.educational.teacher.bean;

import com.goisan.system.bean.BaseBean;

public class BusinessAssessment extends BaseBean {
    private String teacherId;
    private String teacherName;
    private String assessmentContent;
    private String assessmentTime;
    private String assessmentResult;
    private String teacherNameShow;
    private String personId;

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getAssessmentContent() {
        return assessmentContent;
    }

    public void setAssessmentContent(String assessmentContent) {
        this.assessmentContent = assessmentContent;
    }

    public String getAssessmentTime() {
        return assessmentTime;
    }

    public void setAssessmentTime(String assessmentTime) {
        this.assessmentTime = assessmentTime;
    }

    public String getAssessmentResult() {
        return assessmentResult;
    }

    public void setAssessmentResult(String assessmentResult) {
        this.assessmentResult = assessmentResult;
    }

    public String getTeacherNameShow() {
        return teacherNameShow;
    }

    public void setTeacherNameShow(String teacherNameShow) {
        this.teacherNameShow = teacherNameShow;
    }
}
