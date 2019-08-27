package com.goisan.educational.textbook.bean;


import com.goisan.system.bean.BaseBean;

public class TextBookPlan extends BaseBean {

    private String id;
    //计划名称
    private String planName;
    //计划学期
    private String term;
    //计划开始时间
    private String startTime;
    //计划结束时间
    private String endTime;
    //显示学期
    private String termShow;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
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

    public String getTermShow() {
        return termShow;
    }

    public void setTermShow(String termShow) {
        this.termShow = termShow;
    }
}