package com.goisan.studentwork.studentinsurance.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created  By hanjie ON 2019/8/28
 */
public class StudentInsurance extends BaseBean {

    private String id;
    private String studentId;
    private String studentShow;
    private String dormId;
    private String dormName;
    private String idcard;
    private String sex;
    private String sexShow;
    private String name;
    private String studentNumber;
    private String classId;
    private String classShow;
    private String nation;
    private String nationShow;

    private String insuranceType;
    private String birthday;
    private String stuSourceAddr;

    public String getDormName() {
        return dormName;
    }

    public void setDormName(String dormName) {
        this.dormName = dormName;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getStuSourceAddr() {
        return stuSourceAddr;
    }

    public void setStuSourceAddr(String stuSourceAddr) {
        this.stuSourceAddr = stuSourceAddr;
    }

    public String getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(String studentNumber) {
        this.studentNumber = studentNumber;
    }

    public StudentInsurance() {
    }

    public String getSexShow() {
        return sexShow;
    }

    public void setSexShow(String sexShow) {
        this.sexShow = sexShow;
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

    public String getStudentShow() {
        return studentShow;
    }

    public void setStudentShow(String studentShow) {
        this.studentShow = studentShow;
    }

    public String getDormId() {
        return dormId;
    }

    public void setDormId(String dormId) {
        this.dormId = dormId;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getNationShow() {
        return nationShow;
    }

    public void setNationShow(String nationShow) {
        this.nationShow = nationShow;
    }

    public String getInsuranceType() {
        return insuranceType;
    }

    public void setInsuranceType(String insuranceType) {
        this.insuranceType = insuranceType;
    }
}
