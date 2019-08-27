package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/6/28.
 */
public class ScreenUse extends BaseBean{
    private String id;//id号
    private String screen;//大屏幕
    private String requestDept;//申请部门
    private String requestTime;//申请部门
    private String requestDate;//申请时间
    private String requester;//申请人
    private String content;//申请内容
    private String usingTime;//使用时间
    private String remark;//备注
    private String requestFlag;//请求状态
    private String feedback;//反馈意见
    private String feedbackFlag;//反馈状态
    private String screenShow;//多选大屏幕

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getScreen() {
        return screen;
    }

    public void setScreen(String screen) {
        this.screen = screen;
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

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUsingTime() {
        return usingTime;
    }

    public void setUsingTime(String usingTime) {
        this.usingTime = usingTime;
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

    public String getScreenShow() {
        return screenShow;
    }

    public void setScreenShow(String screenShow) {
        this.screenShow = screenShow;
    }

    public String getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(String requestTime) {
        this.requestTime = requestTime;
    }
}
