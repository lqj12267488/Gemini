package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class SchIncome extends BaseBean {

    /**主键id，使用uuid*/
    private String id;

    /**学生类别*/
    private String sfStuType;

    /**标准（元/生）*/
    private String sfStd;

    /**金额（万元）*/
    private String sfMoney;

    /**项目名称（全称）*/
    private String awProName;

    /**补助标准*/
    private String awStd;

    /**项目金额*/
    private String awProMoney;

    /**项目名称（全称）*/
    private String finProName;

    /**项目金额（万元）*/
    private String finProMoney;

    /**年份*/
    private String year;

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    public String getSfStuType() {
        return sfStuType;
    }

    public void setSfStuType(String sfStuType) {
        this.sfStuType = sfStuType;
    }

    public String getSfStd() {
        return sfStd;
    }

    public void setSfStd(String sfStd) {
        this.sfStd = sfStd;
    }

    public String getSfMoney() {
        return sfMoney;
    }

    public void setSfMoney(String sfMoney) {
        this.sfMoney = sfMoney;
    }


    public String getAwProName() {
        return awProName;
    }

    public void setAwProName(String awProName) {
        this.awProName = awProName;
    }

    public String getAwStd() {
        return awStd;
    }

    public void setAwStd(String awStd) {
        this.awStd = awStd;
    }

    public String getAwProMoney() {
        return awProMoney;
    }

    public void setAwProMoney(String awProMoney) {
        this.awProMoney = awProMoney;
    }

    public String getFinProName() {
        return finProName;
    }

    public void setFinProName(String finProName) {
        this.finProName = finProName;
    }

    public String getFinProMoney() {
        return finProMoney;
    }

    public void setFinProMoney(String finProMoney) {
        this.finProMoney = finProMoney;
    }

}
