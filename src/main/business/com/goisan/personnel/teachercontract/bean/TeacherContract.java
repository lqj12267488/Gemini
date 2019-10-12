package com.goisan.personnel.teachercontract.bean;

import com.goisan.system.bean.BaseBean;

public class TeacherContract extends BaseBean {

    /**主键，使用uuid*/
    private String id;

    private String deptId;

    private String deptShow;

    private String idcard;

    /**教职工id，使用uuid*/
    private String personId;

    /**合同类型{jsht}*/
    private String contractType;

   private String contractTypeShow;

   private String startTime;

   private String endTime;

   private String contractPeriod;

    /**开始时间*/
    private String syStartTime;

    /**截止时间*/
    private String syEndTime;

    /**合同期限*/
    private String syContractPeriod;

    private String firstStartTime;

    private String firstEndTime;

    private String firstContractPeriod;

    private String secStartTime;

    private String secEndTime;

    private String secContractPeriod;

    private String thirdStartTime;

    private String thirdEndTime;

    private String thirdContractPeriod;

    private String jzStartTime;

    private String jzEndTime;

    private String jzContractPeriod;

    /**转正日期*/
    private String positiveTime;

    /**人员性质{ryxz}*/
    private String personNature;

   private String personNatureShow;

    /**退休证明*/
    private String retireCert;

    /**份数*/
    private String nums;

    /**校龄*/
    private String schoolAge;

    /**保密协议*/
    private String confidentAgreement;

    /**试用期工资*/
    private String trpidSalary;

    /**转正工资*/
    private String positiveSalary;

    /**转正系数*/
    private String positiveCoff;

    /**离职日期*/
    private String retireTime;

    /**是否退休*/
    private String retireNy;

    /**社保号*/
    private String ssnumber;

    /**数量*/
    private String counts;

    private String name;

    /**预到期*/
    private String fature;

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

    public String getContractPeriod() {
        return contractPeriod;
    }

    public void setContractPeriod(String contractPeriod) {
        this.contractPeriod = contractPeriod;
    }

    public String getSyStartTime() {
        return syStartTime;
    }

    public void setSyStartTime(String syStartTime) {
        this.syStartTime = syStartTime;
    }

    public String getSyEndTime() {
        return syEndTime;
    }

    public void setSyEndTime(String syEndTime) {
        this.syEndTime = syEndTime;
    }

    public String getSyContractPeriod() {
        return syContractPeriod;
    }

    public void setSyContractPeriod(String syContractPeriod) {
        this.syContractPeriod = syContractPeriod;
    }

    public String getFirstStartTime() {
        return firstStartTime;
    }

    public void setFirstStartTime(String firstStartTime) {
        this.firstStartTime = firstStartTime;
    }

    public String getFirstEndTime() {
        return firstEndTime;
    }

    public void setFirstEndTime(String firstEndTime) {
        this.firstEndTime = firstEndTime;
    }

    public String getFirstContractPeriod() {
        return firstContractPeriod;
    }

    public void setFirstContractPeriod(String firstContractPeriod) {
        this.firstContractPeriod = firstContractPeriod;
    }

    public String getSecStartTime() {
        return secStartTime;
    }

    public void setSecStartTime(String secStartTime) {
        this.secStartTime = secStartTime;
    }

    public String getSecEndTime() {
        return secEndTime;
    }

    public void setSecEndTime(String secEndTime) {
        this.secEndTime = secEndTime;
    }

    public String getSecContractPeriod() {
        return secContractPeriod;
    }

    public void setSecContractPeriod(String secContractPeriod) {
        this.secContractPeriod = secContractPeriod;
    }

    public String getThirdStartTime() {
        return thirdStartTime;
    }

    public void setThirdStartTime(String thirdStartTime) {
        this.thirdStartTime = thirdStartTime;
    }

    public String getThirdEndTime() {
        return thirdEndTime;
    }

    public void setThirdEndTime(String thirdEndTime) {
        this.thirdEndTime = thirdEndTime;
    }

    public String getThirdContractPeriod() {
        return thirdContractPeriod;
    }

    public void setThirdContractPeriod(String thirdContractPeriod) {
        this.thirdContractPeriod = thirdContractPeriod;
    }

    public String getJzStartTime() {
        return jzStartTime;
    }

    public void setJzStartTime(String jzStartTime) {
        this.jzStartTime = jzStartTime;
    }

    public String getJzEndTime() {
        return jzEndTime;
    }

    public void setJzEndTime(String jzEndTime) {
        this.jzEndTime = jzEndTime;
    }

    public String getJzContractPeriod() {
        return jzContractPeriod;
    }

    public void setJzContractPeriod(String jzContractPeriod) {
        this.jzContractPeriod = jzContractPeriod;
    }

    public String getFature() {
        return fature;
    }

    public void setFature(String fature) {
        this.fature = fature;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getDeptShow() {
        return deptShow;
    }

    public void setDeptShow(String deptShow) {
        this.deptShow = deptShow;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getContractType() {
        return contractType;
    }

    public void setContractType(String contractType) {
        this.contractType = contractType;
    }

    public String getContractTypeShow() {
        return contractTypeShow;
    }

    public void setContractTypeShow(String contractTypeShow) {
        this.contractTypeShow = contractTypeShow;
    }

    public String getPositiveTime() {
        return positiveTime;
    }

    public void setPositiveTime(String positiveTime) {
        this.positiveTime = positiveTime;
    }

    public String getPersonNature() {
        return personNature;
    }

    public void setPersonNature(String personNature) {
        this.personNature = personNature;
    }

    public String getPersonNatureShow() {
        return personNatureShow;
    }

    public void setPersonNatureShow(String personNatureShow) {
        this.personNatureShow = personNatureShow;
    }

    public String getRetireCert() {
        return retireCert;
    }

    public void setRetireCert(String retireCert) {
        this.retireCert = retireCert;
    }

    public String getNums() {
        return nums;
    }

    public void setNums(String nums) {
        this.nums = nums;
    }

    public String getSchoolAge() {
        return schoolAge;
    }

    public void setSchoolAge(String schoolAge) {
        this.schoolAge = schoolAge;
    }

    public String getConfidentAgreement() {
        return confidentAgreement;
    }

    public void setConfidentAgreement(String confidentAgreement) {
        this.confidentAgreement = confidentAgreement;
    }

    public String getTrpidSalary() {
        return trpidSalary;
    }

    public void setTrpidSalary(String trpidSalary) {
        this.trpidSalary = trpidSalary;
    }

    public String getPositiveSalary() {
        return positiveSalary;
    }

    public void setPositiveSalary(String positiveSalary) {
        this.positiveSalary = positiveSalary;
    }

    public String getPositiveCoff() {
        return positiveCoff;
    }
    public void setPositiveCoff(String positiveCoff) {
        this.positiveCoff = positiveCoff;
    }

    public String getRetireTime() {
        return retireTime;
    }

    public void setRetireTime(String retireTime) {
        this.retireTime = retireTime;
    }

    public String getRetireNy() {
        return retireNy;
    }

    public void setRetireNy(String retireNy) {
        this.retireNy = retireNy;
    }

    public String getSsnumber() {
        return ssnumber;
    }

    public void setSsnumber(String ssnumber) {
        this.ssnumber = ssnumber;
    }

    public String getCounts() {
        return counts;
    }

    public void setCounts(String counts) {
        this.counts = counts;
    }

}
