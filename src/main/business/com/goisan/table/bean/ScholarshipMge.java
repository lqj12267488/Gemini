package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class ScholarshipMge extends BaseBean {

    /**主键id，使用uuid*/
    private String id;

    /**项目名称*/
    private String smProName;

    /**项目种类{	jzxxmzl}*/
    private String smProType;

   private String smProTypeShow;

    /**奖助范围*/
    private String aidRge;

    /**奖助人数*/
    private String aidCounts;

    /**奖助金额*/
    private String aidMoney;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSmProName() {
        return smProName;
    }

    public void setSmProName(String smProName) {
        this.smProName = smProName;
    }

    public String getSmProType() {
        return smProType;
    }

    public void setSmProType(String smProType) {
        this.smProType = smProType;
    }

    public String getSmProTypeShow() {
        return smProTypeShow;
    }

    public void setSmProTypeShow(String smProTypeShow) {
        this.smProTypeShow = smProTypeShow;
    }

    public String getAidRge() {
        return aidRge;
    }

    public void setAidRge(String aidRge) {
        this.aidRge = aidRge;
    }

    public String getAidCounts() {
        return aidCounts;
    }

    public void setAidCounts(String aidCounts) {
        this.aidCounts = aidCounts;
    }

    public String getAidMoney() {
        return aidMoney;
    }

    public void setAidMoney(String aidMoney) {
        this.aidMoney = aidMoney;
    }

}
