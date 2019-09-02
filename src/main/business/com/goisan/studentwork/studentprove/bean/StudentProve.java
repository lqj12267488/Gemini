package com.goisan.studentwork.studentprove.bean;

import com.goisan.system.bean.BaseBean;

public class StudentProve extends BaseBean {
    private String id;
    private String requester;//申请人
    private String requestDate;//申请日期
    private String proveReason;//证明原因
    private String receiveCompany;//证明接收单位
    private String requestFlag;//请求状态
    private String feedBack;//反馈意见
    private String feedbackFlag;//反馈状态
    private String studentNumber; //学号
    private String majorCode;       //就读专业
    private String classId;         //班级Id
    private String studentId;       //学生Id
    private String studentName; //学生姓名
    private String deptId;
    private String sex;
    private String years;
    private String headTeacher;
    private String classType;
    private String idcard;
    private String maxYear;
    private String tels;
    private String year;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public String getProveReason() {
        return proveReason;
    }

    public void setProveReason(String proveReason) {
        this.proveReason = proveReason;
    }

    public String getReceiveCompany() {
        return receiveCompany;
    }

    public void setReceiveCompany(String receiveCompany) {
        this.receiveCompany = receiveCompany;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getFeedBack() {
        return feedBack;
    }

    public void setFeedBack(String feedBack) {
        this.feedBack = feedBack;
    }

    public String getFeedbackFlag() {
        return feedbackFlag;
    }

    public void setFeedbackFlag(String feedbackFlag) {
        this.feedbackFlag = feedbackFlag;
    }

    public String getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(String studentNumber) {
        this.studentNumber = studentNumber;
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

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getYears() {
        return years;
    }

    public void setYears(String years) {
        this.years = years;
    }

    public String getHeadTeacher() {
        return headTeacher;
    }

    public void setHeadTeacher(String headTeacher) {
        this.headTeacher = headTeacher;
    }

    public String getClassType() {
        return classType;
    }

    public void setClassType(String classType) {
        this.classType = classType;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getMaxYear() {
        return maxYear;
    }

    public void setMaxYear(String maxYear) {
        this.maxYear = maxYear;
    }

    public String getTels() {
        return tels;
    }

    public void setTels(String tels) {
        this.tels = tels;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }
}
