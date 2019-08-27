package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by znw on 2017/5/6.
 */
public class Stamp  extends BaseBean {
    private String id;
    private String requestDept;
    private String requestDate;
    private String manager;
    private String contractDetails;
    private String remark;
    private String stampFlag;
    private String stampFlagCode;
    private String requestFlag;
    private String feedBack;
    private String feedbackFlag;;
    private String stampFlagShow;

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

    public String getContractDetails() {
        return contractDetails;
    }

    public void setContractDetails(String contractDetails) {
        this.contractDetails = contractDetails;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStampFlag() {
        return stampFlag;
    }

    public void setStampFlag(String stampFlag) {
        this.stampFlag = stampFlag;
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

    public String getStampFlagShow() {
        return stampFlagShow;
    }

    public void setStampFlagShow(String stampFlagShow) {
        this.stampFlagShow = stampFlagShow;
    }

    public String getStampFlagCode() {
        return stampFlagCode;
    }

    public void setStampFlagCode(String stampFlagCode) {
        this.stampFlagCode = stampFlagCode;
    }
}
