package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/25.
 */
public class Photography extends BaseBean {
    private String id;
    //拍摄时间
    private String shootDate;
    private String shootTime;
    //活动内容
    private String content;
    //摄像机机位数
    private String machineNumber;
    //拍摄方法
    private String shootingMethod;
    private String dateTime;
    private String requestDept;
    private String requester;
    private String requestDate;
    private String validFlag;
    private String feedBack;
    private String requestFlag;
    private String feedbackFlag;
    private String shootingLocation;

    public String getShootTime() {
        return shootTime;
    }

    public void setShootTime(String shootTime) {
        this.shootTime = shootTime;
    }

    public String getShootingLocation() {
        return shootingLocation;
    }

    public void setShootingLocation(String shootingLocation) {
        this.shootingLocation = shootingLocation;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getShootDate() {
        return shootDate;
    }

    public void setShootDate(String shootDate) {
        this.shootDate = shootDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getMachineNumber() {
        return machineNumber;
    }

    public void setMachineNumber(String machineNumber) {
        this.machineNumber = machineNumber;
    }

    public String getShootingMethod() {
        return shootingMethod;
    }

    public void setShootingMethod(String shootingMethod) {
        this.shootingMethod = shootingMethod;
    }

    public String getDateTime() {
        return dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
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

    @Override
    public String getValidFlag() {
        return validFlag;
    }

    @Override
    public void setValidFlag(String validFlag) {
        this.validFlag = validFlag;
    }

    public String getFeedBack() {
        return feedBack;
    }

    public void setFeedBack(String feedBack) {
        this.feedBack = feedBack;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getFeedbackFlag() {
        return feedbackFlag;
    }

    public void setFeedbackFlag(String feedbackFlag) {
        this.feedbackFlag = feedbackFlag;
    }
}
