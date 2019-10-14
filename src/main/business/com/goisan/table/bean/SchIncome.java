package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class SchIncome extends BaseBean {

    /**主键id，使用uuid*/
    private String id;

    /**学校总收入*/
    private String incomeAll;

    /**学费合计收入*/
    private String sfAll;

    /**学费序号*/
    private String sfInd;

    /**学生类别*/
    private String sfStuType;

    /**标准（元/生）*/
    private String sfStd;

    /**金额（万元）*/
    private String sfMoney;

    /**补助收入合计*/
    private String awAll;

    /**补助序号*/
    private String awIndex;

    /**项目名称（全称）*/
    private String awProName;

    /**补助标准*/
    private String awStd;

    /**项目金额*/
    private String awProMoney;

    /**财政专项投入合计*/
    private String finAll;

    /**序号*/
    private String finIndex;

    /**项目名称（全称）*/
    private String finProName;

    /**项目金额（万元）*/
    private String finProMoney;

    /**社会捐赠金额（万元）*/
    private String ssDonate;

    /**其他收入总额*/
    private String otherIncome;

    /**贷款金额（万元）*/
    private String loan;

    /**贷款余额（万元）*/
    private String loanBal;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIncomeAll() {
        return incomeAll;
    }

    public void setIncomeAll(String incomeAll) {
        this.incomeAll = incomeAll;
    }

    public String getSfAll() {
        return sfAll;
    }

    public void setSfAll(String sfAll) {
        this.sfAll = sfAll;
    }

    public String getSfInd() {
        return sfInd;
    }

    public void setSfInd(String sfInd) {
        this.sfInd = sfInd;
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

    public String getAwAll() {
        return awAll;
    }

    public void setAwAll(String awAll) {
        this.awAll = awAll;
    }

    public String getAwIndex() {
        return awIndex;
    }

    public void setAwIndex(String awIndex) {
        this.awIndex = awIndex;
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

    public String getFinAll() {
        return finAll;
    }

    public void setFinAll(String finAll) {
        this.finAll = finAll;
    }

    public String getFinIndex() {
        return finIndex;
    }

    public void setFinIndex(String finIndex) {
        this.finIndex = finIndex;
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

    public String getSsDonate() {
        return ssDonate;
    }

    public void setSsDonate(String ssDonate) {
        this.ssDonate = ssDonate;
    }

    public String getOtherIncome() {
        return otherIncome;
    }

    public void setOtherIncome(String otherIncome) {
        this.otherIncome = otherIncome;
    }

    public String getLoan() {
        return loan;
    }

    public void setLoan(String loan) {
        this.loan = loan;
    }

    public String getLoanBal() {
        return loanBal;
    }

    public void setLoanBal(String loanBal) {
        this.loanBal = loanBal;
    }

}
