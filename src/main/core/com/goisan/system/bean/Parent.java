package com.goisan.system.bean;

import com.goisan.system.bean.BaseBean;

public class Parent extends BaseBean {

    private String parentNameSecond; //父母或监护人2姓名
    private String idCardType; //父母或监护人1身份证件类型
    private String idCardTypeSecond; //父母或监护人2身份证件类型
    private String idcardSecond; //父母或监护人2身份证件号码
    private String parentTelSecond; //父母或监护人2联系方式
    private String parentId;
    private String parentName;
    private String idcard;
    private String parentTel;
    private String studentName;
    private String idCardTypeShow;
    private String idCardTypeSecondShow;
    private String studentId;

    public String getHouseholdRegisterPlace() {
        return householdRegisterPlace;
    }

    public void setHouseholdRegisterPlace(String householdRegisterPlace) {
        this.householdRegisterPlace = householdRegisterPlace;
    }

    private String householdRegisterPlace;

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getIdCardTypeShow() {
        return idCardTypeShow;
    }

    public void setIdCardTypeShow(String idCardTypeShow) {
        this.idCardTypeShow = idCardTypeShow;
    }

    public String getIdCardTypeSecondShow() {
        return idCardTypeSecondShow;
    }

    public void setIdCardTypeSecondShow(String idCardTypeSecondShow) {
        this.idCardTypeSecondShow = idCardTypeSecondShow;
    }



    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getParentNameSecond() {
        return parentNameSecond;
    }

    public void setParentNameSecond(String parentNameSecond) {
        this.parentNameSecond = parentNameSecond;
    }

    public String getIdCardType() {
        return idCardType;
    }

    public void setIdCardType(String idCardType) {
        this.idCardType = idCardType;
    }

    public String getIdCardTypeSecond() {
        return idCardTypeSecond;
    }

    public void setIdCardTypeSecond(String idCardTypeSecond) {
        this.idCardTypeSecond = idCardTypeSecond;
    }

    public String getIdcardSecond() {
        return idcardSecond;
    }

    public void setIdcardSecond(String idcardSecond) {
        this.idcardSecond = idcardSecond;
    }

    public String getParentTelSecond() {
        return parentTelSecond;
    }

    public void setParentTelSecond(String parentTelSecond) {
        this.parentTelSecond = parentTelSecond;
    }


    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getParentTel() {
        return parentTel;
    }

    public void setParentTel(String parentTel) {
        this.parentTel = parentTel;
    }
}
