package com.goisan.studentwork.payment.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/10/25.
 */
public class PaymentPlan extends BaseBean {


    private String planId;
    private String planName;
    private String year;
    private String term;
    private String startTime;
    private String endTime;
    private String planItem;
    private String termShow;
    private String planItemShow;


    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getPlanItem() {
        return planItem;
    }

    public void setPlanItem(String planItem) {
        this.planItem = planItem;
    }


    public String getTermShow() {
        return termShow;
    }

    public void setTermShow(String termShow) {
        this.termShow = termShow;
    }

    public String getPlanItemShow() {
        return planItemShow;
    }

    public void setPlanItemShow(String planItemShow) {
        this.planItemShow = planItemShow;
    }
}
