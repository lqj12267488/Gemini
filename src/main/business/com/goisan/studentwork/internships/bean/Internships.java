package com.goisan.studentwork.internships.bean;

/**
 * Created by hanyu on 2017/7/31.
 */

public class Internships extends InternshipExt {
    private String internshipUnitId;//实习单位id
    private String internshipUnitName;//企业名称
    private String area;//所在地区
    private String address;//地址
    private String contactPerson;//联系人
    private String contactNumber;//联系电话
    private String employmentUnitFlag;//是否就业单位，使用SF字典。0否，1是
    private String internshipWhetherRetention;//实习生是否留用
    private String cooperationTime;//合作时间
    private String enterprisePersonNumber;//企业员工数
    private String registeredCapital;//注册资金
    private String enterpriseNature;//企业性质
    private String legalPerson;//法人代表
    private String enterpriseScale;//企业规模
    private String enterpriseNatureShow;
    private String cooperationTimeShow;
    private String internshipWhetherRetentionShow;
    private String enterpriseScaleShow;

    public String getInternshipWhetherRetention() {
        return internshipWhetherRetention;
    }

    public void setInternshipWhetherRetention(String internshipWhetherRetention) {
        this.internshipWhetherRetention = internshipWhetherRetention;
    }

    public String getCooperationTime() {
        return cooperationTime;
    }

    public void setCooperationTime(String cooperationTime) {
        this.cooperationTime = cooperationTime;
    }

    public String getEnterprisePersonNumber() {
        return enterprisePersonNumber;
    }

    public void setEnterprisePersonNumber(String enterprisePersonNumber) {
        this.enterprisePersonNumber = enterprisePersonNumber;
    }

    public String getRegisteredCapital() {
        return registeredCapital;
    }

    public void setRegisteredCapital(String registeredCapital) {
        this.registeredCapital = registeredCapital;
    }

    public String getEnterpriseNature() {
        return enterpriseNature;
    }

    public void setEnterpriseNature(String enterpriseNature) {
        this.enterpriseNature = enterpriseNature;
    }

    public String getLegalPerson() {
        return legalPerson;
    }

    public void setLegalPerson(String legalPerson) {
        this.legalPerson = legalPerson;
    }

    @Override
    public String getInternshipUnitId() {
        return internshipUnitId;
    }

    @Override
    public void setInternshipUnitId(String internshipUnitId) {
        this.internshipUnitId = internshipUnitId;
    }

    public String getInternshipUnitName() {
        return internshipUnitName;
    }

    public void setInternshipUnitName(String internshipUnitName) {
        this.internshipUnitName = internshipUnitName;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getEmploymentUnitFlag() {
        return employmentUnitFlag;
    }

    public void setEmploymentUnitFlag(String employmentUnitFlag) {
        this.employmentUnitFlag = employmentUnitFlag;
    }

    public String getEnterpriseNatureShow() {
        return enterpriseNatureShow;
    }

    public void setEnterpriseNatureShow(String enterpriseNatureShow) {
        this.enterpriseNatureShow = enterpriseNatureShow;
    }

    public String getCooperationTimeShow() {
        return cooperationTimeShow;
    }

    public void setCooperationTimeShow(String cooperationTimeShow) {
        this.cooperationTimeShow = cooperationTimeShow;
    }

    public String getInternshipWhetherRetentionShow() {
        return internshipWhetherRetentionShow;
    }

    public void setInternshipWhetherRetentionShow(String internshipWhetherRetentionShow) {
        this.internshipWhetherRetentionShow = internshipWhetherRetentionShow;
    }

    public String getEnterpriseScale() {
        return enterpriseScale;
    }

    public void setEnterpriseScale(String enterpriseScale) {
        this.enterpriseScale = enterpriseScale;
    }

    public String getEnterpriseScaleShow() {
        return enterpriseScaleShow;
    }

    public void setEnterpriseScaleShow(String enterpriseScaleShow) {
        this.enterpriseScaleShow = enterpriseScaleShow;
    }
}
