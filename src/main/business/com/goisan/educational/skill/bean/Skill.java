package com.goisan.educational.skill.bean;

import com.goisan.system.bean.BaseBean;

public class Skill extends BaseBean{
    private String id;
    private String projectName;
    private String appraisalTime;
    private String appraisalCompany;
    private String appraisalNumber;
    private String projectLevel;
    private String issuingOffice;

    public String getProjectLevel() {
        return projectLevel;
    }

    public void setProjectLevel(String projectLevel) {
        this.projectLevel = projectLevel;
    }

    public String getIssuingOffice() {
        return issuingOffice;
    }

    public void setIssuingOffice(String issuingOffice) {
        this.issuingOffice = issuingOffice;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getAppraisalTime() {
        return appraisalTime;
    }

    public void setAppraisalTime(String appraisalTime) {
        this.appraisalTime = appraisalTime;
    }

    public String getAppraisalCompany() {
        return appraisalCompany;
    }

    public void setAppraisalCompany(String appraisalCompany) {
        this.appraisalCompany = appraisalCompany;
    }

    public String getAppraisalNumber() {
        return appraisalNumber;
    }

    public void setAppraisalNumber(String appraisalNumber) {
        this.appraisalNumber = appraisalNumber;
    }
}
