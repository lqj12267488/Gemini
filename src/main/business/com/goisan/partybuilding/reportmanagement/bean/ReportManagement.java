package com.goisan.partybuilding.reportmanagement.bean;

import com.goisan.system.bean.BaseBean;

public class ReportManagement extends BaseBean {
    private String id;
    private String manager;      //申请人
    private String requestDept; //申请部门
    private String requestDate;//申请日期
    private String requestFlag;
    private String feedback;
    private String feedbackFlag;
    private String reportContent;//申诉内容
    private String reportType;//申诉类型
    private String reportTypeShow;
    private String studentTeacherType;

    public String getStudentTeacherType() {
        return studentTeacherType;
    }

    public void setStudentTeacherType(String studentTeacherType) {
        this.studentTeacherType = studentTeacherType;
    }

    public String getReportTypeShow() {
        return reportTypeShow;
    }

    public void setReportTypeShow(String reportTypeShow) {
        this.reportTypeShow = reportTypeShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public String getRequestDept() {
        return requestDept;
    }

    public void setRequestDept(String requestDept) {
        this.requestDept = requestDept;
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

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getFeedbackFlag() {
        return feedbackFlag;
    }

    public void setFeedbackFlag(String feedbackFlag) {
        this.feedbackFlag = feedbackFlag;
    }

    public String getReportContent() {
        return reportContent;
    }

    public void setReportContent(String reportContent) {
        this.reportContent = reportContent;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }
}
