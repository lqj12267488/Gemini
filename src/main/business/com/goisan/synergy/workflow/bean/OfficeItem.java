package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

import java.text.SimpleDateFormat;
import java.util.Date;
/**
 * Created by Administrator on 2017/5/6 0006.
 */
public class OfficeItem extends BaseBean {
    private String id;
    private String requester;
    private String requestDept;
    private String requestDate;
    private String remark;
    private String itemName;
    private String itemNumber;
    private String requestFlag;
    private String feedback;
    private String feedbackFlag;
    private String itemNameShow;

    public String getItemNameShow() {
        return itemNameShow;
    }

    public void setItemNameShow(String itemNameShow) {
        this.itemNameShow = itemNameShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
        /*SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date=new java.util.Date();
        String str=sdf.format(date);*/
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

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemNumber() {
        return itemNumber;
    }

    public void setItemNumber(String itemNumber) {
        this.itemNumber = itemNumber;
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
