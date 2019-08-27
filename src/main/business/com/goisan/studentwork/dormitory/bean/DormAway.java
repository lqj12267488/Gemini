package com.goisan.studentwork.dormitory.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/11/15.
 */
public class DormAway extends BaseBean{
    private String id;
    private String dormId;
    private String departmentsId;
    private String majorCode;
    private String majorDirection;
    private String trainingLevel;
    private String classId;
    private String studentId;
    private String awayReason;
    private String awayTime;
    private String departmentShow;
    private String majorShow;
    private String classShow;
    private String studentName;
    private String dormName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDormId() {
        return dormId;
    }

    public void setDormId(String dormId) {
        this.dormId = dormId;
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

    public String getMajorDirection() {
        return majorDirection;
    }

    public void setMajorDirection(String majorDirection) {
        this.majorDirection = majorDirection;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getAwayReason() {
        return awayReason;
    }

    public void setAwayReason(String awayReason) {
        this.awayReason = awayReason;
    }

    public String getAwayTime() {
        return awayTime;
    }

    public void setAwayTime(String awayTime) {
        this.awayTime = awayTime;
    }

    public String getDepartmentShow() {
        return departmentShow;
    }

    public void setDepartmentShow(String departmentShow) {
        this.departmentShow = departmentShow;
    }

    public String getMajorShow() {
        return majorShow;
    }

    public void setMajorShow(String majorShow) {
        this.majorShow = majorShow;
    }

    public String getClassShow() {
        return classShow;
    }

    public void setClassShow(String classShow) {
        this.classShow = classShow;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getDormName() {
        return dormName;
    }

    public void setDormName(String dormName) {
        this.dormName = dormName;
    }
}
