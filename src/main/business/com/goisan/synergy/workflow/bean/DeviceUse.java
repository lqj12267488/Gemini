package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;
/**
 * Created by Administrator on 2017/5/6/006.
 */
 public class DeviceUse extends BaseBean {
    private String id;
    private String deviceName;
    private String requestDept;
    private String requestDate;
    private String requester;
    private String manager;
    private String reason;
    private String remark;
    private String requestFlag;
    private String feedback;
    private String feedbackFlag;
    private String deviceUseNameShow;

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getDeviceUseNameShow() {
        return deviceUseNameShow;
    }

    public void setDeviceUseNameShow(String deviceUseNameShow) {
        this.deviceUseNameShow = deviceUseNameShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
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

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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
}
