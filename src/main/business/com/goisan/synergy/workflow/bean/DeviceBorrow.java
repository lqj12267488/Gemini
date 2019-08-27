package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/7/20.
 */
public class DeviceBorrow extends BaseBean {
    private String id;
    private String requestDept;//申请部门
    private String requester;//申请人
    private String requestDate;//申请日期
    private String borrowTime;//借用时间
    private String revertTime;//归还时间
    private String deviceList;//清单列表
    private String activityContent;//活动内容
    private String requestFlag;//请求状态
    private String feedBack;//反馈意见
    private String feedbackFlag;//反馈状态

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

    public String getBorrowTime() {
        return borrowTime;
    }

    public void setBorrowTime(String borrowTime) {
        this.borrowTime = borrowTime;
    }

    public String getRevertTime() {
        return revertTime;
    }

    public void setRevertTime(String revertTime) {
        this.revertTime = revertTime;
    }

    public String getDeviceList() {
        return deviceList;
    }

    public void setDeviceList(String deviceList) {
        this.deviceList = deviceList;
    }

    public String getActivityContent() {
        return activityContent;
    }

    public void setActivityContent(String activityContent) {
        this.activityContent = activityContent;
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
