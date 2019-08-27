package com.goisan.educational.courseplan.bean;


import com.goisan.system.bean.BaseBean;

public class CoursePlan extends BaseBean {

    private String planId;
    private String planName;
    private String departmentsId;
    private String majorId;
    private String majorShow;
    private String majorDirection;
    private String majorCode;
    private String trainingLevel;
    private String year;
    private String semester;
    private String teacherPersonId;
    private String personIdShow;

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }


    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }


    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }


    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
    }


    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMajorDirection() {
        return majorDirection;
    }

    public void setMajorDirection(String majorDirection) {
        this.majorDirection = majorDirection;
    }

    public String getMajorShow() {
        return majorShow;
    }

    public void setMajorShow(String majorShow) {
        this.majorShow = majorShow;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getTeacherPersonId() {
        return teacherPersonId;
    }

    public void setTeacherPersonId(String teacherPersonId) {
        this.teacherPersonId = teacherPersonId;
    }

    public String getPersonIdShow() {
        return personIdShow;
    }

    public void setPersonIdShow(String personIdShow) {
        this.personIdShow = personIdShow;
    }
}
