package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/7/18.
 */
public class SalaryApproval extends BaseBean {
    private String id;
    private String requestDept;//申请部门
    private String requester;//申请人
    private String requestDate;//申请日期
    private String year;//工资年份
    private String month;//工资月份
    private String remark;//备注
    private String fileName;//工资单名称
    private String fileUrl;//工资单路径
    private String fileType;//工资单类型
    private String requestFlag;//请求状态
    private String feedBack;//反馈意见
    private String feedbackFlag;//反馈状态
    private String requesterConfirmFlag;//申请人确认状态

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRequestDept() {
        return requestDept;
    }

    public void setRequestDept(String requestDept) {
        this.requestDept = requestDept;
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

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
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

    public String getRequesterConfirmFlag() {
        return requesterConfirmFlag;
    }

    public void setRequesterConfirmFlag(String requesterConfirmFlag) {
        this.requesterConfirmFlag = requesterConfirmFlag;
    }
}
