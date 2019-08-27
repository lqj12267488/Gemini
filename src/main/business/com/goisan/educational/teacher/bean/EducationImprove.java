package com.goisan.educational.teacher.bean;

import com.goisan.system.bean.BaseBean;

public class EducationImprove extends BaseBean {
    private String teacherId;
    private String personId;
    private String teacherName;
    private String education;
    private String degee;
    private String finishSchool;
    private String major;
    private String majorShow;
    private String getTime;
    private String teacherNameShow;

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getMajorShow() {
        return majorShow;
    }

    public void setMajorShow(String majorShow) {
        this.majorShow = majorShow;
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

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getDegee() {
        return degee;
    }

    public void setDegee(String degee) {
        this.degee = degee;
    }

    public String getFinishSchool() {
        return finishSchool;
    }

    public void setFinishSchool(String finishSchool) {
        this.finishSchool = finishSchool;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getGetTime() {
        return getTime;
    }

    public void setGetTime(String getTime) {
        this.getTime = getTime;
    }

    public String getTeacherNameShow() {
        return teacherNameShow;
    }

    public void setTeacherNameShow(String teacherNameShow) {
        this.teacherNameShow = teacherNameShow;
    }
}
