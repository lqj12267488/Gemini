package com.goisan.studentwork.studentrewardpunish.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by xuzhe on 2017/7/28.
 * modify by wq on 2017/9/19
 */
public class Grants extends BaseBean {
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
    private String grantType;
    private String grantSum;
    private String reportTerm;
    private String rewardpunishType;

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

    public String getGrantType() {
        return grantType;
    }

    public void setGrantType(String grantType) {
        this.grantType = grantType;
    }

    public String getGrantSum() {
        return grantSum;
    }

    public void setGrantSum(String grantSum) {
        this.grantSum = grantSum;
    }

    public String getReportTerm() {
        return reportTerm;
    }

    public void setReportTerm(String reportTerm) {
        this.reportTerm = reportTerm;
    }

    public String getRewardpunishType() {
        return rewardpunishType;
    }

    public void setRewardpunishType(String rewardpunishType) {
        this.rewardpunishType = rewardpunishType;
    }
}
