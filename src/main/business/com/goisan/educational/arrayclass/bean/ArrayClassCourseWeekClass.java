package com.goisan.educational.arrayclass.bean;

import com.goisan.system.bean.BaseBean;

public class ArrayClassCourseWeekClass extends BaseBean {
    private String arrayClassId;
    private String id;
    private String arrayClassCourseId;
    private String term;
    private String courseType;
    private String courseID;
    private String departmentsId;
    private String majorCode;
    private String classId;
    private String trainingLevel;


    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getArrayClassCourseId() {
        return arrayClassCourseId;
    }

    public void setArrayClassCourseId(String arrayClassCourseId) {
        this.arrayClassCourseId = arrayClassCourseId;
    }

    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    public String getCourseID() {
        return courseID;
    }

    public void setCourseID(String courseID) {
        this.courseID = courseID;
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

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getArrayClassId() {
        return arrayClassId;
    }

    public void setArrayClassId(String arrayClassId) {
        this.arrayClassId = arrayClassId;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
