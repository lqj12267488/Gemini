package com.goisan.studentwork.dormitory.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/8/21.
 */
public class DormAdjustResult extends BaseBean {
    private String id;
    private String dormId;
    private String classId;
    private String studentId;
    private String dormFlag;
    private String classShow;
    private String studentName;
    private String dormName;
    private String departmentsId;
    private String majorCode;
    private String trainingLevel;
    private String departmentShow;
    private String majorShow;

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

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getDormFlag() {
        return dormFlag;
    }

    public void setDormFlag(String dormFlag) {
        this.dormFlag = dormFlag;
    }


    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
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

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
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
}
