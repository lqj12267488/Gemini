package com.goisan.studentwork.payment.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/10/23.
 */
public class CostMajor extends BaseBean{

    private String id;
    private String year;
    private String departmentsId;
    private String majorId;
    private String majorCode;
    private String majorDirection;
    private String trainingLevel;
    private String schoolSystem;
    private String majorFee;
    private String departmentShow;
    private String majorShow;
    private String trainingShow;
    private String systemShow;
    private String directionShow;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
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

    public String getSchoolSystem() {
        return schoolSystem;
    }

    public void setSchoolSystem(String schoolSystem) {
        this.schoolSystem = schoolSystem;
    }

    public String getMajorFee() {
        return majorFee;
    }

    public void setMajorFee(String majorFee) {
        this.majorFee = majorFee;
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

    public String getTrainingShow() {
        return trainingShow;
    }

    public void setTrainingShow(String trainingShow) {
        this.trainingShow = trainingShow;
    }

    public String getSystemShow() {
        return systemShow;
    }

    public void setSystemShow(String systemShow) {
        this.systemShow = systemShow;
    }

    public String getDirectionShow() {
        return directionShow;
    }

    public void setDirectionShow(String directionShow) {
        this.directionShow = directionShow;
    }
}
