package com.goisan.studentwork.grantmanagement.bean;

import com.goisan.system.bean.BaseBean;

public class GrantManagement extends BaseBean {
    private String id;
    private String requester;//申请人
    private String requestDate;//申请日期
    private String requestFlag;//请求状态
    private String feedBack;//反馈意见
    private String feedbackFlag;//反馈状态
    private String departmentId;//系部
    private String majorCode;       //专业
    private String classId;         //班级Id
    private String studentId;       //学生Id
    private String studentName; //学生姓名
    private String sex;//性别
    private String grantManagementName;//奖助学金名称
    private String grantManagementTerm;//奖助学金所属学期
    private String deptId;
    private String years;
    private String headTeacher;
    private String sexShow;
    private String grantManagementTermShow;
    private String grantManagementNameShow;

    public String getGrantManagementNameShow() {
        return grantManagementNameShow;
    }

    public void setGrantManagementNameShow(String grantManagementNameShow) {
        this.grantManagementNameShow = grantManagementNameShow;
    }

    public String getSexShow() {
        return sexShow;
    }

    public void setSexShow(String sexShow) {
        this.sexShow = sexShow;
    }

    public String getGrantManagementTermShow() {
        return grantManagementTermShow;
    }

    public void setGrantManagementTermShow(String grantManagementTermShow) {
        this.grantManagementTermShow = grantManagementTermShow;
    }

    public String getHeadTeacher() {
        return headTeacher;
    }

    public void setHeadTeacher(String headTeacher) {
        this.headTeacher = headTeacher;
    }

    public String getYears() {
        return years;
    }

    public void setYears(String years) {
        this.years = years;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

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

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getGrantManagementName() {
        return grantManagementName;
    }

    public void setGrantManagementName(String grantManagementName) {
        this.grantManagementName = grantManagementName;
    }

    public String getGrantManagementTerm() {
        return grantManagementTerm;
    }

    public void setGrantManagementTerm(String grantManagementTerm) {
        this.grantManagementTerm = grantManagementTerm;
    }

}
