package com.goisan.studentwork.studentrewardpunish.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by wq on 2017/9/19.
 */
public class SchoolBurse extends BaseBean {
    private String id;
    private String studentId;
    private String departmentsId;
    private String majorCode;
    private String majorDirection;
    private String trainingLevel;
    private String majorShow;
    private String classId;
    private String sex;
    private String sexShow;
    private String idcard;
    private String title;
    private String burseSum;
    private String grantUnit;
    private String grantTime;
    private String rewardpunishType;
    private String nums;//人数
    private String type;//项目种类
    private String name;//项目全称
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

    public String getMajorShow() {
        return majorShow;
    }

    public void setMajorShow(String majorShow) {
        this.majorShow = majorShow;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getSexShow() {
        return sexShow;
    }

    public void setSexShow(String sexShow) {
        this.sexShow = sexShow;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBurseSum() {
        return burseSum;
    }

    public void setBurseSum(String burseSum) {
        this.burseSum = burseSum;
    }

    public String getGrantUnit() {
        return grantUnit;
    }

    public void setGrantUnit(String grantUnit) {
        this.grantUnit = grantUnit;
    }

    public String getGrantTime() {
        return grantTime;
    }

    public void setGrantTime(String grantTime) {
        this.grantTime = grantTime;
    }

    public String getRewardpunishType() {
        return rewardpunishType;
    }

    public void setRewardpunishType(String rewardpunishType) {
        this.rewardpunishType = rewardpunishType;
    }

    public String getNums() {
        return nums;
    }

    public void setNums(String nums) {
        this.nums = nums;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
