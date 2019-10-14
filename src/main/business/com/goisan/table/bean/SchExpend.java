package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class SchExpend extends BaseBean {

    /**主键id，使用uuid*/
    private String id;

    /**学校总支出（万元）*/
    private String expAll;

    /**征地（万元）*/
    private String land;

    /**基础设施建设（万元）*/
    private String expInf;

    /**设备采购（万元）合计*/
    private String expDevAll;

    /**教学科研仪器设备值*/
    private String expTeachDev;

    /**实(验)训耗材*/
    private String trainCost;

    /**实习专项*/
    private String trainPro;

    /**聘请兼职教师经费*/
    private String hirePtTeach;

    /**体育维持费*/
    private String sport;

    /**其他日常教学经费*/
    private String dailyOth;

    /**教学改革及研究合计经费*/
    private String rsAll;

    /**序号*/
    private String rsInd;

    /**项目名称（全称）*/
    private String rsProName;

    /**项目金额*/
    private String rsProMoney;

    /**师资建设合计（万元）*/
    private String tcAll;

    /**序号*/
    private String tcInd;

    /**项目名称（全称）*/
    private String tcProName;

    /**项目金额*/
    private String tcProMoney;

    /**图书购置费*/
    private String libCost;

    /**其他总支持*/
    private String othCost;

    /**还贷金额（万元）*/
    private String payLoan;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getExpAll() {
        return expAll;
    }

    public void setExpAll(String expAll) {
        this.expAll = expAll;
    }

    public String getLand() {
        return land;
    }

    public void setLand(String land) {
        this.land = land;
    }

    public String getExpInf() {
        return expInf;
    }

    public void setExpInf(String expInf) {
        this.expInf = expInf;
    }

    public String getExpDevAll() {
        return expDevAll;
    }

    public void setExpDevAll(String expDevAll) {
        this.expDevAll = expDevAll;
    }

    public String getExpTeachDev() {
        return expTeachDev;
    }

    public void setExpTeachDev(String expTeachDev) {
        this.expTeachDev = expTeachDev;
    }

    public String getTrainCost() {
        return trainCost;
    }

    public void setTrainCost(String trainCost) {
        this.trainCost = trainCost;
    }

    public String getTrainPro() {
        return trainPro;
    }

    public void setTrainPro(String trainPro) {
        this.trainPro = trainPro;
    }

    public String getHirePtTeach() {
        return hirePtTeach;
    }

    public void setHirePtTeach(String hirePtTeach) {
        this.hirePtTeach = hirePtTeach;
    }

    public String getSport() {
        return sport;
    }

    public void setSport(String sport) {
        this.sport = sport;
    }

    public String getDailyOth() {
        return dailyOth;
    }

    public void setDailyOth(String dailyOth) {
        this.dailyOth = dailyOth;
    }

    public String getRsAll() {
        return rsAll;
    }

    public void setRsAll(String rsAll) {
        this.rsAll = rsAll;
    }

    public String getRsInd() {
        return rsInd;
    }

    public void setRsInd(String rsInd) {
        this.rsInd = rsInd;
    }

    public String getRsProName() {
        return rsProName;
    }

    public void setRsProName(String rsProName) {
        this.rsProName = rsProName;
    }

    public String getRsProMoney() {
        return rsProMoney;
    }

    public void setRsProMoney(String rsProMoney) {
        this.rsProMoney = rsProMoney;
    }

    public String getTcAll() {
        return tcAll;
    }

    public void setTcAll(String tcAll) {
        this.tcAll = tcAll;
    }

    public String getTcInd() {
        return tcInd;
    }

    public void setTcInd(String tcInd) {
        this.tcInd = tcInd;
    }

    public String getTcProName() {
        return tcProName;
    }

    public void setTcProName(String tcProName) {
        this.tcProName = tcProName;
    }

    public String getTcProMoney() {
        return tcProMoney;
    }

    public void setTcProMoney(String tcProMoney) {
        this.tcProMoney = tcProMoney;
    }

    public String getLibCost() {
        return libCost;
    }

    public void setLibCost(String libCost) {
        this.libCost = libCost;
    }

    public String getOthCost() {
        return othCost;
    }

    public void setOthCost(String othCost) {
        this.othCost = othCost;
    }

    public String getPayLoan() {
        return payLoan;
    }

    public void setPayLoan(String payLoan) {
        this.payLoan = payLoan;
    }

}
