package com.goisan.personnel.leave.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/7/20.
 */
public class Leave extends BaseBean {
    private String id;
    private String requestDept;//申请部门
    private String requester;//申请人
    private String requestDate;//申请日期
    private String startTime;//请假开始时间
    private String endTime;//请假结束时间
    private String requestDays;//申请天数
    private String leaveType;//请假类型，使用QJLX字典
    private String leaveTypeShow;
    private String reason;//请假原因
    private String requestFlag;//请求状态
    private String feedBack;//反馈意见
    private String feedbackFlag;//反馈状态

    public String getLeaveTypeShow() {
        return leaveTypeShow;
    }

    public void setLeaveTypeShow(String leaveTypeShow) {
        this.leaveTypeShow = leaveTypeShow;
    }

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

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getRequestDays() {
        return requestDays;
    }

    public void setRequestDays(String requestDays) {
        this.requestDays = requestDays;
    }

    public String getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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

}
