package com.goisan.personnel.leave.bean;


import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/7/21.
 */
public class LeaveCancel extends Leave{
    private String id;
    private String leaveId;//请假申请ID
    private String cancelRequestDept;//申请销假部门
    private String cancelRequester;//申请销假人
    private String cancelRequestDate;//申请销假日期
    private String cancelStartTime;//销假开始时间
    private String cancelEndTime;//销假结束时间
    private String cancelReason;//销假说明
    private String realDays;//实际请假天数
    private String requestFlag;//请求状态
    private String feedBack;//反馈意见
    private String feedbackFlag;//反馈状态


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(String leaveId) {
        this.leaveId = leaveId;
    }

    public String getCancelRequestDept() {
        return cancelRequestDept;
    }

    public void setCancelRequestDept(String cancelRequestDept) {
        this.cancelRequestDept = cancelRequestDept;
    }

    public String getCancelRequester() {
        return cancelRequester;
    }

    public void setCancelRequester(String cancelRequester) {
        this.cancelRequester = cancelRequester;
    }

    public String getCancelRequestDate() {
        return cancelRequestDate;
    }

    public void setCancelRequestDate(String cancelRequestDate) {
        this.cancelRequestDate = cancelRequestDate;
    }

    public String getCancelStartTime() {
        return cancelStartTime;
    }

    public void setCancelStartTime(String cancelStartTime) {
        this.cancelStartTime = cancelStartTime;
    }

    public String getCancelEndTime() {
        return cancelEndTime;
    }

    public void setCancelEndTime(String cancelEndTime) {
        this.cancelEndTime = cancelEndTime;
    }

    public String getCancelReason() {
        return cancelReason;
    }

    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }

    public String getRealDays() {
        return realDays;
    }

    public void setRealDays(String realDays) {
        this.realDays = realDays;
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
