package com.goisan.educational.major.bean;

import com.goisan.system.bean.BaseBean;

public class ResearchResult extends BaseBean {

    private String id;
    //关联的表数据id
    private String majorLeaderId;
    //项目名称
    private String name;
    //获奖等级
    private String getPrizeClass;
    //项目简介
    private String  detail;
    //获取日期
    private String getDate;
    //合作情况
    private String cooperationDetail;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMajorLeaderId() {
        return majorLeaderId;
    }

    public void setMajorLeaderId(String majorLeaderId) {
        this.majorLeaderId = majorLeaderId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGetPrizeClass() {
        return getPrizeClass;
    }

    public void setGetPrizeClass(String getPrizeClass) {
        this.getPrizeClass = getPrizeClass;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getGetDate() {
        return getDate;
    }

    public void setGetDate(String getDate) {
        this.getDate = getDate;
    }

    public String getCooperationDetail() {
        return cooperationDetail;
    }

    public void setCooperationDetail(String cooperationDetail) {
        this.cooperationDetail = cooperationDetail;
    }
}
