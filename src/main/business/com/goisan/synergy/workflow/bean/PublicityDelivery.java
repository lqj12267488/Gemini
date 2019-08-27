package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/13.
 */

public class PublicityDelivery extends BaseBean {
    private String id;//id号
    private String caption;//标题
    //图片,在另一张表里
    private String distributionChannels;//发布渠道
    private String distributionChannelsShow;//多选发布渠道
    private String requestDept;//申请部门
    private String requestDate;//申请时间
    private String requester;//申请人
    private String remark;//备注
    private String requestFlag;//请求状态
    private String feedback;//反馈意见
    private String feedbackFlag;//反馈状态
    private String requestTime;//申请时间

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }


    public String getDistributionChannels() {
        return distributionChannels;
    }

    public void setDistributionChannels(String distributionChannels) {
        this.distributionChannels = distributionChannels;
    }

    public String getDistributionChannelsShow() {
        return distributionChannelsShow;
    }

    public void setDistributionChannelsShow(String distributionChannelsShow) {
        this.distributionChannelsShow = distributionChannelsShow;
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

    public String getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(String requestTime) {
        this.requestTime = requestTime;
    }
}

