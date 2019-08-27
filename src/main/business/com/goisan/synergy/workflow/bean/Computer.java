package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/5/4.
 */
public class Computer extends BaseBean {
    private String id;
    private String requestdept;
    private String requester;
    private String reason;
    private String suppliesname;
    private String manager;
    private String requestdate;
    private String remark;
    private String feedbackflag;
    private String feedback;
    private String requestflag;
    private String suppliesnameShow;

    public String getSuppliesnameShow() {
        return suppliesnameShow;
    }

    public void setSuppliesnameShow(String suppliesnameShow) {
        this.suppliesnameShow = suppliesnameShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRequestdept() {
        return requestdept;
    }

    public void setRequestdept(String requestdept) {
        this.requestdept = requestdept;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public String getRequestdate() {
        return requestdate;
    }

    public void setRequestdate(String requestdate) {
        this.requestdate = requestdate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getFeedbackflag() {
        return feedbackflag;
    }

    public void setFeedbackflag(String feedbackflag) {
        this.feedbackflag = feedbackflag;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getRequestflag() {
        return requestflag;
    }

    public void setRequestflag(String requestflag) {
        this.requestflag = requestflag;
    }

    public String getSuppliesname() {
        return suppliesname;
    }

    public void setSuppliesname(String suppliesname) {
        this.suppliesname = suppliesname;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

}
