package com.goisan.studentwork.graduatearchivesaddress.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created  By hanjie ON 2019/8/30
 */
public class StuArcad extends BaseBean {

    private String id;
    private String studentId;
    private String arcadId;
    private String arcadProvince;
    private String arcadProvinceShow;
    private String arcadCity;
    private String arcadCityShow;
    private String arcadCounty;
    private String arcadCountyShow;
    private String arcadDetail;

    private String studentIds;
    private String studentNames;
    private String studentName;
    private String classId;
    private String className;


    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getStudentNames() {
        return studentNames;
    }

    public void setStudentNames(String studentNames) {
        this.studentNames = studentNames;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentIds() {
        return studentIds;
    }

    public void setStudentIds(String studentIds) {
        this.studentIds = studentIds;
    }

    public String getArcadDetail() {
        return arcadDetail;
    }

    public void setArcadDetail(String arcadDetail) {
        this.arcadDetail = arcadDetail;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getArcadId() {
        return arcadId;
    }

    public void setArcadId(String arcadId) {
        this.arcadId = arcadId;
    }

    public String getArcadProvince() {
        return arcadProvince;
    }

    public void setArcadProvince(String arcadProvince) {
        this.arcadProvince = arcadProvince;
    }

    public String getArcadProvinceShow() {
        return arcadProvinceShow;
    }

    public void setArcadProvinceShow(String arcadProvinceShow) {
        this.arcadProvinceShow = arcadProvinceShow;
    }

    public String getArcadCity() {
        return arcadCity;
    }

    public void setArcadCity(String arcadCity) {
        this.arcadCity = arcadCity;
    }

    public String getArcadCityShow() {
        return arcadCityShow;
    }

    public void setArcadCityShow(String arcadCityShow) {
        this.arcadCityShow = arcadCityShow;
    }

    public String getArcadCounty() {
        return arcadCounty;
    }

    public void setArcadCounty(String arcadCounty) {
        this.arcadCounty = arcadCounty;
    }

    public String getArcadCountyShow() {
        return arcadCountyShow;
    }

    public void setArcadCountyShow(String arcadCountyShow) {
        this.arcadCountyShow = arcadCountyShow;
    }
}
