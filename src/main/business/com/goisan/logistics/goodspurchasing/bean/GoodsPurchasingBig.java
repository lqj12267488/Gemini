package com.goisan.logistics.goodspurchasing.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by 123456 on 2018/3/30.
 */
public class GoodsPurchasingBig extends BaseBean {
    private String id;
    private String goodsBigName;
    private String goodsBigNum;
    private String reason;
    private Double budget;
    private String requester;
    private String requestDept;
    private String requestDate;
    private String remark;
    private String requestFlag;
    private String feedback;
    private String feedbackFlag;
    private String unit;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGoodsBigName() {
        return goodsBigName;
    }

    public void setGoodsBigName(String goodsBigName) {
        this.goodsBigName = goodsBigName;
    }

    public String getGoodsBigNum() {
        return goodsBigNum;
    }

    public void setGoodsBigNum(String goodsBigNum) {
        this.goodsBigNum = goodsBigNum;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Double getBudget() {
        return budget;
    }

    public void setBudget(Double budget) {
        this.budget = budget;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
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

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
}
